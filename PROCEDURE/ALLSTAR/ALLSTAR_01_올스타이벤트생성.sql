DROP PROCEDURE IF EXISTS 올스타이벤트생성;
DELIMITER //

CREATE PROCEDURE 올스타이벤트생성(
    IN event_name_Input   VARCHAR(100),
    IN description_Input  TEXT,
    IN start_date_Input   DATE,
    IN end_date_Input     DATE,
    IN status_Input       VARCHAR(10),       -- ENUM 대신 VARCHAR
    IN created_by_Input   VARCHAR(30)
)
BEGIN
    DECLARE new_allstar_id BIGINT(20);

    -- SQL 예외 핸들러: 에러 시 롤백 + 메시지 반환
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    START TRANSACTION;

    -- 올스타 이벤트 생성
    INSERT INTO `allstar` (
      event_name,
      description,
      start_date,
      end_date,
      status,
      created_by
    ) VALUES (
      event_name_Input,
      description_Input,
      start_date_Input,
      end_date_Input,
      -- 소문자로 변환한 뒤, 유효한 ENUM 값만 넣음
      CASE 
        WHEN LOWER(status_Input) IN('open','closed') 
        THEN LOWER(status_Input) 
        ELSE 'open' 
      END,
      created_by_Input
    );

    -- 새로 생성된 ID 저장
    SET new_allstar_id = LAST_INSERT_ID();

    COMMIT;

    -- 결과 반환
    SELECT new_allstar_id AS allstar_id;
END;
//
DELIMITER ;
