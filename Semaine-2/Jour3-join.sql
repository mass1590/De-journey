-- Jour 3 : INNER JOIN, LEFT JOIN, ANTI JOIN
-- Objectif : Relier les tables CHECKED_OUT et BOOKS

-- 1. INNER JOIN : Liste des gens qui ont emprunté un livre de Terry Crews
SELECT DISTINCT che.First_Name, che.Last_Name 
FROM CHECKED_OUT AS che
INNER JOIN BOOKS AS bo
    ON che.Book_ID = bo.Book_ID 
WHERE bo.Author = 'Terry Crews';

-- 2. LEFT JOIN : Tous les emprunts + infos du livre si dispo
SELECT che.First_Name, che.Last_Name, bo.Title, bo.Author
FROM CHECKED_OUT AS che 
LEFT JOIN BOOKS AS bo 
    ON che.Book_ID = bo.Book_ID;

-- 3. ANTI JOIN : Emprunts avec un Book_ID introuvable dans BOOKS
-- Utile pour détecter les données orphelines / problèmes d'intégrité
SELECT che.First_Name, che.Last_Name 
FROM CHECKED_OUT AS che 
LEFT JOIN BOOKS AS bo 
    ON che.Book_ID = bo.Book_ID 
WHERE bo.Book_ID IS NULL;
