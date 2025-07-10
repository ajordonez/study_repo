import requests
from bs4 import BeautifulSoup

url = "https://www.nytimes.com/"

page = requests.get(url)

# Checks if python was able to connect to the url (status code 200 is good)
print(page.status_code)

# Use beautiful soup to extract html information
soup = BeautifulSoup(page.content, "html.parser")

# Takes all of the html code and makes it simplier to read
to_print = soup.prettify()

h1_find = soup.find("h1")

# Gets you the html code
print(h1_find)

# Extracts the actual text and content
print(h1_find.get_text())
# or this function does the same
print(h1_find.text)


# .find_all(<name of tag>) returns the a list of all matching tags
h1_tag = soup.find_all("h1")

# by default .find_all() will return a list

print(h1_tag[0].text)

# pring the list of all paragraph tags
p_tags = soup.find_all("p")
print(p_tags[0].get_text())

