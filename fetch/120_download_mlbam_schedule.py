import argparse
import re
import urllib.request
from urllib.error import HTTPError
from calendar import monthrange
from os import makedirs
from time import sleep

parser = argparse.ArgumentParser(description='Download MLBAM schedule')
parser.add_argument('-y', '--year', type=int, help='the year to fetch')
parser.add_argument('-m', '--month', type=int, help='the month to fetch')
args = parser.parse_args()

pitchfx_year_start  = 2018 #2008
pitchfx_year_end    = 2018 #2017
pitchfx_month_start = 3
pitchfx_month_end   = 11
start_year          = args.year or pitchfx_year_start
end_year            = args.year or pitchfx_year_end
start_month         = args.month or pitchfx_month_start
end_month           = args.month or pitchfx_month_end

makedirs('../data/pitchfx', exist_ok=True)

base_url = 'http://gd2.mlb.com/components/game/mlb'

for year in range(start_year, end_year+1):
    print("### Fetching {}".format(year))

    for month in range(start_month, end_month+1):
        days_in_month = monthrange(year, month)[1]

        for day in range(1, days_in_month+1):
            game_list = base_url + '/year_' + str(year) + '/month_' + str(month).zfill(2) + '/day_' + str(day).zfill(2) + '/miniscoreboard.xml'
            print("### Fetching game list from {}".format(game_list))
            f = urllib.request.urlopen(game_list)
            
            dstdir = '../data/schedule/{}'.format(year)
            makedirs(dstdir, exist_ok=True)
            dst = dstdir + '/' + str(year) + str(month).zfill(2) + str(day).zfill(2) + '.xml'
            print("### Fetching {} to {}...".format(game_list, dst))
            try:
                urllib.request.urlretrieve(game_list, dst)
            except HTTPError as e:
                if e.code != 404:
                    raise e
                else:
                    print("### {} not found.".format(game_list))

            sleep(1)