-- FANTEAM_07 다중 사용자 팬 투표 집계

-- p_user_list 에는 '1,2,3' 과 같이 콤마 구분된 user_id 문자열을 넘겨주세요.
DROP PROCEDURE IF EXISTS `다중 사용자 팬 투표 집계`;
DELIMITER $$
CREATE PROCEDURE `다중 사용자 팬 투표 집계`(
    IN p_user_list VARCHAR(255)
)
BEGIN
    SELECT
      p.id           AS player_id,
      p.name         AS player_name,
      COUNT(*)       AS pick_count
    FROM fanteammember AS fm
    JOIN fanteam     AS ft ON fm.fanteam_id = ft.id
    JOIN players     AS p  ON fm.players_id  = p.id
    WHERE FIND_IN_SET(ft.user_id, p_user_list)
    GROUP BY p.id, p.name
    ORDER BY pick_count DESC;
END$$
DELIMITER ;
