-- 4. 즐겨찾기 선수 추가
DELIMITER //
CREATE PROCEDURE insert_favoriteplayer(
    IN p_players_id BIGINT,
    IN p_favoriteList_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 선수 추가 실패';
    END;

    START TRANSACTION;

    INSERT IGNORE INTO favoriteplayers (players_id, favoriteList_id)
    VALUES (p_players_id, p_favoriteList_id);

    COMMIT;
END //
DELIMITER ;