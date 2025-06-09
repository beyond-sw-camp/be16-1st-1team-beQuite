-- 2. 스탯 필터 조건 저장
DELIMITER //
CREATE PROCEDURE insert_batter_filter_condition(
    IN p_filter_id BIGINT,
    IN p_colname VARCHAR(255),
    IN p_operator VARCHAR(10),
    IN p_value VARCHAR(255),
    IN p_valuetype ENUM('int','float','string')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '필터 조건 저장 실패';
    END;

    START TRANSACTION;

    INSERT INTO batterstatsfiltercondition
    (batterStatsFilter_id, statColName, operator, value, valueType)
    VALUES (p_filter_id, p_colname, p_operator, p_value, p_valuetype);

    COMMIT;
END //
DELIMITER ;