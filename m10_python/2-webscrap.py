from bs4 import BeautifulSoup
# import json
import csv
import requests

# web site to scrap
url_main = "https://distrowatch.com/"

#   F12 / Network / get
headers = {
    "Accept": "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36"
}

req_main = requests.get(url_main, headers=headers).text
# print(req_main)

soup = BeautifulSoup(req_main, "lxml")
top = 100

all_distr = soup.find_all(class_="phr2")
all_ranks = soup.find_all(class_="phr3")

for i in range(top):
    distr_rank = all_ranks[i].text
    distr_name = all_distr[i].text
    # print(f'Place:{i+1}\tHPD:{distr_rank}\tDistributive: {distr_name}\t')

    # store in CSV
    with open(f"ranking.csv", "a", encoding="utf-8", newline='') as file:
        writer = csv.writer(file)

        if i == 0:
            # write a head
            writer.writerow(
                (
                    "Rank",
                    "Distributive",
                    "HPD"
                )
            )
            # write a row
            writer.writerow(
                (
                    i+1,
                    distr_name,
                    distr_rank
                )
            )
        else:
            # write a row
            writer.writerow(
                (
                    i+1,
                    distr_name,
                    distr_rank
                )
            )

    if i == top:
        print("Done!")
        break

    print(f"Iteration: {i+1}")
