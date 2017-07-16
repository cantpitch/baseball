import urllib.request
from os import makedirs

makedirs('../zips', exist_ok=True)

file = 'baseballdatabank-2017.1.zip'
src = 'http://seanlahman.com/files/database/' + file
dst = '../zips/' + file

print("Downloading {0} to {1}".format(src, dst))
urllib.request.urlretrieve(src, dst)