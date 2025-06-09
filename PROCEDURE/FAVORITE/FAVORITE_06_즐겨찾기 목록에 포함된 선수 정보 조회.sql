-- 6. 즐겨찾기 목록에 포함된 선수 정보 조회
DELIMITER //
CREATE PROCEDURE select_players_in_favoritelist(IN p_favoriteList_id BIGINT)
BEGIN
    SELECT p.*
    FROM favoriteplayers fp
    JOIN players p ON fp.players_id = p.id
    WHERE fp.favoriteList_id = p_favoriteList_id;
END //
DELIMITER ;