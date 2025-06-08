-- USER_05 회원 로그인

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원로그인;
DELIMITER //

CREATE PROCEDURE 회원로그인(
    IN email_Input VARCHAR(50),     -- 로그인용 이메일
    IN password_Input VARCHAR(20)   -- 로그인용 비밀번호
)
BEGIN
    -- 1) SQL 예외 핸들러: 에러 시 메시지 한 줄 리턴
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 2) 자격 확인
    IF NOT EXISTS (
        SELECT 1
          FROM `user`
         WHERE `email` = email_Input
           AND `password` = password_Input
    ) THEN
      -- 잘못된 정보
      SELECT 'ERROR: invalid credentials' AS message;
    ELSE
      -- 로그인 성공: 회원정보 반환
      SELECT
        id             AS user_id,
        leagueTeam_id  AS leagueTeam_id,
        email          AS email,
        `password`     AS password,
        `name`         AS name,
        phone          AS phone,
        age            AS age,
        role           AS role
      FROM `user`
      WHERE `email` = email_Input
        AND `password` = password_Input;
    END IF;
END;
//
DELIMITER ;
