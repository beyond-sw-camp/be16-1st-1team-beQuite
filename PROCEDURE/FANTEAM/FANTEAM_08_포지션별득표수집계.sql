-- FANTEAM_08 포지션별 득표 수 집계 프로시저 생성

DROP PROCEDURE IF EXISTS `FANTEAM_08_포지션별득표집계`;

DELIMITER $$
CREATE PROCEDURE `FANTEAM_08_포지션별득표집계`(
    IN p_position_category VARCHAR(20),   -- 'batter' 또는 'pitcher'
    IN p_position_detail   VARCHAR(20)    -- '포수', '1루수' 등
)
BEGIN
    SELECT
      p.id               AS player_id,
      p.name             AS player_name,
      lt.name            AS team_name,
      COUNT(*)           AS pick_count
    FROM fanteammember fm
    JOIN fanteam    f   ON fm.fanteam_id   = f.id
    JOIN players    p   ON fm.players_id   = p.id
    JOIN leagueteam lt ON p.leagueTeam_id  = lt.id
    JOIN positioned pos
      ON pos.players_id = p.id
     AND pos.name       = p_position_category
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = p_position_detail
    GROUP BY p.id, p.name, lt.name
    ORDER BY pick_count DESC;
END$$
DELIMITER ;
