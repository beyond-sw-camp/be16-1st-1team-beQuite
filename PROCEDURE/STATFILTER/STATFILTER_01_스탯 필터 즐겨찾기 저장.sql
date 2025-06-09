-- 1. 스탯 필터 즐겨찾기 저장 (타자 필터)
DELIMITER //
CREATE PROCEDURE insert_batter_filter(
    IN p_batter_id BIGINT,
    IN p_user_id BIGINT,
    IN p_name VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '스탯 필터 저장 실패';
    END;

    START TRANSACTION;

    INSERT INTO batterstatsfilter (batter_id, user_id, name)
    VALUES (p_batter_id, p_user_id, p_name);

    COMMIT;
END //
DELIMITER ;