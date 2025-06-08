-- FANTEAM_09 총 투표 수 집계

SELECT
  COUNT(*) AS total_votes
FROM fanteammember fm
JOIN fanteam f
  ON fm.fanteam_id = f.id
 AND f.has_fanTeam = 'Y';


-- 같은 선수가 한 구단에 중복 삽입될 가능성을 방지하고 “구단당 최대 1표” 원칙을 확실히 지키고 싶다면, 아래처럼 DISTINCT 조합
SELECT
  COUNT(DISTINCT fm.fanteam_id, fm.players_id) AS total_votes
FROM fanteammember fm
JOIN fanteam f
  ON fm.fanteam_id = f.id
 AND f.has_fanTeam = 'Y';
