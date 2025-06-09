DROP PROCEDURE IF EXISTS 올스타후보등록;
DELIMITER //

CREATE PROCEDURE 올스타후보등록(
    IN allstar_id_Input BIGINT(20)   -- allstar_id
)
proc_block: BEGIN
    -- 1) 예외 핸들러: SQL 오류 시 롤백 후 메시지 반환
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      SELECT 'ERROR: unexpected database error' AS message;
    END;

    START TRANSACTION;

    -- 2) 이벤트 존재 여부 확인
    IF NOT EXISTS (
      SELECT 1 FROM allstar
       WHERE id = allstar_id_Input
    ) THEN
      ROLLBACK;
      SELECT 'ERROR: allstar event not found' AS message;
      LEAVE proc_block;
    END IF;

    -- 3) 기존 후보 모두 삭제
    DELETE FROM allstarcandidate
     WHERE allstar_id = allstar_id_Input;

    ------------------------------------------------------------
    -- 4) 포지션별 최다 투표자 1명씩 등록
    ------------------------------------------------------------

    -- 4-1) 포수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT 
      allstar_id_Input,
      p.id,
      '포수',
      1
    FROM fanteammember fm
    JOIN players p
      ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id
     AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '포수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-2) 1루수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT 
      allstar_id_Input, p.id, '1루수', 1
    FROM fanteammember fm
    JOIN players p
      ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id
     AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '1루수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-3) 2루수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '2루수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '2루수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-4) 3루수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '3루수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '3루수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-5) 유격수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '유격수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '유격수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-6) 좌익수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '좌익수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '좌익수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-7) 중견수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '중견수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '중견수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-8) 우익수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '우익수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'batter'
    JOIN batterposition bp
      ON bp.positioned_id = pos.id
     AND TRIM(TRAILING '\r' FROM bp.batterPosition) = '우익수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-9) 선발투수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '선발투수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'pitcher'
    JOIN pitcherposition pp
      ON pp.positioned_id  = pos.id
     AND TRIM(TRAILING '\r' FROM pp.pitcherposition) = '선발투수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 4-10) 불펜투수
    INSERT INTO allstarcandidate(allstar_id, player_id, candidate_position, is_active)
    SELECT allstar_id_Input, p.id, '불펜투수', 1
    FROM fanteammember fm
    JOIN players p ON fm.players_id = p.id
    JOIN positioned pos
      ON pos.players_id = p.id AND pos.name = 'pitcher'
    JOIN pitcherposition pp
      ON pp.positioned_id  = pos.id
     AND TRIM(TRAILING '\r' FROM pp.pitcherposition) = '불펜투수'
    GROUP BY p.id
    ORDER BY COUNT(DISTINCT fm.fanteam_id) DESC
    LIMIT 1;

    -- 5) 커밋 및 성공 메시지
    COMMIT;
    SELECT 'SUCCESS: allstar candidates registered' AS message;
END proc_block;
//
DELIMITER ;
