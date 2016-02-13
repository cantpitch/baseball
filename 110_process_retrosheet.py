from glob import glob
from os import chdir, getcwd
from subprocess import call

data_dir = "/Users/hvs/Projects/retrosheet/data"
prev_dir = getcwd()

chdir(data_dir)
files = glob("*.EV[ANP]")

for filename in files:
	print("Processing {}".format(filename))
	year = filename[:4]
	call("cwevent -q -y {} -f 0-96 -x 0-62 {} >> playbyplay.csv".format(year, filename), shell=True)
	call("cwsub -q -y {} {} >> substitutions.csv".format(year, filename), shell=True)

chdir(prev_dir)