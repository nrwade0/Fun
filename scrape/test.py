import requests
from bs4 import BeautifulSoup

URL = "https://realpython.github.io/fake-jobs/"
URL = "https://www.newegg.com/p/pl?d=gtx"
page = requests.get(URL)

#print(page)

# soup
soup = BeautifulSoup(page.content, "html.parser")

# results
if soup.status_code == 200:

    results = soup.find(id="list-wrap")
    print(results)
    print(results.prettify())

    job_elements = results.find_all("div", class_="pageItem")
else:
    print('uh uh')
    cont = soup.find_all('div', class_="list-wrap")
    for c in cont:
        print(c.prettify())
