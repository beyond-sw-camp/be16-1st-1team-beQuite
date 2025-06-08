DELIMITER //
CREATE PROCEDURE sp_get_player_by_id(
    IN p_player_id BIGINT
)
BEGIN
    SELECT *
    FROM players
    WHERE id = p_player_id;
END;//
DELIMITER ;
