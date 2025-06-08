-- 임시 테이블 생성
CREATE TABLE temp_pitcherstats (
`players_name` varchar(30) NOT NULL,
	`ERA` decimal(5,3) DEFAULT NULL,
  `G` int(11) NOT NULL,
  `W` int(11) DEFAULT NULL,
  `L` int(11) DEFAULT NULL,
  `SV` int(11) DEFAULT NULL,
  `HLD` int(11) DEFAULT NULL,
  `WLCT` decimal(4,3) DEFAULT NULL,
  `IP` varchar(10) DEFAULT NULL,
  `H` int(11) DEFAULT NULL,
  `HR` int(11) DEFAULT NULL,
  `BB` int(11) DEFAULT NULL,
  `HBP` int(11) DEFAULT NULL,
  `SO` int(11) DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `ER` int(11) DEFAULT NULL,
  `WHIP` varchar(10) DEFAULT NULL,
  `CG` int(11) DEFAULT NULL,
  `SHO` int(11) DEFAULT NULL,
  `QS` int(11) DEFAULT NULL,
  `BSV` int(11) DEFAULT NULL,
  `TBF` int(11) DEFAULT NULL,
  `NP` int(11) DEFAULT NULL,
  `AVG` decimal(4,3) DEFAULT NULL,
  `2B` int(11) DEFAULT NULL,
  `3B` int(11) DEFAULT NULL,
  `SAC` int(11) DEFAULT NULL,
  `SF` int(11) DEFAULT NULL,
  `IBB` int(11) DEFAULT NULL,
  `WP` int(11) DEFAULT NULL,
  `BK` int(11) DEFAULT NULL
);

-- 임시 테이블 삭제
drop table temp_pitcherstats;

-- 투수스탯 입력
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/pitcherStats.csv'
INTO TABLE temp_pitcherstats
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- pitcherstats 테이블에 데이터 넣기
INSERT INTO pitcherstats(players_id,ERA ,G, W, L, SV, HLD, WLCT, IP, H, HR, BB, HBP, SO, R, ER, WHIP, CG, SHO, QS, BSV, TBF, NP, `AVG`, 2B, 3B, SAC, SF, IBB, WP, BK)
SELECT p.id, tp.ERA ,tp.G, tp.W, tp.L, tp.SV, tp.HLD, tp.WLCT, tp.IP, tp.H, tp.HR, tp.BB, tp.HBP, tp.SO, tp.R, tp.ER, tp.WHIP, 
tp.CG, tp.SHO, tp.QS, tp.BSV, tp.TBF, tp.NP, tp.`AVG`, tp.`2B`, tp.`3B`, tp.SAC, tp.SF, tp.IBB, tp.WP, tp.BK
FROM players p
JOIN  temp_pitcherstats tp
ON REPLACE(TRIM(tp.players_name), '\r', '') = TRIM(p.name);