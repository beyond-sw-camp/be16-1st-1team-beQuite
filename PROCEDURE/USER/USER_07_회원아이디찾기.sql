-- USER_07 회원 아이디(이메일) 찾기

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 아이디찾기;
DELIMITER //

CREATE PROCEDURE 회원아이디찾기(
    IN name_Input  VARCHAR(30),   -- 회원 이름
    IN phone_Input VARCHAR(30)    -- 회원 전화번호
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
         WHERE `name`  = name_Input
           AND `phone` = phone_Input
    ) THEN
      SELECT 'ERROR: user not found' AS message;

    ELSE
      -- 3) 정상 조회: 해당 회원의 이메일(아이디) 반환
      SELECT
        email AS found_email
      FROM `user`
      WHERE `name`  = name_Input
        AND `phone` = phone_Input;
    END IF;
END;
//
DELIMITER ;