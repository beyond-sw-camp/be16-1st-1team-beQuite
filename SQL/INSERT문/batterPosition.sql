-- 임시 테이블 생성
CREATE TABLE temp_batterposition (
    temp_playername VARCHAR(50),
    temp_batterposition varchar(30)
);

-- 임시 테이블 삭제
drop table temp_batterposition;

-- 선수 이름과 포지션이 있는 파일 받기
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/batterposition.csv'
INTO TABLE temp_batterposition
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from temp_batterposition;

-- batterPosition 테이블에 데이터 넣기
INSERT INTO batterPosition(positioned_id, batterPosition)
SELECT sub.id, tb.temp_batterPosition
FROM temp_batterposition tb
JOIN (
    SELECT players.name, positioned.id
    FROM players
    JOIN positioned ON players.id = positioned.players_id
) AS sub
ON REPLACE(TRIM(tb.temp_playername), '\r', '') = TRIM(sub.name);

select * from batterPosition;