-- FANTEAM_04 가상구단 조회

SELECT
  p.id          AS player_id,
  p.name        AS player_name
FROM fanteam    AS f                  -- 사용자별 가상구단 테이블
JOIN fanteammember  AS fm
  ON fm.fanteam_id = f.id            -- 가상구단 ↔ 선수 연결 테이블 
JOIN players    AS p
  ON fm.players_id  = p.id           -- 선수 정보 테이블
WHERE f.user_id = /* 조회할 user_id */
ORDER BY p.name;
