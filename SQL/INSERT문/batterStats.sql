-- 임시 테이블 생성
CREATE TABLE temp_batterstats (
`players_name` varchar(30) NOT NULL,
	`AVG` decimal(4,3) DEFAULT NULL,
  `G` int(11) NOT NULL,
  `PA` int(11) DEFAULT NULL,
  `AB` int(11) DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `H` int(11) DEFAULT NULL,
  `2B` int(11) DEFAULT NULL,
  `3B` int(11) DEFAULT NULL,
  `HR` int(11) DEFAULT NULL,
  `TB` int(11) DEFAULT NULL,
  `RBI` int(11) DEFAULT NULL,
  `SAC` int(11) DEFAULT NULL,
  `SF` int(11) DEFAULT NULL,
  `BB` int(11) DEFAULT NULL,
  `IBB` int(11) DEFAULT NULL,
  `HBP` int(11) DEFAULT NULL,
  `SO` int(11) DEFAULT NULL,
  `GDP` int(11) DEFAULT NULL,
  `SLG` decimal(4,3) DEFAULT NULL,
  `OBP` decimal(4,3) DEFAULT NULL,
  `MH` int(11) DEFAULT NULL,
  `RISP` decimal(4,3) DEFAULT NULL,
  `ops` decimal(4,3) DEFAULT NULL
);

-- 임시 테이블 삭제
drop table temp_batterstats;

-- 타자스탯 입력
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/batterStats.csv'
INTO TABLE temp_batterStats
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- batterstats 테이블에 데이터 넣기
INSERT INTO batterstats(players_id,`AVG`, G, PA, AB, R, H, `2B`, `3B`, HR, TB, RBI, SAC, SF, BB, IBB, HBP, SO, GDP, SLG, OBP, ops, MH, RISP)
SELECT p.id, tb.`AVG`, tb.G, tb.PA, tb.AB, tb.R, tb.H, tb.`2B`, tb.`3B`, tb.HR, tb.TB, tb.RBI, tb.SAC, tb.SF, 
tb.BB, tb.IBB, tb.HBP, tb.SO, tb.GDP, tb.SLG, tb.OBP, tb.ops, tb.MH, tb.RISP 
FROM players p
JOIN  temp_batterstats tb
ON REPLACE(TRIM(tb.players_name), '\r', '') = TRIM(p.name);