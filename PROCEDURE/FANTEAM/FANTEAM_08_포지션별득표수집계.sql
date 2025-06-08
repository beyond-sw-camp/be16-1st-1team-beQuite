-- FANTEAM_08 포지션별 득표 수 집계

-- 포지션별 player들의 득표 수
SELECT
  p.id               AS player_id,
  p.name             AS player_name,
  lt.name            AS team_name,
  COUNT(*)           AS pick_count
FROM fanteammember fm
JOIN fanteam f 
  ON fm.fanteam_id   = f.id
JOIN players p       
  ON fm.players_id   = p.id
JOIN leagueteam lt   
  ON p.leagueTeam_id = lt.id
-- “타자” 분류 중, 배터 포지션이 포수인 선수만
JOIN positioned pos  
  ON pos.players_id  = p.id
 AND pos.name        = 'batter'     -- 원하는 포지션으로 변경
JOIN batterposition bp
  ON bp.positioned_id = pos.id
 AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '포수'    -- 원하는 포지션으로 변경
GROUP BY p.id, p.name, lt.name
ORDER BY pick_count DESC;