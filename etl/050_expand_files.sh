#!/bin/sh

mkdir -p ../data/retrosheet/regular
mkdir -p ../data/retrosheet/postseason
mkdir -p ../data/retrosheet/allstar
mkdir -p ../data/lahman

## Regular Season Files
cd ../data/retrosheet/regular
unzip '../../../zips/[0-9][0-9][0-9][0-9]sbox.zip'
unzip '../../../zips/[0-9][0-9][0-9][0-9]seve.zip'
unzip '../../../zips/gl[0-9][0-9][0-9][0-9].zip'

## Postseason Files
cd ../postseason
unzip '../../../zips/allpost.zip'
unzip '../../../zips/gldv.zip'
unzip '../../../zips/gllc.zip'
unzip '../../../zips/glwc.zip'
unzip '../../../zips/glws.zip'

## All-Star Files
cd ../allstar
unzip '../../../zips/allas.zip'
unzip '../../../zips/glas.zip'

## Lahman Database
cd ../../lahman
unzip '../../zips/baseballdatabank-*.zip'
### Move the lahman csv files to the base dir
find . -name *.csv -exec sh -c 'mv {} $(basename {})' \;
chmod -x *.csv
### Remove the subdir
rm -rf baseballdatabank*

cd ../../etl