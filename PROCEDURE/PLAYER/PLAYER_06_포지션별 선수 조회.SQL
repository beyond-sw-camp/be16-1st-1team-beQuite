USE producekbo;
DROP PROCEDURE IF EXISTS sp_get_players_by_position;
DELIMITER //

CREATE PROCEDURE sp_get_players_by_position(
    IN p_category ENUM('batter', 'pitcher'),
    IN p_position VARCHAR(50)
)
BEGIN
    DECLARE available_positions VARCHAR(255);
    DECLARE error_msg VARCHAR(255);

    -- 입력 값 정규화
    SET p_category = LOWER(TRIM(p_category));
    SET p_position = TRIM(TRAILING '\r' FROM TRIM(p_position));

    IF p_category = 'batter' THEN
        -- 디버깅: 사용 가능한 포지션 가져오기
        SET available_positions = (
            SELECT GROUP_CONCAT(DISTINCT batterPosition)
            FROM batterposition
        );

        -- 매칭되는 데이터 확인
        IF (SELECT COUNT(*) FROM batterposition bp
            JOIN positioned pos ON pos.id = bp.positioned_id
            WHERE bp.batterPosition = p_position
            AND pos.name = 'batter') = 0 THEN
            SET error_msg = CONCAT('No matching batter positions found for p_position: ', p_position);
            SET error_msg = CONCAT(error_msg, '. Available positions: ', COALESCE(available_positions, 'None'));
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = error_msg;
        END IF;

        SELECT
            pl.id,
            pl.name,
            bp.batterPosition AS position
        FROM players pl
        JOIN positioned pos ON pos.players_id = pl.id
            AND pos.name = 'batter'
        JOIN batterposition bp ON bp.positioned_id = pos.id
        WHERE bp.batterPosition = p_position;

    ELSEIF p_category = 'pitcher' THEN
        -- 디버깅: 사용 가능한 포지션 가져오기
        SET available_positions = (
            SELECT GROUP_CONCAT(DISTINCT pitcherPosition)
            FROM pitcherposition
        );

        -- 매칭되는 데이터 확인
        IF (SELECT COUNT(*) FROM pitcherposition pp
            JOIN positioned pos ON pos.id = pp.positioned_id
            WHERE pp.pitcherPosition = p_position
            AND pos.name = 'pitcher') = 0 THEN
            SET error_msg = CONCAT('No matching pitcher positions found for p_position: ', p_position);
            SET error_msg = CONCAT(error_msg, '. Available positions: ', COALESCE(available_positions, 'None'));
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = error_msg;
        END IF;

        SELECT
            pl.id,
            pl.name,
            pp.pitcherPosition AS position
        FROM players pl
        JOIN positioned pos ON pos.players_id = pl.id
            AND pos.name = 'pitcher'
        JOIN pitcherposition pp ON pp.positioned_id = pos.id
        WHERE pp.pitcherPosition = p_position;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'p_category는 batter 또는 pitcher만 가능합니다';
    END IF;
END//

DELIMITER ;