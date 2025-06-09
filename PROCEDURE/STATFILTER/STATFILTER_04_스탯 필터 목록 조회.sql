-- 4. 스탯 필터 목록 조회
DELIMITER //
CREATE PROCEDURE select_batter_filters_by_user(IN p_user_id BIGINT)
BEGIN
    SELECT * FROM batterstatsfilter WHERE user_id = p_user_id;
END //
DELIMITER ;