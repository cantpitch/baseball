# Only process complete innings. Exclude home innings in 9th inning or later.
DROP TABLE IF EXISTS tmp_complete_innings;
CREATE TEMPORARY TABLE tmp_complete_innings
  SELECT game_id, inn_ct, bat_home_id
    FROM events
   WHERE inn_end_fl = 'T'
         AND (event_outs_ct + outs_ct = 3)   # make sure it's a complete half-inning
         AND NOT (inn_ct >= 9 and bat_home_id=1) # exclude home innings from 9th on
;
ALTER TABLE tmp_complete_innings ADD INDEX (game_id, inn_ct, bat_home_id);
 
DROP TABLE IF EXISTS tmp_re;
CREATE TABLE tmp_re
  SELECT start_bases_cd,
         cds.bases_long_desc, 
         outs_ct, 
         AVG(event_runs_ct + fate_runs_ct) AS RE
    FROM events e
    JOIN tmp_complete_innings inns USING (game_id, inn_ct, bat_home_id)
    JOIN bases_cds cds ON e.start_bases_cd = cds.bases_cd
   WHERE year_id BETWEEN 1993 AND 2015
GROUP BY start_bases_cd, cds.bases_long_desc, outs_ct
;
ALTER TABLE tmp_re ADD INDEX (start_bases_cd, outs_ct);

  SELECT e.event_cd,
         ecds.event_name,
         AVG(postevent.RE - preevent.RE + e.event_runs_ct) AS linwgt
    FROM events e
    JOIN tmp_complete_innings inns USING (game_id, inn_ct, bat_home_id)
    # find the RE value before this event
    JOIN tmp_re preevent USING (start_bases_cd, outs_ct)
    # find the RE value after this event (notice that we increment any outs)
    JOIN tmp_re postevent ON e.end_bases_cd = postevent.start_bases_cd 
                       AND (e.outs_ct + e.event_outs_ct) = postevent.outs_ct
    # get pretty names for event codes
    JOIN event_cds ecds USING (event_cd)
   WHERE e.event_cd IN ( 20, 21, 22, 23, 16, 9, 8, 6, 3, 2, 4, 14, 15 ) 
         AND year_id BETWEEN 1993 AND 2015
GROUP BY event_cd
;