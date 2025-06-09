-- 6. 스탯 필터 기반 즐겨찾기 목록 생성
DELIMITER //

CREATE PROCEDURE create_favorite_list_from_filter (
    IN userId BIGINT,
    IN filterId BIGINT,
    IN filterType ENUM('batter', 'pitcher'),
    IN favListName VARCHAR(30)
)
BEGIN
    DECLARE favListId BIGINT;
    DECLARE filter_condition TEXT;

    -- 1. 즐겨찾기 목록 생성
    INSERT INTO favoritelist(user_id, name)
    VALUES (userId, favListName);

    SET favListId = LAST_INSERT_ID();

    -- 2. 조건절 생성
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
        INTO filter_condition
        FROM batterstatsfiltercondition
        WHERE batterStatsFilter_id = filterId;

        SET @stmt_sql = CONCAT(
            'INSERT IGNORE INTO favoriteplayers(players_id, favoriteList_id) ',
            'SELECT players_id, ', favListId, ' FROM batterstats ',
            'WHERE ', filter_condition
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
        INTO filter_condition
        FROM pitcherstatsfiltercondition
        WHERE pitcherStatsFilter_id = filterId;

        SET @stmt_sql = CONCAT(
            'INSERT IGNORE INTO favoriteplayers(players_id, favoriteList_id) ',
            'SELECT players_id, ', favListId, ' FROM pitcherstats ',
            'WHERE ', filter_condition
        );
    END IF;

    -- 3. 실행
    PREPARE stmt FROM @stmt_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

END //

DELIMITER ;