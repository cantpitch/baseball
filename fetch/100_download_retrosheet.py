import urllib.request
from os import makedirs

event_files = ['1920seve.zip', '1930seve.zip', '1940seve.zip', '1950seve.zip', 
               '1960seve.zip', '1970seve.zip', '1980seve.zip', '1990seve.zip',
               '2000seve.zip', '2010seve.zip', '1910sbox.zip', '1920sbox.zip', 
               '1930sbox.zip', '1940sbox.zip', '1950sbox.zip', 'allas.zip',
               'allpost.zip']

gamelogs_start = 1871
gamelogs_end   = 2016

post_gamelogs = ['glws.zip', 'glas.zip', 'glwc.zip', 'gldv.zip', 'gllc.zip']

makedirs('../zips', exist_ok=True)

url = 'http://www.retrosheet.org'

for file in event_files:
    src = url + '/events/' + file
    dst = '../zips/' + file
    print("Downloading {0} to {1}".format(src, dst))
    urllib.request.urlretrieve(src, dst)

for year in range(gamelogs_start, gamelogs_end + 1):
    file = 'gl' + str(year) + '.zip'
    src = url + '/gamelogs/' + file
    dst = '../zips/' + file
    print("Downloading {0} to {1}".format(src, dst))
    urllib.request.urlretrieve(src, dst)

for file in post_gamelogs:
    src = url + '/gamelogs/' + file
    dst = '../zips/' + file
    print("Downloading {0} to {1}".format(src, dst))
    urllib.request.urlretrieve(src, dst)