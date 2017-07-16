#!/bin/bash

SRC="../data/retrosheet-lookups"

mkdir -p $SRC

rm -f $SRC/parkcode.txt $SRC/CurrentNames.csv $SRC/retroID.htm 

wget -O $SRC/parkcode.txt     http://www.retrosheet.org/parkcode.txt
wget -O $SRC/CurrentNames.csv http://www.retrosheet.org/CurrentNames.csv
wget -O $SRC/retroID.htm      http://www.retrosheet.org/retroID.htm

## Cleanup the parkcode file
sed -e 's/09\/18\/1890,,NL,""/09\/18\/1890,NL,""/' -i "" $SRC/parkcode.txt

## Cleanup the retroIDs file
sed -e '1,/<pre>/d' -i "" $SRC/retroID.htm
sed -e '/<\/pre>/,$d' -i "" $SRC/retroID.htm
sed -e '/^\s*$/d' -i "" $SRC/retroID.htm

psql baseball < tables/retro_lookup_tables.sql
psql baseball -c "copy retro_teams from STDIN with delimiter ',' csv"  < ../data/retrosheet-lookups/CurrentNames.csv
psql baseball -c "copy retro_parks from STDIN with delimiter ',' csv header"  < ../data/retrosheet-lookups/parkcode.txt
psql baseball -c "copy retro_players from STDIN with delimiter ',' csv header"  < ../data/retrosheet-lookups/retroID.htm