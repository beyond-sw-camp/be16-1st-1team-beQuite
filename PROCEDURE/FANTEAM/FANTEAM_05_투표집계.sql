-- FANTEAM_05 투표 집계

-- 전체 fanteam 에 걸쳐 몇 명의 팬이 그 선수를 선택했는지 집계
SELECT
  p.id           AS player_id,
  p.name         AS player_name,
  COUNT(*)       AS total_pick_count
FROM fanteammember AS fm
JOIN players     AS p ON fm.players_id = p.id
GROUP BY p.id, p.name
ORDER BY total_pick_count DESC;

-- 특정 사용자의 fanteammember 테이블에 해당 선수가 몇 번 등장했는지 집계
SELECT
  p.id           AS player_id,
  p.name         AS player_name,
  COUNT(*)       AS pick_count
FROM fanteammember  AS fm
JOIN fanteam      AS ft ON fm.fanteam_id = ft.id
JOIN players      AS p  ON fm.players_id  = p.id
WHERE ft.user_id =  /* 조회할 user_id */
GROUP BY p.id, p.name
ORDER BY pick_count DESC;

-- 특정 사용자들의 fanteammember 테이블에 해당 선수가 몇 번 등장했는지 집계
SELECT
  p.id           AS player_id,
  p.name         AS player_name,
  COUNT(*)       AS pick_count
FROM fanteammember AS fm
JOIN fanteam AS ft
  ON fm.fanteam_id = ft.id
JOIN players AS p
  ON fm.players_id  = p.id
WHERE ft.user_id IN (유저1, 유저2, 유저3, ...)      -- ← 여러 명의 가상구단 모두 포함
GROUP BY p.id, p.name
ORDER BY pick_count DESC;
