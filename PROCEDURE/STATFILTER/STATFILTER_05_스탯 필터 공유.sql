-- 5. 스탯 필터 공유
DELIMITER //
CREATE PROCEDURE copy_batter_filter(IN source_filter_id BIGINT, IN target_user_id BIGINT)
BEGIN
    DECLARE new_filter_id BIGINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '필터 복제 실패';
    END;

    START TRANSACTION;

    INSERT INTO batterstatsfilter (batter_id, user_id, name)
    SELECT batter_id, target_user_id, CONCAT(name, '_복제')
    FROM batterstatsfilter
    WHERE id = source_filter_id;

    SET new_filter_id = LAST_INSERT_ID();

    INSERT INTO batterstatsfiltercondition (batterStatsFilter_id, statColName, operator, value, valueType)
    SELECT new_filter_id, statColName, operator, value, valueType
    FROM batterstatsfiltercondition
    WHERE batterStatsFilter_id = source_filter_id;

    COMMIT;
END //
DELIMITER ;