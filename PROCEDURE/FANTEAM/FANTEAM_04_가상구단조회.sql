-- FANTEAM_04 가상구단 조회
-- 기존 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS `FANTEAM_04_가상구단조회`;

-- 구분자 변경
DELIMITER $$

CREATE PROCEDURE `FANTEAM_04_가상구단조회`(
    IN p_user_id BIGINT
)
BEGIN
    SELECT
      p.id          AS player_id,
      p.name        AS player_name
    FROM fanteam    AS f
    JOIN fanteammember AS fm
      ON fm.fanteam_id = f.id
    JOIN players    AS p
      ON fm.players_id  = p.id
    WHERE f.user_id = p_user_id
    ORDER BY p.name;
END$$

-- 구분자 원복
DELIMITER ;
