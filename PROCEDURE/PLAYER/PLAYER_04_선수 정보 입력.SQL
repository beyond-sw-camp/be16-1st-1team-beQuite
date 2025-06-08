    DELIMITER //
    CREATE PROCEDURE sp_create_player(
        IN p_leagueTeam_id BIGINT,
        IN p_name          VARCHAR(30)
    )
    BEGIN
        INSERT INTO players (leagueTeam_id, name)
        VALUES (p_leagueTeam_id, p_name);
        SELECT LAST_INSERT_ID() AS new_player_id;
    END;//
    DELIMITER ;
