-- USER_01 회원가입
-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원가입;  
DELIMITER //
CREATE PROCEDURE 회원가입(
    IN leagueTeam_id_Input BIGINT(20),            -- 응원 팀 ID
    IN email_Input         VARCHAR(50),           -- 이메일
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
      name,
      phone,
      age,
      role
    ) VALUES (
      leagueTeam_id_Input,
      email_Input,
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



-- USER_02 회원정보수정
-- 이미 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원정보수정;
DELIMITER //

CREATE PROCEDURE 회원정보수정(
    IN user_id_Input        BIGINT(20),            -- 수정할 회원의 id
    IN leagueTeam_id_Input  BIGINT(20),            -- 새 응원 팀 ID (NULL 허용)
    IN email_Input          VARCHAR(50),           -- 새 이메일
    IN name_Input           VARCHAR(30),           -- 새 이름
    IN phone_Input          VARCHAR(30),           -- 새 전화번호
    IN age_Input            TINYINT(4),            -- 새 나이
    IN role_Input           ENUM('admin','user')   -- 새 권한
)
BEGIN
    -- 1) 예외 핸들러: SQL 예외 발생 시 메시지 한 줄 리턴
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 2) 트랜잭션 시작
    START TRANSACTION;

    -- 3) 회원 존재 여부 / 이메일·전화 중복 / 정상흐름
    IF NOT EXISTS (
        SELECT 1 FROM `user` WHERE `id` = user_id_Input
    ) THEN
        SELECT 'ERROR: user not found'    AS message;
        ROLLBACK;

    ELSEIF EXISTS (
        SELECT 1 FROM `user`
         WHERE `email` = email_Input
           AND `id`   <> user_id_Input
    ) THEN
        SELECT 'ERROR: duplicate email'    AS message;
        ROLLBACK;

    ELSEIF EXISTS (
        SELECT 1 FROM `user`
         WHERE `phone` = phone_Input
           AND `id`   <> user_id_Input
    ) THEN
        SELECT 'ERROR: duplicate phone'    AS message;
        ROLLBACK;

    ELSE
        -- 4) 정상 UPDATE
        UPDATE `user`
           SET `leagueTeam_id` = leagueTeam_id_Input,
               `email`        = email_Input,
               `name`         = name_Input,
               `phone`        = phone_Input,
               `age`          = age_Input,
               `role`         = role_Input
         WHERE `id`           = user_id_Input;

        COMMIT;
        SELECT 'SUCCESS: user updated'     AS message;
    END IF;
END;
//
DELIMITER ;



-- USER_03 회원정보조회
-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원정보조회;
DELIMITER //

CREATE PROCEDURE 회원정보조회(
  IN user_id_Input BIGINT(20)
)
BEGIN
  -- 예외 핸들러: SQL 오류 시 메시지 한 줄 리턴
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    SELECT 'ERROR: unexpected database error' AS message;
  END;

  -- 존재 여부 체크 & SELECT
  IF NOT EXISTS (SELECT 1 FROM `user` WHERE `id`=user_id_Input) THEN
    SELECT 'ERROR: user not found' AS message;
  ELSE
    SELECT
      leagueTeam_id    AS leagueTeam_id,
      email            AS email,
      `name`           AS name,
      phone            AS phone,
      age              AS age,
      role             AS role
    FROM `user`
    WHERE `id` = user_id_Input;
  END IF;

END;
//
DELIMITER ;


-- USER_04 