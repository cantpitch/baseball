#!/bin/bash

SRC="../data/retrosheet-lookups"

mkdir -p $SRC

rm -f $SRC/parkcode.txt $SRC/CurrentNames.csv $SRC/retroID.htm 

wget -O $SRC/parkcode.txt     http://www.retrosheet.org/parkcode.txt
wget -O $SRC/CurrentNames.csv http://www.retrosheet.org/CurrentNames.csv
wget -O $SRC/retroID.htm      http://www.retrosheet.org/retroID.htm

## Cleanup the parkcode file
dos2unix $SRC/parkcode.txt
sed -e 's/09\/18\/1890,,NL,""/09\/18\/1890,NL,""/' -i "" $SRC/parkcode.txt
gsed -i -e 's/,,/,\\N,/g' $SRC/parkcode.txt
gsed -i -e 's/,,/,\\N,/g' $SRC/parkcode.txt
gsed -i -e 's/^,/\\N,/g' $SRC/parkcode.txt
gsed -i -e 's/,$/,\\N/g' $SRC/parkcode.txt

## Clean up the CurrentNames.csv
dos2unix $SRC/CurrentNames.csv
gsed -i -e 's/,,/,\\N,/g' $SRC/CurrentNames.csv
gsed -i -e 's/,,/,\\N,/g' $SRC/CurrentNames.csv
gsed -i -e 's/^,/\\N,/g' $SRC/CurrentNames.csv
gsed -i -e 's/,$/,\\N/g' $SRC/CurrentNames.csv

## Cleanup the retroIDs file
dos2unix $SRC/retroID.htm
sed -e '1,/<pre>/d' -i "" $SRC/retroID.htm
sed -e '/<\/pre>/,$d' -i "" $SRC/retroID.htm
sed -e '/^\s*$/d' -i "" $SRC/retroID.htm
gsed -i -e 's/,,/,\\N,/g' $SRC/retroID.htm
gsed -i -e 's/,,/,\\N,/g' $SRC/retroID.htm
gsed -i -e 's/^,/\\N,/g' $SRC/retroID.htm
gsed -i -e 's/,$/,\\N/g' $SRC/retroID.htm

mysql retrosheet < tables/retro_lookup_tables.sql
echo "### Loading CurrentNames.csv"
mysql retrosheet -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet-lookups/CurrentNames.csv' INTO TABLE retro_teams FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' (franch_id, team_id, lg_id, division, name, nickname, additional_nicknames, @start_date, @end_date, city, state) SET start_date=STR_TO_DATE(@start_date, '%c/%e/%Y'), end_date=STR_TO_DATE(@end_date, '%c/%e/%Y')"

echo "### Loading parkcode.txt"
mysql retrosheet <<EOF
LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet-lookups/parkcode.txt' 
INTO TABLE retro_parks 
FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '\"' 
IGNORE 1 LINES 
(park_id, park_name, other_names, city, state_country, @start_date, @end_date, lg_id, details) 
SET start_date=IF(@start_date='', null, STR_TO_DATE(@start_date, '%c/%e/%Y')), 
    end_date=IF(@end_date='', null, STR_TO_DATE(@end_date, '%c/%e/%Y'))
EOF

echo "### Loading retroID.htm"
mysql retrosheet <<EOF
LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/retrosheet-lookups/retroID.htm' 
INTO TABLE retro_players 
FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '\"' 
IGNORE 1 LINES 
(retro_id, name_last, name_first, @player_debut_date, @manager_debut_date, @coach_debut_date, @umpire_debut_date) 
SET player_debut_date=IF(@player_debut_date='', null, STR_TO_DATE(@player_debut_date, '%c/%e/%Y')),
    manager_debut_date=IF(@manager_debut_date='', null, STR_TO_DATE(@manager_debut_date, '%c/%e/%Y')),
    coach_debut_date=IF(@coach_debut_date='', null, STR_TO_DATE(@coach_debut_date, '%c/%e/%Y')),
    umpire_debut_date=IF(@umpire_debut_date='', null, STR_TO_DATE(@umpire_debut_date, '%c/%e/%Y'))
EOF