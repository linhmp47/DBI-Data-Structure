select
    max(case when occupation = 'Doctor' then [Name] end),
    max(case when occupation = 'Professor' then [Name] end),
    max(case when occupation = 'Singer' then [Name] end),
    max(case when occupation = 'Actor' then [Name] end)
    from
        (SELECT ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rw, [Name], occupation
        FROM occupations) as opc
    group by rw