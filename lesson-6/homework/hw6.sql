1. 1) SELECT DISTINCT 
    LEAST(col1, col2) AS col1,
    GREATEST(col1, col2) AS col2
FROM InputTbl;
    2) SELECT DISTINCT
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;
2. SELECT * FROM TestMultipleZero
WHERE A + B + C + D <> 0;
3. SELECT * FROM section1
WHERE id % 2 = 1;
4. SELECT * FROM section1
WHERE id = (SELECT MIN(id) FROM section1);
5. SELECT * FROM section1
WHERE id = (SELECT MAX(id) FROM section1);
6. SELECT * FROM section1
WHERE LOWER(name) LIKE 'b%';
7. SELECT * FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';

