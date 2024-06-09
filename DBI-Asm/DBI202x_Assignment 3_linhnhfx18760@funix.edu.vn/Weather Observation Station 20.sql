select convert(decimal(10,4), LAT_N)
from
(select LAT_N, ROW_NUMBER() over (order by LAT_N) as ROWNU from STATION) as X
where ROWNU = (SELECT round((count(LAT_N)+1)/2,0) from STATION)