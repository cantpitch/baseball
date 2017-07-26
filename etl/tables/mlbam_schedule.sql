drop table if exists mlbam_schedule;
create table mlbam_schedule (
    gid varchar(30) not null primary key, 
    venue varchar(50),
    date_game timestamp,
    away_team char(3) not null,
    home_team char(3) not null,
    away_team_score smallint not null,
    home_team_score smallint not null,
    away_team_hits smallint not null,
    home_team_hits smallint not null,
    away_team_errors smallint not null,
    home_team_errors smallint not null,
    innings smallint not null
);