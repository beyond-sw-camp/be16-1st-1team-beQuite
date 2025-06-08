-- 1. 즐겨찾기 목록 생성
DELIMITER //
CREATE PROCEDURE insert_favoritelist(
    IN p_user_id BIGINT,
    IN p_name VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 목록 생성 실패';
    END;

    START TRANSACTION;

    INSERT INTO favoritelist (user_id, name)
    VALUES (p_user_id, p_name);

    COMMIT;
END //
DELIMITER ;

-- 2. 즐겨찾기 목록 삭제 (기존 정의 유지)
DELIMITER //
CREATE PROCEDURE delete_favoritelist(IN p_list_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 삭제 실패';
    END;

    START TRANSACTION;

    DELETE FROM favoriteplayers WHERE favoriteList_id = p_list_id;
    DELETE FROM favoritelist WHERE id = p_list_id;

    COMMIT;
END //
DELIMITER ;

-- 3. 즐겨찾기 목록 전체 조회 (사용자 기준)
DELIMITER //
CREATE PROCEDURE select_favoritelists_by_user(IN p_user_id BIGINT)
BEGIN
    SELECT * FROM favoritelist WHERE user_id = p_user_id;
END //
DELIMITER ;

-- 4. 즐겨찾기 선수 추가
DELIMITER //
CREATE PROCEDURE insert_favoriteplayer(
    IN p_players_id BIGINT,
    IN p_favoriteList_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 선수 추가 실패';
    END;

    START TRANSACTION;

    INSERT IGNORE INTO favoriteplayers (players_id, favoriteList_id)
    VALUES (p_players_id, p_favoriteList_id);

    COMMIT;
END //
DELIMITER ;

-- 5. 즐겨찾기 선수 제거
DELIMITER //
CREATE PROCEDURE delete_favoriteplayer(
    IN p_players_id BIGINT,
    IN p_favoriteList_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '즐겨찾기 선수 제거 실패';
    END;

    START TRANSACTION;

    DELETE FROM favoriteplayers
    WHERE players_id = p_players_id AND favoriteList_id = p_favoriteList_id;

    COMMIT;
END //
DELIMITER ;

-- 6. 즐겨찾기 목록에 포함된 선수 정보 조회
DELIMITER //
CREATE PROCEDURE select_players_in_favoritelist(IN p_favoriteList_id BIGINT)
BEGIN
    SELECT p.*
    FROM favoriteplayers fp
    JOIN players p ON fp.players_id = p.id
    WHERE fp.favoriteList_id = p_favoriteList_id;
END //
DELIMITER ;

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

-- 8. 스탯 필터 즐겨찾기 저장 (타자 필터)
DELIMITER //
CREATE PROCEDURE insert_batter_filter(
    IN p_batter_id BIGINT,
    IN p_user_id BIGINT,
    IN p_name VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '스탯 필터 저장 실패';
    END;

    START TRANSACTION;

    INSERT INTO batterstatsfilter (batter_id, user_id, name)
    VALUES (p_batter_id, p_user_id, p_name);

    COMMIT;
END //
DELIMITER ;

-- 9. 스탯 필터 조건 저장
DELIMITER //
CREATE PROCEDURE insert_batter_filter_condition(
    IN p_filter_id BIGINT,
    IN p_colname VARCHAR(255),
    IN p_operator VARCHAR(10),
    IN p_value VARCHAR(255),
    IN p_valuetype ENUM('int','float','string')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '필터 조건 저장 실패';
    END;

    START TRANSACTION;

    INSERT INTO batterstatsfiltercondition
    (batterStatsFilter_id, statColName, operator, value, valueType)
    VALUES (p_filter_id, p_colname, p_operator, p_value, p_valuetype);

    COMMIT;
END //
DELIMITER ;

-- 10. 스탯 필터 즐겨찾기 목록 삭제
DELIMITER //
CREATE PROCEDURE delete_batterstatsfilter(IN p_filter_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '스탯 필터 삭제 실패';
    END;

    START TRANSACTION;

    DELETE FROM batterstatsfiltercondition WHERE batterStatsFilter_id = p_filter_id;
    DELETE FROM batterstatsfilter WHERE id = p_filter_id;

    COMMIT;
END //
DELIMITER ;

-- 11. 스탯 필터 목록 조회
DELIMITER //
CREATE PROCEDURE select_batter_filters_by_user(IN p_user_id BIGINT)
BEGIN
    SELECT * FROM batterstatsfilter WHERE user_id = p_user_id;
END //
DELIMITER ;

-- 12. 스탯 필터 공유
DELIMITER //
CREATE PROCEDURE copy_batter_filter(IN source_filter_id BIGINT, IN target_user_id BIGINT)
BEGIN
    DECLARE new_filter_id BIGINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '필터 복제 실패';
    END;

    START TRANSACTION;

    INSERT INTO batterstatsfilter (batter_id, user_id, name)
    SELECT batter_id, target_user_id, CONCAT(name, '_복제')
    FROM batterstatsfilter
    WHERE id = source_filter_id;

    SET new_filter_id = LAST_INSERT_ID();

    INSERT INTO batterstatsfiltercondition (batterStatsFilter_id, statColName, operator, value, valueType)
    SELECT new_filter_id, statColName, operator, value, valueType
    FROM batterstatsfiltercondition
    WHERE batterStatsFilter_id = source_filter_id;

    COMMIT;
END //
DELIMITER ;

-- 13. 스탯 필터 기반 즐겨찾기 목록 생성
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

-- 14. 기존 즐겨찾기에 스탯 필터 적용 (후속 필터링 처리) 
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
