-- ============================================
-- Parcours Data Engineer - Jour 1
-- Thème: SELECT, WHERE, ORDER BY, LIMIT, COUNT
-- Table: SALARIES
-- Date: 2026-05-07
-- ============================================

-- Mission 1 : Lister tous les noms de professeurs
SELECT Professor_Name 
FROM SALARIES;
-- Note: Retourne les doublons. Utiliser DISTINCT pour dédoublonner.

-- Mission 2 : Compter les profs qui gagnent > 150k
SELECT COUNT(Professor_Name) 
FROM SALARIES 
WHERE Salary > 150000;
-- Note: COUNT(colonne) ignore les NULL. COUNT(*) compte tout.

-- Mission 3 : TOP 5 des salaires les plus élevés
SELECT Professor_Name, Salary 
FROM SALARIES 
ORDER BY Salary DESC 
LIMIT 5;
-- Note: ORDER BY s'exécute avant LIMIT. Toujours trier avant de limiter.
