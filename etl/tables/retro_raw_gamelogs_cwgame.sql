drop table if exists retro_raw_gamelogs_cwgame;
create table retro_raw_gamelogs_cwgame (
    game_id varchar(12) not null,
    start_time varchar(5),
    dh_used char(1),
    ps_scorer varchar(50),
    translator varchar(50),
    inputter varchar(50),
    input_time varchar(20),
    edit_time varchar(20),
    how_scored_cd smallint,
    pitches_entered_cd smallint,
    temperature smallint,
    wind_direction_cd smallint,
    wind_speed smallint,
    field_condition_cd smallint,
    precipitation_cd smallint,
    sky_cd smallint
);


drop table if exists retro_postseason_raw_gamelogs_cwgame;
create table retro_postseason_raw_gamelogs_cwgame like retro_raw_gamelogs_cwgame;

drop table if exists retro_allstar_raw_gamelogs_cwgame;
create table retro_allstar_raw_gamelogs_cwgame like retro_raw_gamelogs_cwgame;