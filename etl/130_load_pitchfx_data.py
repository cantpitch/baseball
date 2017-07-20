
from bs4 import BeautifulSoup

with open("../data/pitchfx/2017/gid_2017_07_16_wasmlb_cinmlb_1/inning_all.xml") as xml:
    soup = BeautifulSoup(xml, 'xml')
    innings = soup.find_all('inning')

    for inning in innings:
        atbats = inning.top.find_all('atbat')
        print("Top {}".format(inning['num']))
        for atbat in atbats:
            print("  {}: {}-{} {}".format(atbat['num'], atbat['b'], atbat['s'], atbat['o']))

        atbats = inning.bottom.find_all('atbat')
        print("Bottom {}".format(inning['num']))
        for atbat in atbats:
            print("  {}: {}-{} {}".format(atbat['num'], atbat['b'], atbat['s'], atbat['o']))            