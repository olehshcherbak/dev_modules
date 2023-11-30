import json
import csv

csv_path = 'ranking.csv'
json_path = 'ranking.json'

data = {}
# fields = ("Rank", "Distrib", "HPD")

with open(csv_path, encoding='utf-8') as csvf:
    csvReader = csv.DictReader(csvf)

    for rows in csvReader:
        key = rows['Rank']
        data[key] = rows
        print(rows)

with open(json_path, 'w', encoding='utf-8') as jsonf:
    jsonf.write(json.dumps(data, indent=4))
