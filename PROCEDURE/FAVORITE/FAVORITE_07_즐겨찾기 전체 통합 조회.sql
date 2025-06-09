-- 7. 즐겨찾기 전체 통합 조회 (사용자 계정의 모든 즐겨찾기 + 선수 정보)
DELIMITER //
CREATE PROCEDURE select_all_favorites_with_players(IN p_user_id BIGINT)
BEGIN
    SELECT fl.name AS list_name, p.*
    FROM favoritelist fl
    JOIN favoriteplayers fp ON fl.id = fp.favoriteList_id
    JOIN players p ON fp.players_id = p.id
    WHERE fl.user_id = p_user_id;
END //
DELIMITER ;