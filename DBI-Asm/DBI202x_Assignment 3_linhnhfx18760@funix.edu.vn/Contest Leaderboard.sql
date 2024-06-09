select hackers.hacker_id, hackers.name, total_score_by_hacker.total_score
from
    (select hacker_id, sum(max_score) as total_score
    from
        (select hacker_id, challenge_id, MAX(score) as max_score
        from Submissions
        group by hacker_id, challenge_id) as max_scores
    group by hacker_id) as total_score_by_hacker
join hackers on total_score_by_hacker.hacker_id = hackers.hacker_id
where total_score_by_hacker.total_score > 0
order by total_score_by_hacker.total_score desc, hackers.hacker_id asc;