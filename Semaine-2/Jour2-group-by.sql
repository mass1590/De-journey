-- Mission 1 : Nombre de profs par département
SELECT Department, COUNT(*) AS Nb_profs FROM SALARIES GROUP BY Department;

-- Mission 2 : Départements avec + de 5 profs  
SELECT Department, COUNT(*) AS Nb_profs FROM SALARIES GROUP BY Department HAVING COUNT(*) > 5;

-- Mission 3 : Départements avec masse salariale > 1M
SELECT 
    Department, 
    COUNT(*) AS Nb_profs,
    SUM(Salary) AS Masse_salariale,
    ROUND(AVG(Salary), 0) AS Salaire_moyen
FROM SALARIES
GROUP BY Department
HAVING SUM(Salary) > 1000000
ORDER BY Masse_salariale DESC;
