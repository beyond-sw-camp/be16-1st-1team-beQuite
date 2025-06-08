-- USER_02 회원정보수정
-- 이미 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원정보수정;
DELIMITER //

CREATE PROCEDURE 회원정보수정(
    IN user_id_Input        BIGINT(20),            -- 수정할 회원의 id
    IN leagueTeam_id_Input  BIGINT(20),            -- 새 응원 팀 ID (NULL 허용)
    IN email_Input          VARCHAR(50),           -- 새 이메일
    IN password_Input       VARCHAR(20),           -- 새 비밀번호
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
               `password`     = password_Input,
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