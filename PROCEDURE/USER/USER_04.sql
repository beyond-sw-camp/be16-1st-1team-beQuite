DROP PROCEDURE IF EXISTS 회원탈퇴;
DELIMITER //

CREATE PROCEDURE 회원탈퇴(
    IN user_id_Input BIGINT(20)    -- 탈퇴시킬 회원의 ID
)
BEGIN
    -- 1) SQL 예외 핸들러: 에러 시 메시지 한 줄 리턴
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 2) 트랜잭션 시작
    START TRANSACTION;

    -- 3) 회원 존재 여부 확인
    IF NOT EXISTS (
        SELECT 1 FROM `user`
         WHERE `id` = user_id_Input
    ) THEN
      SELECT 'ERROR: user not found' AS message;
      ROLLBACK;

    ELSE
      -- 4) 실제 삭제 수행
      DELETE FROM `user`
       WHERE `id` = user_id_Input;

      COMMIT;
      SELECT 'SUCCESS: user deleted' AS message;
    END IF;
END;
//
DELIMITER ;