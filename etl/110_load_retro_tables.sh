#!/bin/bash

psql baseball < tables/retro_raw_events.sql
psql baseball < tables/retro_raw_gamelogs.sql
psql baseball < tables/retro_raw_gamelogs_cwgame.sql
psql baseball < tables/retro_raw_sub.sql

types=("" postseason allstar)
for t in "${types[@]}"; do
	u="$t"
	src_dir="$t"
	if [ -n "$t" ]; then
		u="_$t"
	else
		src_dir="regular" 
	fi
	
	psql baseball -c "copy retro${u}_raw_events from STDIN with delimiter ',' csv"  < ../data/retrosheet/${src_dir}/playbyplay.csv
	psql baseball -c "copy retro${u}_raw_gamelogs from STDIN with delimiter ',' csv"  < ../data/retrosheet/${src_dir}/gamelogs.csv
	psql baseball -c "copy retro${u}_raw_gamelogs_cwgame from STDIN with delimiter ',' csv"  < ../data/retrosheet/${src_dir}/gamelogs_cwgame.csv
	psql baseball -c "copy retro${u}_raw_sub from STDIN with delimiter ',' csv"  < ../data/retrosheet/${src_dir}/substitutions.csv
done