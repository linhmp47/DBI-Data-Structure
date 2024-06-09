with cte1 as (
    select 
        hacker_id,
        count(challenge_id) as challengecount
    from challenges
    group by hacker_id),
    
cte2 as (
select
    hacker_id,
    count(challengecount) over
        (partition by challengecount) as countcount
from cte1
)

select
    a.hacker_id,
    a.name,
    b.challengecount
from hackers a
inner join cte1 b
    on a.hacker_id = b.hacker_id
inner join cte2 c
    on a.hacker_id = c.hacker_id
where b.challengecount = (select max(challengecount) from cte1)
    or c.countcount = 1
order by b.challengecount desc, hacker_id;
