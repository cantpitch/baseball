
from bs4 import BeautifulSoup
from datetime import datetime
import psycopg2
from psycopg2.extras import execute_values

conn = psycopg2.connect("dbname=baseball user=hvs")
cursor = conn.cursor()
def isfloat(value):
    try:
        float(value)
        return True
    except ValueError:
        return False

def height_to_int(value):
    parts = value.split('-')
    height = int(parts[1])
    height += int(parts[0]) * 12

with open("../data/pitchfx/2017/gid_2017_07_16_wasmlb_cinmlb_1/inning_all.xml") as xml:
    gid = "2017/07/16/wasmlb-cinmlb-1"
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
                away_team_score = int(atbat['away_team_runs'])
                home_team_score = int(atbat['home_team_runs'])
                pitch_num = 1
                event_num = int(atbat['event_num'])
                balls = 0
                strikes = 0
                event = atbat['event']
                event_description = atbat['des']
                batter_id = int(atbat['batter'])
                batter_hand = atbat['stand']
                batter_height = height_to_int(atbat['b_height'])
                pitcher_id = int(atbat['pitcher'])
                pitcher_throws = atbat['p_throws']

                pitches = atbat.find_all('pitch')
                for pitch in pitches:
                    if pitch['type'] == 'B':
                        balls += 1
                    elif pitch['type'] == 'S':
                        strikes += 1

                    print("{} {} {}".format(seq_num, ab_num, pitch_num))
                    pitch_time = datetime.strptime(pitch['tfs_zulu'], '%Y-%m-%dT%H:%M:%SZ')
                    init_speed = float(pitch['start_speed'])
                    init_pos_x = float(pitch['x0'])
                    init_pos_y = float(pitch['y0'])
                    init_pos_z = float(pitch['z0'])
                    init_vel_x = float(pitch['vx0'])
                    init_vel_y = float(pitch['vy0'])
                    init_vel_z = float(pitch['vz0'])
                    init_acc_x = float(pitch['ax'])
                    init_acc_y = float(pitch['ay'])
                    init_acc_z = float(pitch['az'])
                    plate_speed = float(pitch['end_speed'])
                    plate_x = float(pitch['px'])
                    plate_y = 0.0
                    plate_z = float(pitch['pz'])
                    pfx_x = float(pitch['pfx_x'])
                    pfx_y = 0.0
                    pfx_z = float(pitch['pfx_z'])
                    break_y = float(pitch['break_y'])
                    break_angle = float(pitch['break_angle'])
                    break_length = float(pitch['break_length'])
                    strike_zone_top = float(pitch['sz_top'])
                    strike_zone_bottom = float(pitch['sz_bot'])
                    pitch_type = pitch['pitch_type']
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
                        'PO': 'Pitchout'}[pitch['pitch_type']]
                    pitch_type_confidence = float(pitch['type_confidence'])
                    zone = int(pitch['zone'])
                    nasty = int(pitch['nasty'])
                    spin_dir = float(pitch['spin_dir'])
                    spin_rate = float(pitch['spin_rate']) if isfloat(pitch['spin_rate']) else None
                    pitch_result = pitch['type']
                    pitch_result_description = pitch['des']

                    insert_data.append((gid, pitch_time, away_team, home_team, away_team_score, home_team_score, seq_num, ab_num, pitch_num,
                                        inning_num, half_inning, event_num, balls, strikes, event, event_description, batter_id, batter_hand,
                                        batter_height, pitcher_id, pitcher_throws, init_speed, init_pos_x, init_pos_y, init_pos_z, init_vel_x,
                                        init_vel_y, init_vel_z, init_acc_x, init_acc_y, init_acc_z, plate_speed, plate_x, plate_y, plate_x,
                                        pfx_x, pfx_y, pfx_z, break_y, break_angle, break_length, strike_zone_top, strike_zone_bottom,
                                        pitch_type, pitch_name, pitch_type_confidence, zone, nasty, spin_dir, spin_rate, pitch_result, 
                                        pitch_result_description))


                    seq_num += 1 
                    pitch_num += 1   

                ab_num += 1

        execute_values(cursor, "insert into mlbam_pitchfx values %s", insert_data)
