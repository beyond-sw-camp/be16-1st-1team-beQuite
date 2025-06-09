-- FANTEAM_11 선수 즐겨찾기 조회

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 선수즐겨찾기조회;
DELIMITER //

CREATE PROCEDURE 선수즐겨찾기조회(
    IN user_id_Input BIGINT(20)    -- 조회할 사용자 ID
)
BEGIN
    -- SQL 예외 핸들러: 에러 발생 시 메시지 반환
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 즐겨찾기 목록 조회
    SELECT
      fp.id               AS id,           -- favoriteplayers 테이블 PK
      fl.user_id          AS user_id,      -- favoritelist.user_id
      fp.players_id       AS player_id,    -- favoriteplayers.players_id
      fl.name             AS list_name     -- favoritelist.name
    FROM favoriteplayers fp
    JOIN favoritelist fl
      ON fp.favoriteList_id = fl.id
    WHERE fl.user_id = user_id_Input
    ORDER BY fl.name, fp.id;
END;
//
DELIMITER ;
