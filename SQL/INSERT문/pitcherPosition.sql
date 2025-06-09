-- 임시 테이블 생성
CREATE TABLE temp_pitcherposition (
    temp_playername VARCHAR(50),
    temp_pitcherposition varchar(30)
);

-- 임시 테이블 삭제
drop table temp_pitcherposition;

-- 선수 이름과 포지션이 있는 파일 받기
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/pitcherposition.csv'
INTO TABLE temp_pitcherposition
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from temp_pitcherposition;

-- pitcherPosition 테이블에 데이터 넣기
INSERT INTO pitcherPosition(positioned_id, pitcherPosition)
SELECT sub.id, tp.temp_pitcherposition
FROM temp_pitcherposition tp
JOIN (
    SELECT players.name, positioned.id
    FROM players
    JOIN positioned ON players.id = positioned.players_id
) AS sub
ON REPLACE(TRIM(tp.temp_playername), '\r', '') = TRIM(sub.name);

select * from pitcherPosition;
select * from positioned;