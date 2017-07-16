#!/bin/sh

BASE=/Users/hvs/Projects/baseball

mkdir -p $BASE/data/retrosheet/regular
mkdir -p $BASE/data/retrosheet/postseason
mkdir -p $BASE/data/retrosheet/allstar
mkdir -p $BASE/data/lahman

## Regular Season Files
cd $BASE/data/retrosheet/regular
unzip '../../../zips/[0-9][0-9][0-9][0-9]sbox.zip'
unzip '../../../zips/[0-9][0-9][0-9][0-9]seve.zip'
unzip '../../../zips/gl[0-9][0-9][0-9][0-9].zip'

## Postseason Files
cd $BASE/data/retrosheet/postseason
unzip '../../../zips/allpost.zip'
unzip '../../../zips/gldv.zip'
unzip '../../../zips/gllc.zip'
unzip '../../../zips/glwc.zip'
unzip '../../../zips/glws.zip'

## All-Star Files
cd $BASE/data/retrosheet/allstar
unzip '../../../zips/allas.zip'
unzip '../../../zips/glas.zip'

## Lahman Database
cd $BASE/data/lahman
unzip '../../zips/baseballdatabank-*.zip'
### Move the lahman csv files to the base dir
find . -name *.csv -exec sh -c 'mv {} $(basename {})' \;
chmod -x *.csv
### Remove the subdir
rm -rf baseballdatabank*

cd ../../etl