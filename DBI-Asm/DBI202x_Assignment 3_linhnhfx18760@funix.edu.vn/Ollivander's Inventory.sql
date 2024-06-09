select w.id, wp.age, w.coins_needed, w.power
from wands w
join wands_property wp
on w.code = wp.code
join (
    select wp1.age, MIN(w1.coins_needed) AS min_coins_needed, w1.power
    from wands w1
    join wands_property wp1
    on w1.code = wp1.code
    where wp1.is_evil = 0
    group by wp1.age, w1.power
) mc
on w.power = mc.power AND wp.age = mc.age AND w.coins_needed = mc.min_coins_needed
where wp.is_evil = 0
order by w.power desc, wp.age desc;