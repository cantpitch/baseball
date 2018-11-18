import urllib.request
from os import makedirs

makedirs('../zips', exist_ok=True)

file = 'baseballdatabank-master_2018-03-28.zip'
src = 'http://seanlahman.com/files/database/' + file
dst = '../zips/' + file

print("Downloading {0} to {1}".format(src, dst))
urllib.request.urlretrieve(src, dst)