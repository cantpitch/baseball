  SELECT start_bases_cd, outs_ct, AVG(event_runs_ct + fate_runs_ct)
    FROM events
   WHERE year_id BETWEEN 1999 AND 2002
GROUP BY start_bases_cd, outs_ct;