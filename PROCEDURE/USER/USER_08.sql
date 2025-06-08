-- USER_08 회원 비밀번호 찾기

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원비밀번호찾기;
DELIMITER //

CREATE PROCEDURE 회원비밀번호찾기(
    IN email_Input VARCHAR(50),   -- 조회할 회원의 이메일
    IN phone_Input VARCHAR(30)    -- 조회할 회원의 전화번호
)
BEGIN
    -- 1) SQL 예외 핸들러: 에러 시 메시지 한 줄 리턴
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 2) 회원 존재 여부 확인
    IF NOT EXISTS (
        SELECT 1
          FROM `user`
         WHERE `email` = email_Input
           AND `phone` = phone_Input
    ) THEN
      SELECT 'ERROR: user not found' AS message;

    ELSE
      -- 3) 정상 조회: 해당 회원의 비밀번호 반환
      SELECT
        `password` AS found_password
      FROM `user`
      WHERE `email` = email_Input
        AND `phone` = phone_Input;
    END IF;
END;
//
DELIMITER ;
