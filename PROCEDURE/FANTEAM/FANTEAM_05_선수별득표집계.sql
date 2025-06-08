-- FANTEAM_05 선수별 득표 집계

DROP PROCEDURE IF EXISTS `선수별 득표 집계`;
DELIMITER $$
CREATE PROCEDURE `선수별 득표 집계`()
BEGIN
    SELECT
      p.id           AS player_id,
      p.name         AS player_name,
      COUNT(*)       AS total_pick_count
    FROM fanteammember AS fm
    JOIN players     AS p ON fm.players_id = p.id
    GROUP BY p.id, p.name
    ORDER BY total_pick_count DESC;
END$$
DELIMITER ;
