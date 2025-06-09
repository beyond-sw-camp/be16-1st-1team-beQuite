-- batter 테이블 데이터 추가
INSERT INTO batter (batterPosition_id, batterStats_id)
SELECT bp.id, bs.id
FROM batterPosition bp
JOIN positioned d ON bp.positioned_id = d.id
JOIN batterStats bs ON d.players_id = bs.players_id;