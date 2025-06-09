-- 2. 즐겨찾기 목록 삭제 (기존 정의 유지)
DELIMITER //
CREATE PROCEDURE delete_favoritelist(IN p_list_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 삭제 실패';
    END;

    START TRANSACTION;

    DELETE FROM favoriteplayers WHERE favoriteList_id = p_list_id;
    DELETE FROM favoritelist WHERE id = p_list_id;

    COMMIT;
END //
DELIMITER ;