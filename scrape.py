# Import all the required packages
import requests
from bs4 import BeautifulSoup
import csv
import pandas as pd

url="https://thecleverprogrammer.com/2024/08/01/data-science-guided-projects-with-python/" 
r=requests.get(url) # extracting the url of the page

soup= BeautifulSoup(r.content,'html.parser') # creating a soup variable
table=soup.find('ol',class_="wp-block-list")   # Finding the element in which the required links exists

l=[] # Empty ;ist to add the extracted links
p=[] # Empty list to add the extracted Project names

for t in table.find_all('li'): # Looping through the element to extract individual links
    l.append(t.a['href'])
    p.append(t.get_text())
    
output=pd.DataFrame({"project":p,"Link":l}) # Creating dataframe from the result lists
print(output)               

# To directly write to a csv file
with open('project_links.csv', 'w', newline='') as csvfile:
        # Create a CSV writer
        writer = csv.writer(csvfile)
        
        # Write the header
        writer.writerow(["Link", "Project Name"])
        
        # Extract links and project names from the ordered list
        for t in table.find_all('li'):
            if li:  # Ensure it's a tag
                link = t.find('a')
                if link and link.get('href'):  # Check if the <a> tag exists and has an href
                    # Write the link and project name to the CSV
                    writer.writerow([link.get('href'), link.text.strip()])

