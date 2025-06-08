-- FANTEAM_01 가상구단 구성

-- =============================================================================
-- 프로시저: fanteam구성
-- 용도    : 사용자별 가상구단(fanteam) 생성 및 멤버(fanteammember) 등록
-- 입력    : 
--    user_id_Input   BIGINT(20) – 회원 ID
--    name_Input      VARCHAR(30) – 가상구단 이름
--    players_List    TEXT        – 쉼표(,)로 연결된 선수 ID 문자열
-- 흐름    :
--  1) 트랜잭션 시작 전 예외 핸들러 등록  
--  2) 트랜잭션 시작  
--  3) 이미 가상구단이 있는지 체크 → 있으면 에러 회신 후 종료  
--  4) fanteam 테이블에 새 레코드 INSERT → 생성된 ID 저장  
--  5) players_List를 파싱하여 각 선수 ID마다 fanteammember 테이블에 INSERT  
--  6) 커밋 후 성공 메시지 반환  
-- =============================================================================
-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 가상구단구성;
DELIMITER //

CREATE PROCEDURE 가상구단구성(
    IN user_id_Input   BIGINT(20),    -- (1) 회원 ID
    IN name_Input      VARCHAR(30),   -- (2) 가상구단 이름
    IN players_List    TEXT           -- (3) 쉼표로 구분된 선수 ID 목록
)
BEGIN
    DECLARE fanteam_id       BIGINT(20);    -- 생성된 fanteam의 PK 저장
    DECLARE position         INT;           -- 파싱용 쉼표 위치 인덱스
    DECLARE individual_player VARCHAR(20);  -- 파싱된 개별 선수 ID
    -- 1) SQL 예외 핸들러: 어떤 에러든 ROLLBACK 후 메시지 한 줄
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;
  
    START TRANSACTION;

    -- 2) 같은 id로 중복 구단 존재 여부 체크
    IF EXISTS (
        SELECT 1 FROM `fanteam`
         WHERE `user_id` = user_id_Input
    ) THEN
      SELECT 'ERROR: fan team already exists' AS message;
      ROLLBACK;

    ELSE
      -- 3) 구단 생성
      INSERT INTO `fanteam` (`user_id`,`name`,`has_fanTeam`)
        VALUES (user_id_Input, name_Input, 'Y');
      SET fanteam_id = LAST_INSERT_ID();

      -- 4) players_List 파싱 & 멤버 등록
      -- players_List가 남아 있는 동안 반복
      WHILE TRIM(players_List) <> '' DO
        -- , 위치 찾기
        SET position = LOCATE(',', players_List);
        IF position > 0 THEN
          SET individual_player = TRIM(SUBSTRING(players_List,1,position-1));
          SET players_List = SUBSTRING(players_List,position+1);
        ELSE
          SET individual_player = TRIM(players_List);
          SET players_List = '';
        END IF;
        INSERT INTO `fanteammember` (`players_id`,`fanteam_id`)
          VALUES (CAST(individual_player AS UNSIGNED), fanteam_id);
      END WHILE;

      -- 5) 커밋 & 성공 메시지
      COMMIT;
      SELECT 'SUCCESS: fan team created with members' AS message;
    END IF;
END;
//
DELIMITER ;
