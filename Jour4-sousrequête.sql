-- ============================================
-- SEMAINE 1 RUSH COMPLET - MATINEE 09/05/2026
-- ============================================

-- JOUR 3 : INNER JOIN moderne
-- But : Rapport commandes + infos clients du 05/01/2024
SELECT 
    cm.cmd_id,
    cm.date_cmd,
    cm.montant_achat,
    cl.nom_cl,
    cl.ville
FROM commandes cm
INNER JOIN clients cl ON cl.client_id = cm.client_id
WHERE cm.date_cmd = '2024-01-05';

-- JOUR 4 : IN + SOUS-REQUETE LISTE  
-- But : Clients ayant commandé le 05/01/2024
SELECT 
    c.client_id,
    c.nom_cl,
    c.ville
FROM clients c
WHERE c.client_id IN (
    SELECT cmd.client_id 
    FROM commandes cmd
    WHERE cmd.date_cmd = '2024-01-05'
);

-- JOUR 5 : SOUS-REQUETE SCALAIRE + OPERATEUR
-- But : Clients plus âgés que la moyenne des Parisiens
SELECT nom_cl, age
FROM clients
WHERE age > (
    SELECT AVG(age) 
    FROM clients 
    WHERE ville = 'paris'
);

-- JOUR 6 : MEME TABLE + HAVING + COUNT
-- But : Clients ayant passé plus d'une commande
SELECT DISTINCT c1.nom_cl
FROM clients c1
WHERE c1.client_id IN (
    SELECT c2.client_id
    FROM commandes c2
    GROUP BY c2.client_id
    HAVING COUNT(c2.cmd_id) > 1
);

-- JOUR 7 : GROUP BY + COUNT + ORDER BY + SOUS-REQUETE
-- But : Repartition par age des seniors vs moyenne Paris
SELECT 
    age, 
    COUNT(nom_cl) AS nombreclients 
FROM clients 
WHERE age > (
    SELECT AVG(age) 
    FROM clients 
    WHERE ville = 'paris'
)
GROUP BY age
ORDER BY age DESC;

-- JOUR 8 BONUS : CASE WHEN
-- But : Segmenter Approved/Failed selon score
SELECT 
    name, 
    score,
    CASE 
        WHEN score >= 7 THEN 'Approved' 
        ELSE 'Failed' 
    END AS status 
FROM students;

-- JOUR 8 BONUS V2 : CASE WHEN 3 niveaux
-- But : Mention Excellent/Approved/Failed
SELECT 
    name,
    score,
    CASE 
        WHEN score >= 9 THEN 'Excellent'
        WHEN score >= 7 THEN 'Approved'
        ELSE 'Failed' 
    END AS mention
FROM students;

-- ============================================
-- BILAN COMPETENCES DEBLOQUEES EN 4H :
-- JOIN, IN, Sous-requete scalaire, Sous-requete liste,
-- GROUP BY, HAVING, COUNT, AVG, ORDER BY, CASE WHEN
-- Niveau : Pret pour 90% des tests techniques Wave
-- ============================================
