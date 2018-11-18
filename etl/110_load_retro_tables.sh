#!/bin/bash

mysql retrosheet < tables/retro_raw_events.sql
mysql retrosheet < tables/retro_raw_gamelogs.sql
mysql retrosheet < tables/retro_raw_gamelogs_cwgame.sql
mysql retrosheet < tables/retro_raw_sub.sql

types=("" postseason allstar)
for t in "${types[@]}"; do
    u="$t"
    src_dir="$t"
    if [ -n "$t" ]; then
        u="_$t"
    else
        src_dir="regular" 
    fi
    
    echo "#### Loading retro${u}_raw_events..."
    mysqlimport baseball ../data/retrosheet/${src_dir}/retro${u}_raw_events.csv
    echo "#### Loading retro${u}_raw_gamelogs..."
    mysqlimport baseball ../data/retrosheet/${src_dir}/retro${u}_raw_gamelogs.csv
    echo "#### Loading retro${u}_raw_gamelogs_cwgame..."
    mysqlimport baseball ../data/retrosheet/${src_dir}/retro${u}_raw_gamelogs_cwgame.csv
    echo "#### Loading retro${u}_raw_sub..."
    mysqlimport baseball ../data/retrosheet/${src_dir}/retro${u}_raw_sub.csv
done