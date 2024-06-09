WITH CTE AS(
    SELECT
        Start_Date,
        End_Date,
        DATEADD(day, -ROW_NUMBER() OVER(ORDER BY Start_Date), Start_Date)[Grouping]
    FROM Projects
)
SELECT
    MIN(Start_Date)[Project_Start_Date],
    MAX(End_Date)[Project_End_Date]
FROM CTE
GROUP BY Grouping
ORDER BY DATEDIFF(day, MIN(Start_Date), MAX(End_Date)), MIN(Start_Date)