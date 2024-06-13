select ct.continent, avg(c.population)
from city c, country ct 
where ct.code = c.countrycode
group by ct.continent