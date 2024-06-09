SELECT
    a.name 
FROM students a
    INNER JOIN friends b ON a.id = b.id
    INNER JOIN students c ON b.friend_id = c.id
    INNER JOIN packages d ON a.id = d.id
    INNER JOIN packages e ON b.friend_id = e.id
WHERE e.salary > d.salary
ORDER BY e.salary;