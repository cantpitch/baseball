# if run between 1999 and 2002, this will generate tango's run expectancy matrix here:
#
# http://www.tangotiger.net/RE9902.html
#

# Only process complete innings. Exclude home innings in 9th inning or later.
DROP TABLE tmp_complete_innings;
CREATE TEMPORARY TABLE tmp_complete_innings
  SELECT game_id, inn_ct, bat_home_id
    FROM events
   WHERE inn_end_fl = 'T'
         AND (event_outs_ct + outs_ct = 3)   # make sure it's a complete half-inning
         AND NOT (inn_ct >= 9 and bat_home_id=1) # exclude home innings from 9th on 
;
ALTER TABLE tmp_complete_innings ADD INDEX (game_id, inn_ct, bat_home_id);

  SELECT start_bases_cd, outs_ct, AVG(event_runs_ct + fate_runs_ct)
    FROM events
    JOIN tmp_complete_innings USING (game_id, inn_ct, bat_home_id)
   WHERE year_id BETWEEN 1999 AND 2002
GROUP BY start_bases_cd, outs_ct
;