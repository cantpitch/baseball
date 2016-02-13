load data infile "/Users/hvs/Projects/retrosheet/data/playbyplay.csv" 
into table events 
fields terminated by ',' optionally enclosed by '"'
(game_id,away_team_id,inn_ct,bat_home_id,outs_ct,balls_ct,strikes_ct,pitch_seq_tx,away_score_ct,home_score_ct,bat_id,
	bat_hand_cd,resp_bat_id,resp_bat_hand_cd,pit_id,pit_hand_cd,resp_pit_id,resp_pit_hand_cd,pos2_fld_id,pos3_fld_id,
	pos4_fld_id,pos5_fld_id,pos6_fld_id,pos7_fld_id,pos8_fld_id,pos9_fld_id,base1_run_id,base2_run_id,base3_run_id,
	event_tx,leadoff_fl,ph_fl,bat_fld_cd,bat_lineup_id,event_cd,bat_event_fl,ab_fl,h_cd,sh_fl,sf_fl,event_outs_ct,
	dp_fl,tp_fl,rbi_ct,wp_fl,pb_fl,fld_cd,battedball_cd,bunt_fl,foul_fl,battedball_loc_tx,err_ct,err1_fld_cd,err1_cd,
	err2_fld_cd,err2_cd,err3_fld_cd,err3_cd,bat_dest_id,run1_dest_id,run2_dest_id,run3_dest_id,bat_play_tx,
	run1_play_tx,run2_play_tx,run3_play_tx,run1_sb_fl,run2_sb_fl,run3_sb_fl,run1_cs_fl,run2_cs_fl,run3_cs_fl,
	run1_pk_fl,run2_pk_fl,run3_pk_fl,run1_resp_pit_id,run2_resp_pit_id,run3_resp_pit_id,game_new_fl,game_end_fl,
	pr_run1_fl,pr_run2_fl,pr_run3_fl,removed_for_pr_run1_id,removed_for_pr_run2_id,removed_for_pr_run3_id,
	removed_for_ph_bat_id,removed_for_ph_bat_fld_cd,po1_fld_cd,po2_fld_cd,po3_fld_cd,ass1_fld_cd,ass2_fld_cd,
	ass3_fld_cd,ass4_fld_cd,ass5_fld_cd,event_id,home_team_id,bat_team_id,fld_team_id,bat_last_id,inn_new_fl,
	inn_end_fl,start_bat_score_ct,start_fld_score_ct,inn_runs_ct,game_pa_ct,inn_pa_ct,pa_new_fl,pa_trunc_fl,
	start_bases_cd,end_bases_cd,bat_start_fl,resp_bat_start_fl,bat_on_deck_id,bat_in_hold_id,pit_start_fl,
    resp_pit_start_fl,run1_fld_cd,run1_lineup_cd,run1_origin_event_id,run2_fld_cd,run2_lineup_cd,run2_origin_event_id,
    run3_fld_cd,run3_lineup_cd,run3_origin_event_id,run1_resp_cat_id,run2_resp_cat_id,run3_resp_cat_id,pa_ball_ct,
    pa_called_ball_ct,pa_intent_ball_ct,pa_pitchout_ball_ct,pa_hitbatter_ball_ct,pa_other_ball_ct,pa_strike_ct,
    pa_called_strike_ct,pa_swingmiss_strike_ct,pa_foul_strike_ct,pa_inplay_strike_ct,pa_other_strike_ct,event_runs_ct,
    fld_id,base2_force_fl,base3_force_fl,base4_force_fl,bat_safe_err_fl,bat_fate_id,run1_fate_id,run2_fate_id,
    run3_fate_id,fate_runs_ct,ass6_fld_cd,ass7_fld_cd,ass8_fld_cd,ass9_fld_cd,ass10_fld_cd,unknown_out_exc_fl,
    uncertain_play_exc_fl);

UPDATE events SET year_id = SUBSTR(game_id, 4, 4);

