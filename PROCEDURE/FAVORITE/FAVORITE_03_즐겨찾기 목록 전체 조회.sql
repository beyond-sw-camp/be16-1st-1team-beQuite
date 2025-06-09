-- 3. 즐겨찾기 목록 전체 조회 (사용자 기준)
DELIMITER //
CREATE PROCEDURE select_favoritelists_by_user(IN p_user_id BIGINT)
BEGIN
    SELECT * FROM favoritelist WHERE user_id = p_user_id;
END //
DELIMITER ;