
from bs4 import BeautifulSoup
from datetime import datetime
from pathlib import Path
import psycopg2
from psycopg2.extras import execute_values
import re

conn = psycopg2.connect("host=localhost dbname=baseball user=hvs")
cursor = conn.cursor()
def floatify(value):
    try:
        if value is None:
            return None
        return float(value)
    except ValueError:
        return None

def intify(value):
    try:
        if value is None:
            return None
        return int(value)
    except ValueError:
        return None

def height_to_int(value):
    parts = value.split('-')
    height = int(parts[1])
    height += int(parts[0]) * 12

gid_re = re.compile(r'gid_([0-9]{4})_([0-9]{2})_([0-9]{2})_([a-z]{3}mlb)_([a-z]{3}mlb)_([0-9])')

cursor.execute("truncate table mlbam_pitchfx")
conn.commit()

pathlist = Path("../data/pitchfx").glob("**/inning_all.xml")
for path in pathlist:
    print(str(path))
    match = gid_re.search(str(path))
    (year, month, day, home, away, day_game) = match.groups()

    with open(str(path)) as xml:
        gid = "{}/{}/{}/{}-{}-{}".format(year, month, day, home, away, day_game)
        soup = BeautifulSoup(xml, 'xml')
        innings = soup.find_all('inning')
        seq_num = 1

        for inning in innings:
            insert_data = []

            away_team = inning['away_team']
            home_team = inning['home_team']
            inning_num = int(inning['num'])
            half_inning = 0
            ab_num = 1

            for half_inning in [0,1]:

                if half_inning == 0:
                    atbats = inning.top.find_all('atbat')
                else:
                    atbats = inning.bottom.find_all('atbat')

                for atbat in atbats:
                    away_team_score = intify(atbat['away_team_runs'])
                    home_team_score = intify(atbat['home_team_runs'])
                    pitch_num = 1
                    event_num = intify(atbat['event_num'])
                    balls = 0
                    strikes = 0
                    event = atbat['event']
                    event_description = atbat['des']
                    batter_id = intify(atbat['batter'])
                    batter_hand = atbat['stand']
                    batter_height = height_to_int(atbat['b_height'])
                    pitcher_id = intify(atbat['pitcher'])
                    pitcher_throws = atbat['p_throws']

                    pitches = atbat.find_all('pitch')
                    for pitch in pitches:
                        if pitch['type'] == 'B':
                            balls += 1
                        elif pitch['type'] == 'S':
                            strikes += 1

                        pitch_time = datetime.strptime(pitch.get('tfs_zulu', None), '%Y-%m-%dT%H:%M:%SZ')
                        init_speed = floatify(pitch.get('start_speed', None))
                        init_pos_x = floatify(pitch.get('x0', None))
                        init_pos_y = floatify(pitch.get('y0', None))
                        init_pos_z = floatify(pitch.get('z0', None))
                        init_vel_x = floatify(pitch.get('vx0', None))
                        init_vel_y = floatify(pitch.get('vy0', None))
                        init_vel_z = floatify(pitch.get('vz0', None))
                        init_acc_x = floatify(pitch.get('ax', None))
                        init_acc_y = floatify(pitch.get('ay', None))
                        init_acc_z = floatify(pitch.get('az', None))
                        plate_speed = floatify(pitch.get('end_speed', None))
                        plate_x = floatify(pitch.get('px', None))
                        plate_y = 0.0
                        plate_z = floatify(pitch.get('pz', None))
                        pfx_x = floatify(pitch.get('pfx_x', None))
                        pfx_y = 0.0
                        pfx_z = floatify(pitch.get('pfx_z', None))
                        break_y = floatify(pitch.get('break_y', None))
                        break_angle = floatify(pitch.get('break_angle', None))
                        break_length = floatify(pitch.get('break_length', None))
                        strike_zone_top = floatify(pitch.get('sz_top', None))
                        strike_zone_bottom = floatify(pitch.get('sz_bot', None))
                        pitch_type = pitch.get('pitch_type', None)
                        pitch_name = { 
                            'FA': 'Four-seam Fastball', 
                            'FF': 'Four-seam Fastball', 
                            'FT': 'Two-seam Fastball',
                            'FC': 'Cutter',
                            'FS': 'Splitter',
                            'CH': 'Changeup', 
                            'CU': 'Cutter',
                            'SL': 'Slider', 
                            'SI': 'Sinker', 
                            'IN': 'Intentional Ball',
                            'AB': 'Automatic Ball',
                            'KN': 'Knuckleball',
                            'KC': 'Knuckle Curve',
                            'EP': 'Eephus Pitch',
                            'UN': 'Unknown',
                            'FO': 'Forkball',
                            'SC': 'Screwball',
                            'PO': 'Pitchout',
                            None: None }[pitch.get('pitch_type', None)]
                        pitch_type_confidence = floatify(pitch.get('type_confidence', None))
                        zone = intify(pitch.get('zone', None))
                        nasty = intify(pitch.get('nasty', None))
                        spin_dir = floatify(pitch.get('spin_dir', None))
                        spin_rate = floatify(pitch.get('spin_rate', None))
                        pitch_result = pitch.get('type', None)
                        pitch_result_description = pitch.get('des', None)

                        insert_data.append((gid, pitch_time, away_team, home_team, away_team_score, home_team_score, seq_num, ab_num, pitch_num,
                                            inning_num, half_inning, event_num, balls, strikes, event, event_description, batter_id, batter_hand,
                                            batter_height, pitcher_id, pitcher_throws, init_speed, init_pos_x, init_pos_y, init_pos_z, init_vel_x,
                                            init_vel_y, init_vel_z, init_acc_x, init_acc_y, init_acc_z, plate_speed, plate_x, plate_y, plate_z,
                                            pfx_x, pfx_y, pfx_z, break_y, break_angle, break_length, strike_zone_top, strike_zone_bottom,
                                            pitch_type, pitch_name, pitch_type_confidence, zone, nasty, spin_dir, spin_rate, pitch_result, 
                                            pitch_result_description))


                        seq_num += 1 
                        pitch_num += 1   

                    ab_num += 1

            print("items: {}".format(len(insert_data)))
            execute_values(cursor, """insert into mlbam_pitchfx (gid, pitch_time, away_team, home_team, away_team_score, home_team_score, seq_num, ab_num, pitch_num,
                                      inning, half_inning, event_num, balls, strikes, event, event_description, batter_id, batter_hand,
                                      batter_height, pitcher_id, pitcher_throws, init_speed, init_pos_x, init_pos_y, init_pos_z, init_vel_x,
                                      init_vel_y, init_vel_z, init_acc_x, init_acc_y, init_acc_z, plate_speed, plate_x, plate_y, plate_z,
                                      pfx_x, pfx_y, pfx_z, break_y, break_angle, break_length, strike_zone_top, strike_zone_bottom,
                                      pitch_type, pitch_name, pitch_type_confidence, zone, nasty, spin_dir, spin_rate, pitch_result, 
                                      pitch_result_description) values %s""", insert_data)
            conn.commit()
