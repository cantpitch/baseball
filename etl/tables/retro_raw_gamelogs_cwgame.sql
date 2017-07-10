
drop table if exists retro_raw_gamelogs_cwgame;
create table retro_raw_gamelogs_cwgame (
    game_id varchar(12) not null,
    start_time varchar(5),
    dh_used char(1),
    ps_scorer varchar(50),
    translator varchar(50),
    inputter varchar(50),
    input_time varchar(5),
    edit_time varchar(5),
    how_scored char(1),
    pitches_entered char(1),
    temperature smallint,
    wind_direction char(2),
    wind_speed smallint,
    field_condition varchar(10),
    precipitation varchar(10),
    sky varchar(10)
);

drop table if exists retro_postseason_raw_gamelogs_cwgame;
create table retro_postseason_raw_gamelogs_cwgame (like retro_raw_gamelogs_cwgame);

drop table if exists retro_allstar_raw_gamelogs_cwgame;
create table retro_allstar_raw_gamelogs_cwgame (like retro_raw_gamelogs_cwgame);