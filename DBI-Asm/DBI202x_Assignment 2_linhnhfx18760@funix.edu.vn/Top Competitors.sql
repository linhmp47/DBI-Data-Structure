SELECT H.hacker_id, H.name FROM hackers AS H 
    JOIN Submissions AS S ON H.hacker_id = S.hacker_id 
    JOIN Challenges AS C ON S.challenge_id = C.challenge_id 
    JOIN Difficulty AS D ON C.difficulty_level = D.difficulty_level AND S.score = D.score 
GROUP BY H.hacker_id, H.name 
HAVING COUNT(H.name ) > 1 
ORDER BY COUNT(H.name ) 
DESC, hacker_id