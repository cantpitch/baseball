drop table if exists retro_raw_sub;
create table retro_raw_sub (
    game_id varchar(12) not null,
    inning smallint,
    batting_team_id char(3),
    substitute_id char(9),
    substitute_team_id char(3),
    substitute_lineup_pos smallint,
    substitute_fielding_pos smallint,
    removed_id char(9),
    removed_fielding_pos smallint,
    event_id integer
);

drop table if exists retro_postseason_raw_sub;
create table retro_postseason_raw_sub (like retro_raw_sub);

drop table if exists retro_allstar_raw_sub;
create table retro_allstar_raw_sub (like retro_raw_sub);
