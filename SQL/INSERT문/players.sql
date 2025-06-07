-- 임시 테이블 생성
CREATE TABLE temp_players (
    player_name VARCHAR(50),
    team_name VARCHAR(50)
);

-- 임시 테이블 삭제
drop table temp_players;

-- 선수 이름 파일 받은 후 임시 테이블에 저장
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/players.csv'
INTO TABLE temp_players
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- players 테이블에 선수 이름과 팀이름에 맞는 id 넣기
INSERT INTO players (name, leagueteam_id)
SELECT tp.player_name, t.id
FROM temp_players tp
JOIN leagueteam t 
ON REPLACE(TRIM(tp.team_name), '\r', '') = TRIM(t.name); -- csv파일을 가져오면 '\r'값이 들어오므로 제거하기