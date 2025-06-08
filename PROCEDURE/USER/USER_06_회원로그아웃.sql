-- USER_06 회원 로그아웃

-- DB로 임시구현
-- 사용 전 user 테이블에 logout 컬럼 생성
ALTER TABLE `user` ADD COLUMN last_logout DATETIME NULL AFTER age;

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원로그아웃;
DELIMITER //

CREATE PROCEDURE 로그아웃(
    IN user_id_Input BIGINT(20)    -- 로그아웃할 회원의 ID
)
BEGIN
    -- 1) SQL 예외 핸들러: 에러 시 메시지 한 줄 리턴
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    START TRANSACTION;

    -- 2) 회원 존재 여부 확인
    IF NOT EXISTS (
        SELECT 1
          FROM `user`
         WHERE `id` = user_id_Input
    ) THEN
      SELECT 'ERROR: user not found' AS message;
      ROLLBACK;

    ELSE
      -- 3) 로그아웃 시간 업데이트
      UPDATE `user`
         SET last_logout = NOW()
       WHERE `id` = user_id_Input;

      COMMIT;
      SELECT 'SUCCESS: user logged out' AS message;
    END IF;
END;
//
DELIMITER ;