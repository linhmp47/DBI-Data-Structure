select sum(ct.population) from 
city ct, country cty
where ct.countrycode = cty.code and cty.continent = 'Asia'