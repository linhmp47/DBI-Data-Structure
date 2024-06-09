select c.*
    ,count(distinct lm.lead_manager_code) as tot_lead_managers
    ,count(distinct sm.senior_manager_code) as tot_senior_managers
    ,count(distinct m.manager_code) as tot_managers
    ,count(distinct e.employee_code) as tot_employees
from company as c
left join lead_manager as lm
    on c.company_code = lm.company_code
left join senior_manager as sm
    on lm.company_code = sm.company_code
    and lm.lead_manager_code = sm.lead_manager_code
left join manager as m
    on sm.company_code = m.company_code
    and sm.lead_manager_code = m.lead_manager_code
    and sm.senior_manager_code = m.senior_manager_code
left join employee as e
    on e.company_code = m.company_code
    and e.lead_manager_code = m.lead_manager_code
    and e.senior_manager_code = m.senior_manager_code
    and e.manager_code = m.manager_code
group by c.company_code, c.founder
order by c.company_code;
