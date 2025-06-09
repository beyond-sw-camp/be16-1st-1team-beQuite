-- 임시 테이블 생성
CREATE TABLE positioned_players (
    player_name VARCHAR(50),
    positioned enum("batter", "pitcher")
);

-- 임시 테이블 삭제
drop table positioned_players;

-- 선수 이름과 포지션이 있는 파일 받기
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/positioned.csv'
INTO TABLE positioned_players
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- positioned테이블에 선수 이름에 맞는 선수ID와 포지션 이름(batter, pitcher) 넣기
INSERT INTO positioned (players_id, name)
SELECT p.id, tp.positioned
FROM players p
JOIN positioned_players tp
ON REPLACE(TRIM(tp.player_name), '\r', '') = TRIM(p.name); -- csv파일을 가져오면 '\r'값이 들어오므로 제거하기