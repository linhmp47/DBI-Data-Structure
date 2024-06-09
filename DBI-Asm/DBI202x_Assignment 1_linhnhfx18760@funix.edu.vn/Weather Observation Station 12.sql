select distinct city
from station
where lower(city) not like '[aeiou]%' and lower(city) not like '%[aeiou]'