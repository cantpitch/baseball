drop table if exists retro_event_codes;
create table retro_event_codes (
  event_cd smallint primary key,
  event_name varchar(30) not null
);

insert into retro_event_codes values
(0, 'Unknown (obsolete)'),
(1, 'None (obsolete)'),
(2, 'Generic out'),
(3, 'Strikeout'),
(4, 'Stolen Base'),
(5, 'Defensive Indifference'),
(6, 'Caught Stealing'),
(7, 'Pickoff Error (obsolete)'),
(8, 'Pickoff'),
(9, 'Wild Pitch'),
(10, 'Passed Ball'),
(11, 'Balk'),
(12, 'Other Advance/Out Advancing'),
(13, 'Foul Error'),
(14, 'Walk'),
(15, 'Intentional Walk'),
(16, 'Hit by Pitch'),
(17, 'Interference'),
(18, 'Error'),
(19, 'Fielder''s Choice'),
(20, 'Single'),
(21, 'Double'),
(22, 'Triple'),
(23, 'Home Run'),
(24, 'Missing Play (obsolete)');

drop table if exists retro_bases_codes;
create table retro_bases_codes (
  bases_cd smallint primary key,
  bases_short_desc varchar(3) not null,
  bases_long_desc varchar(20) not null
);

insert into retro_bases_codes values
(0, '',    'Bases Empty'),
(1, '1',   '1B'),
(2, '2',   '2B'),
(3, '12',  '1B & 2B'),
(4, '3',   '3B'),
(5, '13',  '1B & 3B'),
(6, '23',  '2B & 3B'),
(7, '123', 'Bases Loaded');

drop table if exists retro_teams;
create table retro_teams (
    franch_id char(3) not null,
    team_id char(3) not null,
    lg_id char(2) not null,
    division char(1),
    name varchar(50),
    nickname varchar(50),
    additional_nicknames varchar(150),
    start_date date,
    end_date date,
    city varchar(50),
    state varchar(3)
);

drop table if exists retro_parks;
create table retro_parks (
    park_id char(5) not null primary key,
    park_name varchar(50),
    other_names varchar(150),
    city varchar(25),
    state_country varchar(25),
    start_date date,
    end_date date,
    lg_id char(2),
    details text
);

drop table if exists retro_players;
create table retro_players (
    name_last varchar(25),
    name_first varchar(25),
    retro_id varchar(8),
    debut_date date
);
