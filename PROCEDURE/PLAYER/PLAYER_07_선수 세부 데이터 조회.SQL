DELIMITER //
CREATE PROCEDURE sp_get_player_stats(
    IN p_player_id BIGINT
)
BEGIN
    -- 타자 스탯
    IF EXISTS (
        SELECT 1
        FROM positioned pos
        JOIN batterposition bp ON bp.positioned_id = pos.id
        JOIN batter bt        ON bt.batterPosition_id = bp.id
        WHERE pos.players_id = p_player_id
    ) THEN
        SELECT bs.*
        FROM batter bt
        JOIN batterstats bs ON bs.id = bt.batterStats_id
        WHERE bt.batterPosition_id IN (
            SELECT bp.id
            FROM positioned pos
            JOIN batterposition bp ON bp.positioned_id = pos.id
            WHERE pos.players_id = p_player_id
        );
    END IF;

    -- 투수 스탯
    IF EXISTS (
        SELECT 1
        FROM positioned pos
        JOIN pitcherposition pp ON pp.positioned_id = pos.id
        JOIN pitcher pr         ON pr.pitcherPosition_id = pp.id
        WHERE pos.players_id = p_player_id
    ) THEN
        SELECT ps.*
        FROM pitcher pr
        JOIN pitcherstats ps ON ps.id = pr.pitcherStats_id
        WHERE pr.pitcherPosition_id IN (
            SELECT pp.id
            FROM positioned pos
            JOIN pitcherposition pp ON pp.positioned_id = pos.id
            WHERE pos.players_id = p_player_id
        );
    END IF;
END;//
DELIMITER ;
