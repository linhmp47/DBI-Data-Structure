select convert(decimal(10,4), LONG_W) from STATION
where LAT_N = (select max(LAT_N) from Station where LAT_N < 137.2345)