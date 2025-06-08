DELIMITER //
CREATE PROCEDURE sp_get_players_by_team(
    IN p_team_name VARCHAR(30)
)
BEGIN
    SELECT pl.*
    FROM players pl
    JOIN leagueteam lt ON lt.id = pl.leagueTeam_id
    WHERE lt.name = p_team_name;
END;//
DELIMITER ;
