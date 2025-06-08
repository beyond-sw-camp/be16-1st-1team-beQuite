-- FANTEAM_02 가상구단 수정

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 가상구단수정;
DELIMITER //

CREATE PROCEDURE 가상구단수정(
    IN user_id_Input   BIGINT(20),    -- 수정할 대상 회원의 ID
    IN name_Input      VARCHAR(30),   -- 새 구단 이름
    IN players_List    TEXT           -- 쉼표로 구분된 선수 ID 목록
)
BEGIN
    DECLARE fanteam_id          BIGINT(20);    -- 수정할 fanteam PK 저장
    DECLARE position            INT;           -- 파싱용 구분자 위치
    DECLARE individual_player   VARCHAR(20);   -- 개별 선수 ID
    DECLARE com_fanteam_id      BIGINT;        -- 비교할 comparison id 선언
    -- SQL 에러 시 메시지 반환 및 롤백
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    START TRANSACTION;

    -- 1) 구단 존재 여부 확인
    IF NOT EXISTS (
        SELECT 1 FROM `fanteam`
         WHERE `user_id` = user_id_Input
    ) THEN
      SELECT 'ERROR: fan team not found' AS message;
      ROLLBACK;

    ELSE
      -- 2) 구단 이름 업데이트
      UPDATE `fanteam`
         SET `name` = name_Input
       WHERE `user_id` = user_id_Input;

      -- 3) fanteam_id 조회
      SELECT `id` INTO com_fanteam_id
        FROM `fanteam`
       WHERE `user_id` = user_id_Input;

      -- 4) com_fanteam_id 값과 컬럼 fanteam_id 를 비교
      DELETE FROM fanteammember
        WHERE fanteam_id = com_fanteam_id;

      -- 5) players_List 파싱 후 새 멤버 추가
      WHILE TRIM(players_List) <> '' DO
        SET position = LOCATE(',', players_List);
        IF position > 0 THEN
          SET individual_player = TRIM(SUBSTRING(players_List,1,position-1));
          SET players_List = SUBSTRING(players_List, position+1);
        ELSE
          SET individual_player = TRIM(players_List);
          SET players_List = '';
        END IF;
        INSERT INTO `fanteammember` (`players_id`,`fanteam_id`)
          VALUES (CAST(individual_player AS UNSIGNED), fanteam_id);
      END WHILE;

      -- 6) 커밋 및 성공 메시지
      COMMIT;
      SELECT 'SUCCESS: fan team updated' AS message;
    END IF;
END;
//
DELIMITER ;