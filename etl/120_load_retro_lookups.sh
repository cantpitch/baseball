
#!/bin/bash

psql baseball < tables/retro_lookup_tables.sql
psql baseball -c "copy retro_teams from STDIN with delimiter ',' csv"  < ../data/retrosheet-lookups/CurrentNames.csv
psql baseball -c "copy retro_parks from STDIN with delimiter ',' csv header"  < ../data/retrosheet-lookups/parkcode.txt
psql baseball -c "copy retro_players from STDIN with delimiter ',' csv header"  < ../data/retrosheet-lookups/retroID.htm