-- FANTEAM_06 특정 사용자 팬 투표 집계

DROP PROCEDURE IF EXISTS `특정 사용자 팬 투표 집계`;
DELIMITER $$
CREATE PROCEDURE `특정 사용자 팬 투표 집계`(
    IN p_user_id BIGINT
)
BEGIN
    SELECT
      p.id           AS player_id,
      p.name         AS player_name,
      COUNT(*)       AS pick_count
    FROM fanteammember AS fm
    JOIN fanteam     AS ft ON fm.fanteam_id = ft.id
    JOIN players     AS p  ON fm.players_id  = p.id
    WHERE ft.user_id = p_user_id
    GROUP BY p.id, p.name
    ORDER BY pick_count DESC;
END$$
DELIMITER ;