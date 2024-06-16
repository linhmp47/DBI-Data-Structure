with cte as(
    select
            Start_Date,
            End_Date,
            dateadd(day, -row_number() over (order by Start_Date), Start_Date)[Grouping]
    from Projects
)

select
        min(Start_Date)[Project_Start_Date], 
        max(End_Date)[Project_End_Date]
from cte
group by grouping
order by datediff(day, min(Start_Date), max(End_Date)), min(Start_Date)