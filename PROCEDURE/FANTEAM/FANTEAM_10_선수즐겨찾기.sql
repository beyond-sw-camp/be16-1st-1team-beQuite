-- FANTEAM_10 선수 즐겨찾기

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 선수즐겨찾기;
DELIMITER //

CREATE PROCEDURE 선수즐겨찾기(
    IN  user_id_Input      BIGINT(20),     -- (1) 사용자 ID
    IN  list_name_Input    VARCHAR(30),    -- (2) 즐겨찾기 리스트 이름
    IN  player_id_Input    BIGINT(20)      -- (3) 등록/해제할 선수 ID
)
BEGIN
    -- 로컬 변수 선언
    DECLARE v_favlist_id BIGINT(20);

    -- SQL 예외 핸들러: 에러 시 ROLLBACK + 메시지 반환
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    START TRANSACTION;

    -- 1) 즐겨찾기 리스트가 없으면 새로 생성
    IF NOT EXISTS (
        SELECT 1
          FROM favoritelist
         WHERE user_id = user_id_Input
           AND name    = list_name_Input
    ) THEN
      INSERT INTO favoritelist (user_id, name)
           VALUES (user_id_Input, list_name_Input);
      SET v_favlist_id = LAST_INSERT_ID();
    ELSE
      -- 이미 있으면 그 ID를 가져옴
      SELECT id INTO v_favlist_id
        FROM favoritelist
       WHERE user_id = user_id_Input
         AND name    = list_name_Input
       LIMIT 1;
    END IF;

    -- 2) 이미 등록된 상태면 삭제
    IF EXISTS (
        SELECT 1
          FROM favoriteplayers
         WHERE favoriteList_id = v_favlist_id
           AND players_id      = player_id_Input
    ) THEN
      DELETE FROM favoriteplayers
       WHERE favoriteList_id = v_favlist_id
         AND players_id      = player_id_Input;
      COMMIT;
      SELECT 'SUCCESS: removed from favorites' AS message;

    ELSE
      -- 3) 등록되지 않은 상태면 추가
      INSERT INTO favoriteplayers (players_id, favoriteList_id)
           VALUES (player_id_Input, v_favlist_id);
      COMMIT;
      SELECT 'SUCCESS: added to favorites'   AS message;
    END IF;
END;
//
DELIMITER ;
