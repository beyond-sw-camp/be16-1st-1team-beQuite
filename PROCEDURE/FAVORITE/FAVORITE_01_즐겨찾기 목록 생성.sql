-- 1. 즐겨찾기 목록 생성
DELIMITER //
CREATE PROCEDURE insert_favoritelist(
    IN p_user_id BIGINT,
    IN p_name VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 목록 생성 실패';
    END;

    START TRANSACTION;

    INSERT INTO favoritelist (user_id, name)
    VALUES (p_user_id, p_name);

    COMMIT;
END //
DELIMITER ;
