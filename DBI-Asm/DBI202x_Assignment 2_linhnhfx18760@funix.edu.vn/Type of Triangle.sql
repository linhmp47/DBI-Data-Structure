select
case
        when A + B <= C or A + C <= B or B + C <=A then 'Not A Triangle'
        when A = B and A = C then 'Equilateral'
        when A <> B and B <> C and C <> A then 'Scalene'
        else 'Isosceles'
end as triangle
from triangles