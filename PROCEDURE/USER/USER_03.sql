-- USER_03 회원정보조회

-- 기존에 같은 프로시저가 있으면 삭제
DROP PROCEDURE IF EXISTS 회원정보조회;
DELIMITER //

CREATE PROCEDURE 회원정보조회(
  IN user_id_Input BIGINT(20)
)
BEGIN
  -- 예외 핸들러: SQL 오류 시 메시지 한 줄 리턴
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    SELECT 'ERROR: unexpected database error' AS message;
  END;

  -- 존재 여부 체크 & SELECT
  IF NOT EXISTS (SELECT 1 FROM `user` WHERE `id`=user_id_Input) THEN
    SELECT 'ERROR: user not found' AS message;
  ELSE
    SELECT
      leagueTeam_id    AS leagueTeam_id,
      email            AS email,
      'password'       AS password,
      'name'           AS name,
      phone            AS phone,
      age              AS age,
      role             AS role
    FROM `user`
    WHERE `id` = user_id_Input;
  END IF;

END;
//
DELIMITER ;