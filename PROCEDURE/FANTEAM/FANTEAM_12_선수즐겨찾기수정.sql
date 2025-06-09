-- FANTEAM_12 선수 즐겨찾기 수정

DROP PROCEDURE IF EXISTS 선수즐겨찾기수정;
DELIMITER //

CREATE PROCEDURE 선수즐겨찾기수정(
    IN  user_id_Input        BIGINT(20),     -- (1) 사용자 ID
    IN  list_name_Input      VARCHAR(30),    -- (2) 즐겨찾기 리스트 이름
    IN  old_player_id_Input  BIGINT(20),     -- (3) 기존 등록된 선수 ID
    IN  new_player_id_Input  BIGINT(20)      -- (4) 새로 교체할 선수 ID
)
BEGIN
    -- 1) 로컬 변수 선언
    DECLARE v_list_id BIGINT(20);
    DECLARE v_fav_id  BIGINT(20);

    -- 2) 예외 핸들러: SQL 에러 시 ROLLBACK + 메시지 반환
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    START TRANSACTION;

    -- 3) 즐겨찾기 리스트 존재 여부
    IF NOT EXISTS (
      SELECT 1 FROM favoritelist
       WHERE user_id = user_id_Input
         AND name    = list_name_Input
    ) THEN
      ROLLBACK;
      SELECT 'ERROR: favorite list not found' AS message;

    ELSE
      -- 4) 리스트 ID 가져오기
      SELECT id
        INTO v_list_id
        FROM favoritelist
       WHERE user_id = user_id_Input
         AND name    = list_name_Input
       LIMIT 1;

      -- 5) 원래 선수 등록 여부
      IF NOT EXISTS (
        SELECT 1 FROM favoriteplayers
         WHERE favoriteList_id = v_list_id
           AND players_id      = old_player_id_Input
      ) THEN
        ROLLBACK;
        SELECT 'ERROR: original favorite not found' AS message;

      -- 6) 새 선수 이미 등록 여부
      ELSEIF EXISTS (
        SELECT 1 FROM favoriteplayers
         WHERE favoriteList_id = v_list_id
           AND players_id      = new_player_id_Input
      ) THEN
        ROLLBACK;
        SELECT 'ERROR: player already in favorites' AS message;

      ELSE
        -- 7) 실제 교체(UPDATE)
        UPDATE favoriteplayers
           SET players_id = new_player_id_Input
         WHERE favoriteList_id = v_list_id
           AND players_id      = old_player_id_Input;

        COMMIT;
        SELECT 'SUCCESS: favorite updated' AS message;
      END IF;

    END IF;
END;
//
DELIMITER ;
