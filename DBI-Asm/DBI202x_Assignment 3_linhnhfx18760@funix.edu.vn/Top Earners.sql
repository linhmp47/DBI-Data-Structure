select top 1 max(salary*months), count(salary*months)
from Employee
group by salary*months
order by salary*months desc