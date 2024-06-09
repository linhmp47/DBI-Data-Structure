select ct.continent, avg(c.population)
from city c
join country ct on ct.code = c.countrycode
group by ct.continent