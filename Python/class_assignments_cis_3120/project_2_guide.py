# Project 2 Guide 

from bs4 import BeautifulSoup
import requests

urls = {
    "Mens Volleyball": ["https://ccnyathletics.com/sports/mens-volleyball/roster", "https://lehmanathletics.com/sports/mens-volleyball/roster"],
    "Womans Volleyball": ["https://bmccathletics.com/sports/womens-volleyball/roster", "https://yorkathletics.com/sports/womens-volleyball/roster"],
    "Mens Swimming": ["https://csidolphins.com/sports/mens-swimming-and-diving/roster","https://yorkathletics.com/sports/mens-swimming-and-diving/roster"],
    "Womans Swimming": ["https://csidolphins.com/sports/womens-swimming-and-diving/roster","https://queensknights.com/sports/womens-swimming-and-diving/roster"]
}

for key, url in urls.items():
    
    page = requests.get(url)
    print(page.status_code)
    
    if page.status_code == 200:
        
        soup = BeautifulSoup(page.content, "html.parser")
        
        