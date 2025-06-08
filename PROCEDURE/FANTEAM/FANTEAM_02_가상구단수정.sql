-- FANTEAM_02 가상구단 수정

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 가상구단수정;
DELIMITER //

CREATE PROCEDURE 가상구단수정(
    IN  user_id_Input   BIGINT(20),    -- 수정할 대상 회원의 ID
    IN  name_Input      VARCHAR(30),   -- 새 구단 이름
    IN  players_List    TEXT           -- 쉼표로 구분된 선수 ID 목록
)
BEGIN
    -- 1) 로컬 변수 선언 (반드시 BEGIN 바로 다음)
    DECLARE v_fanteam_id       BIGINT(20);    -- fanteam PK 저장
    DECLARE v_position         INT;           -- 파싱용 쉼표 위치
    DECLARE v_player           VARCHAR(20);   -- 개별 선수 ID

    -- 2) SQL 예외 핸들러: 에러 시 ROLLBACK + 메시지 반환
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 3) 트랜잭션 시작
    START TRANSACTION;

    -- 4) 구단 존재 여부 확인
    IF NOT EXISTS (
        SELECT 1 FROM `fanteam`
         WHERE `user_id` = user_id_Input
    ) THEN
      ROLLBACK;
      SELECT 'ERROR: fan team not found' AS message;
    ELSE

      -- 5) 구단 이름 업데이트
      UPDATE `fanteam`
         SET `name` = name_Input
       WHERE `user_id` = user_id_Input;

      -- 6) fanteam_id 조회하여 variable_fanteam_id 에 저장
      SELECT `id`
        INTO v_fanteam_id
        FROM `fanteam`
       WHERE `user_id` = user_id_Input;

      -- 7) 기존 멤버만 정확히 삭제
      DELETE FROM `fanteammember`
       WHERE `fanteam_id` = v_fanteam_id;

      -- 8) players_List 파싱 & 새 멤버 추가
      WHILE TRIM(players_List) <> '' DO
        SET v_position = LOCATE(',', players_List);
        IF v_position > 0 THEN
          SET v_player = TRIM(SUBSTRING(players_List,1,v_position-1));
          SET players_List = SUBSTRING(players_List, v_position+1);
        ELSE
          SET v_player = TRIM(players_List);
          SET players_List = '';
        END IF;
        INSERT INTO `fanteammember` (`players_id`,`fanteam_id`)
          VALUES (CAST(v_player AS UNSIGNED), v_fanteam_id);
      END WHILE;

      -- 9) 커밋 및 성공 메시지
      COMMIT;
      SELECT 'SUCCESS: fan team updated' AS message;

    END IF;
END;
//
DELIMITER ;
