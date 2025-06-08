-- FANTEAM_03 가상구단 삭제

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 가상구단삭제;
DELIMITER //

CREATE PROCEDURE 가상구단삭제(
    IN user_id_Input BIGINT(20)    -- 탈퇴(삭제)할 회원의 ID
)
BEGIN
    -- 1) 로컬 변수 선언
    DECLARE fanteam_id BIGINT(20);

    -- 2) 예외 핸들러: SQL 에러 시 ROLLBACK 후 메시지 리턴
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR: unexpected database error' AS message;
    END;

    -- 3) 트랜잭션 시작
    START TRANSACTION;

    -- 4) 가상구단 존재 여부 체크
    IF NOT EXISTS (
        SELECT 1
          FROM `fanteam`
         WHERE `user_id` = user_id_Input
    ) THEN
        -- 구단이 없으면 롤백하고 메시지 반환
        ROLLBACK;
        SELECT 'ERROR: fan team not found' AS message;

    ELSE
        -- 5) fanteam_id 조회
        SELECT `id`
          INTO fanteam_id
          FROM `fanteam`
         WHERE `user_id` = user_id_Input
         LIMIT 1;

        -- 6) 연관 멤버 레코드 삭제
        DELETE FROM `fanteammember`
         WHERE `fanteam_id` = fanteam_id;

        -- 7) 가상구단 자체 삭제
        DELETE FROM `fanteam`
         WHERE `id` = fanteam_id;

        -- 8) 모두 정상 처리되면 커밋 후 성공 메시지
        COMMIT;
        SELECT 'SUCCESS: fan team deleted' AS message;
    END IF;
END;
//
DELIMITER ;
