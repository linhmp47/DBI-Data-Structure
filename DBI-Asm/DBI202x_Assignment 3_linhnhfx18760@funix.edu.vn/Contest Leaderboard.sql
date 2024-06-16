with total_score_by_scores as (
select
        hacker_id,
        sum(max_score) as total_score
from

(select
        hacker_id, 
        challenge_id, 
        max(score) as max_score
from submissions
group by hacker_id, challenge_id) as max_scores

group by hacker_id
)

select 
        h.hacker_id,
        h.name,
        t.total_score
from hackers h join 
        total_score_by_scores t 
on h.hacker_id = t.hacker_id 
where t.total_score > 0
order by total_score desc, hacker_id;
