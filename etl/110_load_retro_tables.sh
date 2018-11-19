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
    mysql retrosheet -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet/${src_dir}/retro${u}_raw_events.csv' INTO TABLE retro${u}_raw_events FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'"
    echo "#### Loading retro${u}_raw_gamelogs..."
    mysql retrosheet -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet/${src_dir}/retro${u}_raw_gamelogs.csv' INTO TABLE retro${u}_raw_gamelogs FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'"
    echo "#### Loading retro${u}_raw_gamelogs_cwgame..."
    mysql retrosheet -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet/${src_dir}/retro${u}_raw_gamelogs_cwgame.csv' INTO TABLE retro${u}_raw_gamelogs_cwgame FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'"
    echo "#### Loading retro${u}_raw_sub..."
    mysql retrosheet -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet/${src_dir}/retro${u}_raw_sub.csv' INTO TABLE retro${u}_raw_sub FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'"
done