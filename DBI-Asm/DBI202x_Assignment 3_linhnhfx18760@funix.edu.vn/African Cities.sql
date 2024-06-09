select ct.name from 
city ct, country cty
where ct.countrycode = cty.code and cty.continent = 'Africa'