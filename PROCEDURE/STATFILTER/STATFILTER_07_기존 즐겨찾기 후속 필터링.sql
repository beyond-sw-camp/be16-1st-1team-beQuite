-- 7. 기존 즐겨찾기에 스탯 필터 적용 (후속 필터링 처리) 
-- 목적 : 기존 즐겨찾기 목록에서 조건에 맞지 않는 선수 제거
DELIMITER //

CREATE PROCEDURE apply_filter_to_existing_favorite_list (
    IN favListId BIGINT,
    IN filterId BIGINT,
    IN filterType ENUM('batter', 'pitcher')
)
BEGIN
    DECLARE @condition TEXT;
    DECLARE @sql TEXT;

    -- 예외 발생 시 롤백 처리
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '예외 발생: 필터 적용 실패';
    END;

    START TRANSACTION;

    IF filterType = 'batter' THEN
        SELECT GROUP_CONCAT(
            CONCAT_WS(' ', statColName, operator, 
                CASE valueType 
                    WHEN 'int' THEN value
                    WHEN 'float' THEN value
                    ELSE CONCAT("'", value, "'")
                END
            ) SEPARATOR ' AND '
        )
        INTO @condition
        FROM batterstatsfiltercondition
        WHERE batterStatsFilter_id = filterId;

        SET @sql = CONCAT(
            'DELETE fp FROM favoriteplayers fp
             JOIN batterstats bs ON fp.players_id = bs.players_id
             WHERE fp.favoriteList_id = ', favListId,
             ' AND NOT (', @condition, ')'
        );

    ELSEIF filterType = 'pitcher' THEN
        SELECT GROUP_CONCAT(
            CONCAT_WS(' ', statColName, operator, 
                CASE valueType 
                    WHEN 'int' THEN value
                    WHEN 'float' THEN value
                    ELSE CONCAT("'", value, "'")
                END
            ) SEPARATOR ' AND '
        )
        INTO @condition
        FROM pitcherstatsfiltercondition
        WHERE pitcherStatsFilter_id = filterId;

        SET @sql = CONCAT(
            'DELETE fp FROM favoriteplayers fp
             JOIN pitcherstats ps ON fp.players_id = ps.players_id
             WHERE fp.favoriteList_id = ', favListId,
             ' AND NOT (', @condition, ')'
        );
    END IF;

    -- 동적 SQL 실행
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    COMMIT;

END //

DELIMITER ;