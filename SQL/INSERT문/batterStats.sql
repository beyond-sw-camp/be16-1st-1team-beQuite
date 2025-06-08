-- 타자스탯 입력
LOAD DATA LOCAL INFILE 'C:/Users/young/Downloads/batterStats.csv'
INTO TABLE batterStats
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(AVG, G, PA, AB, R, H, `2B`, `3B`, HR, TB, RBI, SAC, SF, BB, IBB, HBP, SO, GDP, SLG, OBP, ops, MH, RISP);