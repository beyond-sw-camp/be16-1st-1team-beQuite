-- pitcher 테이블 데이터 추가
INSERT INTO pitcher (pitcherPosition_id, pitcherStats_id)
SELECT pp.id, ps.id
FROM pitcherPosition pp
JOIN positioned d ON pp.positioned_id = d.id
JOIN pitcherStats ps ON d.players_id = ps.players_id;