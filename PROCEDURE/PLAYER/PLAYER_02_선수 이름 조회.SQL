DELIMITER //
CREATE PROCEDURE sp_search_players_by_name(
    IN p_name VARCHAR(30)
)
BEGIN
    SELECT *
    FROM players
    WHERE name LIKE CONCAT('%', p_name, '%');
END;//
DELIMITER ;
