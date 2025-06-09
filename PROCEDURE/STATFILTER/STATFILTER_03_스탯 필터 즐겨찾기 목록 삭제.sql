-- 3. 스탯 필터 즐겨찾기 목록 삭제
DELIMITER //
CREATE PROCEDURE delete_batterstatsfilter(IN p_filter_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '스탯 필터 삭제 실패';
    END;

    START TRANSACTION;

    DELETE FROM batterstatsfiltercondition WHERE batterStatsFilter_id = p_filter_id;
    DELETE FROM batterstatsfilter WHERE id = p_filter_id;

    COMMIT;
END //
DELIMITER ;