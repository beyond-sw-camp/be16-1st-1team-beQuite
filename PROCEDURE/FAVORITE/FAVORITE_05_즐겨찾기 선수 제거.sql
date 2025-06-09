-- 5. 즐겨찾기 선수 제거
DELIMITER //
CREATE PROCEDURE delete_favoriteplayer(
    IN p_players_id BIGINT,
    IN p_favoriteList_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 선수 제거 실패';
    END;

    START TRANSACTION;

    DELETE FROM favoriteplayers
    WHERE players_id = p_players_id AND favoriteList_id = p_favoriteList_id;

    COMMIT;
END //
DELIMITER ;