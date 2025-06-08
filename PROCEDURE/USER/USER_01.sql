-- USER_01 회원가입
-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원가입;  
DELIMITER //
CREATE PROCEDURE 회원가입(
    IN leagueTeam_id_Input BIGINT(20),            -- 응원 팀 ID
    IN email_Input         VARCHAR(50),           -- 이메일
    IN password_Input      VARCHAR(20),           -- 비밀번호
    IN name_Input          VARCHAR(30),           -- 이름
    IN phone_Input         VARCHAR(30),           -- 전화번호
    IN age_Input           TINYINT(4),            -- 나이
    IN role_Input          ENUM('admin','user')   -- 권한 (NULL 허용, 이후 COALESCE 처리)
)
BEGIN
    -- 1) 변수 선언 (세미콜론 반드시)
    DECLARE user_id_Input BIGINT(20);
    -- 2) 예외 핸들러: 에러 시 롤백
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    -- 3) 트랜잭션 시작
    START TRANSACTION;
    -- 4) 회원 정보 INSERT
    INSERT INTO `user` (
      leagueTeam_id,
      email,
      password,
      name,
      phone,
      age,
      role
    ) VALUES (
      leagueTeam_id_Input,
      email_Input,
      password_Input
      name_Input,
      phone_Input,
      age_Input,
      COALESCE(role_Input, 'user')   -- role_Input이 NULL이면 'user' 대체
    );
    -- 5) 방금 생성된 AUTO_INCREMENT ID를 변수에 저장
    SET user_id_Input = LAST_INSERT_ID();
    -- 6) 커밋
    COMMIT;
    -- 7) 결과 반환
    SELECT user_id_Input AS new_user_id;
END
//
DELIMITER ;