SELECT x,y FROM functions f1
    WHERE EXISTS(SELECT * FROM functions f2 WHERE f2.y = f1.x
    and f2.x = f1.y and f2.x > f1.x) and (x != y)
UNION
SELECT x,y FROM functions f1 where x = y AND
    ((SELECT COUNT(*) FROM functions WHERE x = f1.x AND y = f1.x) > 1)
    order by x;