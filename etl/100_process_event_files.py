from glob import glob
from os import chdir, getcwd, remove
import os.path
from subprocess import call
import sys

curr_dir = os.path.dirname(os.path.realpath(__file__))
base_dir = os.path.abspath(os.path.join(curr_dir, os.pardir))
data_dir = "{}/data/retrosheet".format(base_dir)
sub_dirs = ['regular', 'postseason', 'allstar']
prev_dir = getcwd()

for d in sub_dirs:
    curr_dir = data_dir + '/' + d
    print("Changing to {}".format(curr_dir))
    chdir(curr_dir)

    files = glob("*.EV[ANPE]")
    files.sort()

    prefix = f'{d}_' if d != 'regular' else ''
    events_file = f'retro_{prefix}raw_events.csv'
    gamelogs_cwgame_file = f'retro_{prefix}raw_gamelogs_cwgame.csv'
    sub_file = f'retro_{prefix}raw_sub.csv'
    gamelogs_file = f'retro_{prefix}raw_gamelogs.csv'

    ## Cleanup previous runs
    if os.path.isfile(events_file):
        remove(events_file)
    
    if os.path.isfile(gamelogs_cwgame_file):
        remove(gamelogs_cwgame_file)
    
    if os.path.isfile(sub_file):
        remove(sub_file)
    
    call(f'cat GL*.TXT > {gamelogs_file}', shell=True)
    
    for filename in files:
        print(f'Processing {filename}')
        year = filename[:4]
        call("cwevent -q -y {} -f 0-96 -x 0-62 {} >> {}".format(year, filename, events_file), shell=True)
        call("cwgame -q -y {} -f 0,4-5,19-31 {} >> {}".format(year, filename, gamelogs_cwgame_file), shell=True)
        call("cwsub -q -y {} {} >> {}".format(year, filename, sub_file), shell=True)
    
    
chdir(prev_dir)