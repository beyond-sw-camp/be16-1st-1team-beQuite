-- 1) FANTEAM_09: 총 투표 수 집계
DROP PROCEDURE IF EXISTS `FANTEAM_09_총투표집계`;
DELIMITER $$
CREATE PROCEDURE `FANTEAM_09_총투표집계`()
BEGIN
    SELECT
      COUNT(*) AS total_votes
    FROM fanteammember fm
    JOIN fanteam f
      ON fm.fanteam_id = f.id
     AND f.has_fanTeam = 'Y';
END$$
DELIMITER ;

