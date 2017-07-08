DROP TABLE IF EXISTS event_cds;
CREATE TABLE event_cds (
  event_cd TINYINT(2) PRIMARY KEY,
  event_name VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT event_cds VALUES
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
(19, 'Fielder\'s Choice'),
(20, 'Single'),
(21, 'Double'),
(22, 'Triple'),
(23, 'Home Run'),
(24, 'Missing Play (obsolete)');

DROP TABLE IF EXISTS bases_cds;
CREATE TABLE bases_cds (
  bases_cd TINYINT(1) PRIMARY KEY,
  bases_short_desc CHAR(3) NOT NULL,
  bases_long_desc VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT bases_cds VALUES
(0, '',    'Bases Empty'),
(1, '1',   '1B'),
(2, '2',   '2B'),
(3, '12',  '1B & 2B'),
(4, '3',   '3B'),
(5, '13',  '1B & 3B'),
(6, '23',  '2B & 3B'),
(7, '123', 'Bases Loaded');