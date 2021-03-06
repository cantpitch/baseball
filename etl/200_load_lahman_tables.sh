#!/bin/bash

mysql lahman < tables/lahman.sql


echo "#### Loading Allstar..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/AllstarFull.csv' INTO TABLE Allstar FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Appearances..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Appearances.csv' INTO TABLE Appearances FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading AwardsManagers..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/AwardsManagers.csv' INTO TABLE AwardsManagers FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading AwardsPlayers..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/AwardsPlayers.csv' INTO TABLE AwardsPlayers FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading AwardsShareManagers..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/AwardsShareManagers.csv' INTO TABLE AwardsShareManagers FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading AwardsSharePlayers..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/AwardsSharePlayers.csv' INTO TABLE AwardsSharePlayers FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Batting..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Batting.csv' INTO TABLE Batting FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading BattingPost..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/BattingPost.csv' INTO TABLE BattingPost FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading CollegePlaying..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/CollegePlaying.csv' INTO TABLE CollegePlaying FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Fielding..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Fielding.csv' INTO TABLE Fielding FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading FieldingOF..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/FieldingOF.csv' INTO TABLE FieldingOF FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading FieldingOFsplit..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/FieldingOFsplit.csv' INTO TABLE FieldingOFSplit FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading FieldingPost..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/FieldingPost.csv' INTO TABLE FieldingPost FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading HallOfFame..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/HallOfFame.csv' INTO TABLE HallOfFame FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading HomeGames..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/HomeGames.csv' INTO TABLE HomeGames FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Managers..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Managers.csv' INTO TABLE Managers FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading ManagersHalf..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/ManagersHalf.csv' INTO TABLE ManagersHalf FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Parks..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Parks.csv' INTO TABLE Parks FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading People..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/People.csv' INTO TABLE People FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Pitching..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Pitching.csv' INTO TABLE Pitching FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading PitchingPost..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/PitchingPost.csv' INTO TABLE PitchingPost FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Salaries..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Salaries.csv' INTO TABLE Salaries FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Schools..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Schools.csv' INTO TABLE Schools FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' IGNORE 1 LINES"
echo "#### Loading SeriesPost..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/SeriesPost.csv' INTO TABLE SeriesPost FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading Teams..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/Teams.csv' INTO TABLE Teams FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading TeamsFranchises..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/TeamsFranchises.csv' INTO TABLE TeamsFranchises FIELDS TERMINATED BY ',' IGNORE 1 LINES"
echo "#### Loading TeamsHalf..."
mysql lahman -e "LOAD DATA INFILE '$HOME/Projects/toolsofignorance/data/lahman/TeamsHalf.csv' INTO TABLE TeamsHalf FIELDS TERMINATED BY ',' IGNORE 1 LINES"
    