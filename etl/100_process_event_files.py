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
    
    ## Cleanup previous runs
    if os.path.isfile('playbyplay.csv'):
        remove('playbyplay.csv')
    
    if os.path.isfile('gamelogs_cwgame.csv'):
        remove('gamelogs_cwgame.csv')
    
    if os.path.isfile('substitutions.csv'):
        remove('substitutions.csv')
    
    call("cat GL*.TXT > gamelogs.csv", shell=True)
    
    for filename in files:
        print("Processing {}".format(filename))
        year = filename[:4]
        call("cwevent -q -y {} -f 0-96 -x 0-62 {} >> playbyplay.csv".format(year, filename), shell=True)
        call("cwgame -q -y {} -f 0,4-5,19-31 {} >> gamelogs_cwgame.csv".format(year, filename), shell=True)
        call("cwsub -q -y {} {} >> substitutions.csv".format(year, filename), shell=True)
    
    
chdir(prev_dir)