select case
    when g.grade >= 8 then name else Null
    end, 
    g.grade, s.marks from Students s join grades g
    on g.Min_Mark <= s.marks and s.marks <= g.Max_Mark
    where g.grade >= 8 or g.grade is not null
    order by g.grade desc,
    case when g.grade >= 8 and name is not null then s.name end, 
    s.marks