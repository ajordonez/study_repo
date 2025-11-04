import argparse
import os
import time
from datetime import datetime
import requests
import gspread
from google.oauth2.service_account import Credentials
from dotenv import load_dotenv
import pytz

# ---------- Config ----------
def load_config():
    load_dotenv()
    cfg = {
        "IG_USER_ID": os.getenv("IG_USER_ID"),
        "TOKEN": os.getenv("LONG_LIVED_ACCESS_TOKEN"),
        "GRAPH_API_BASE": os.getenv("GRAPH_API_BASE", "https://graph.facebook.com/v21.0"),
        "SHEET_KEY": os.getenv("GOOGLE_SHEETS_SPREADSHEET_KEY"),
        "TZ": os.getenv("TIMEZONE", "America/New_York"),
    }
    for k, v in cfg.items():
        if not v:
            raise ValueError(f"Missing required env var: {k}")
    return cfg

def gspread_client():
    scopes = ["https://www.googleapis.com/auth/spreadsheets"]
    creds = Credentials.from_service_account_file("service_account.json", scopes=scopes)
    return gspread.authorize(creds)

# ---------- Instagram API ----------
def ig_get(url, params):
    r = requests.get(url, params=params, timeout=30)
    if r.status_code != 200:
        raise RuntimeError(f"IG API error {r.status_code}: {r.text}")
    return r.json()

def fetch_latest_media(cfg, limit=25):
    """
    Fetch latest media with enough fields to build requested columns.
    Note: reels are VIDEO with media_product_type='REELS'.
    """
    fields = ",".join([
        "id",
        "caption",
        "media_type",
        "media_product_type",
        "media_url",
        "permalink",
        "timestamp",
        "like_count",
        "comments_count",
    ])
    url = f"{cfg['GRAPH_API_BASE']}/{cfg['IG_USER_ID']}/media"
    params = {"fields": fields, "access_token": cfg["TOKEN"], "limit": min(50, max(1, limit))}
    data = ig_get(url, params)
    return data.get("data", [])[:limit]

def fetch_media_insights(cfg, media_id):
    """
    Metrics commonly available for media:
      impressions, reach, engagement, saved
    (Note: Shares is not exposed for standard media via Graph API.)
    """
    url = f"{cfg['GRAPH_API_BASE']}/{media_id}/insights"
    params = {"metric": "impressions,reach,engagement,saved", "access_token": cfg["TOKEN"]}
    data = ig_get(url, params)
    out = {}
    for m in data.get("data", []):
        name = m.get("name")
        vals = m.get("values", [])
        if vals:
            out[name] = vals[0].get("value")
    return out

# ---------- Sheets helpers ----------
def ensure_headers(ws, headers):
    existing = ws.row_values(1)
    if existing != headers:
        if not existing:
            ws.update("A1", [headers])
        else:
            ws.resize(rows=max(100, ws.row_count), cols=len(headers))
            ws.update("A1", [headers])

def upsert_by_key(ws, key_col_name, rows, headers):
    ensure_headers(ws, headers)
    header_pos = {h: i for i, h in enumerate(headers)}
    # Build index of existing by key
    records = ws.get_all_records()
    index = {}
    for i, r in enumerate(records, start=2):
        index[str(r.get(key_col_name, ""))] = i

    for r in rows:
        row_vals = [""] * len(headers)
        for k, v in r.items():
            if k in header_pos:
                row_vals[header_pos[k]] = v
        key = str(r.get(key_col_name, ""))
        if key in index:
            row_num = index[key]
            rng = gspread.utils.rowcol_to_a1(row_num, 1) + ":" + gspread.utils.rowcol_to_a1(row_num, len(headers))
            ws.update(rng, [row_vals])
        else:
            ws.append_row(row_vals)

# ---------- Transform helpers ----------
def map_post_type(media_type, media_product_type):
    """
    Desired Post Type: single image, carousel, reel.
    - CAROUSEL_ALBUM => 'carousel'
    - VIDEO + media_product_type == 'REELS' => 'reel'
    - IMAGE => 'single image'
    - fallback => product/type lower()
    """
    if media_type == "CAROUSEL_ALBUM":
        return "carousel"
    if media_type == "IMAGE":
        return "single image"
    if media_type == "VIDEO" and (media_product_type or "").upper() == "REELS":
        return "reel"
    return (media_product_type or media_type or "").lower()

def brief_description(caption, limit=120):
    if not caption:
        return ""
    c = caption.strip().replace("\n", " ").replace("\r", " ")
    return (c[:limit] + "…") if len(c) > limit else c

# ---------- Main ----------
def main():
    parser = argparse.ArgumentParser(description="Instagram → Google Sheets sync (custom columns)")
    parser.add_argument("--posts", type=int, default=25, help="Fetch latest N posts (media)")
    args = parser.parse_args()

    cfg = load_config()
    tz = pytz.timezone(cfg["TZ"])
    gc = gspread_client()
    sh = gc.open_by_key(cfg["SHEET_KEY"])

    headers = [
        "Date",
        "Time",
        "Post Type",
        "Brief Content Description",
        "Likes",
        "Comments",
        "Shares",
        "Saves",
        "Reach",
        "Impressions",
        "Permalink",
        "Media ID",
        "Synced At",
    ]

    try:
        ws = sh.worksheet("Posts")
    except gspread.WorksheetNotFound:
        ws = sh.add_worksheet(title="Posts", rows=200, cols=len(headers))

    media_list = fetch_latest_media(cfg, args.posts)
    rows = []
    for m in media_list:
        ins = fetch_media_insights(cfg, m["id"])
        dt = datetime.fromisoformat(m["timestamp"].replace("Z", "+00:00")).astimezone(tz)
        date_str = dt.strftime("%Y-%m-%d")
        time_str = dt.strftime("%H:%M:%S")
        ptype = map_post_type(m.get("media_type",""), m.get("media_product_type",""))
        desc = brief_description(m.get("caption",""), limit=120)

        rows.append({
            "Date": date_str,
            "Time": time_str,
            "Post Type": ptype,
            "Brief Content Description": desc,
            "Likes": m.get("like_count", ""),
            "Comments": m.get("comments_count", ""),
            # Shares not exposed for standard media via Graph API; left blank.
            "Shares": "",
            "Saves": ins.get("saved", ""),
            "Reach": ins.get("reach", ""),
            "Impressions": ins.get("impressions", ""),
            "Permalink": m.get("permalink",""),
            "Media ID": m["id"],
            "Synced At": datetime.now(tz).isoformat(),
        })
        time.sleep(0.25)

    upsert_by_key(ws, key_col_name="Media ID", rows=rows, headers=headers)
    print(f"Upserted {len(rows)} rows into 'Posts'.")

if __name__ == "__main__":
    main()
