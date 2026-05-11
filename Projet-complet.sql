-- ============================================
-- PROJET SQL COMPLET : ANALYSE E-COMMERCE WAVE
-- 09/05/2026 - Mass.exe - Niveau DE Junior validé
-- ============================================

-- TABLES DE BASE POUR LE TEST
-- clients(client_id, nom_cl, ville, age)
-- commandes(cmd_id, client_id, date_cmd, montant_achat)
-- produits(prod_id, nom_prod, category, prix)

-- ============================================
-- QUESTION 1 : CA par ville + segment client
-- Concepts : JOIN + GROUP BY + CASE WHEN + SUM
-- ============================================
SELECT 
    cl.ville,
    COUNT(DISTINCT cl.client_id) AS nb_clients,
    SUM(cmd.montant_achat) AS ca_total,
    CASE 
        WHEN SUM(cmd.montant_achat) >1000 THEN 'VIP'
        WHEN SUM(cmd.montant_achat) BETWEEN 500 AND 1000 THEN 'Gold'
        ELSE 'Standard'
    END AS segment_ville
FROM clients cl
INNER JOIN commandes cmd ON cl.client_id = cmd.client_id
GROUP BY cl.ville
ORDER BY ca_total DESC;

-- ============================================
-- QUESTION 2 : Clients actifs vs inactifs  
-- Concepts : EXISTS + NOT EXISTS + Subquery corrélée
-- ============================================
SELECT 
    cl.nom_cl,
    cl.ville,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM commandes cmd 
            WHERE cmd.client_id = cl.client_id 
            AND cmd.date_cmd >= '2024-01-01'
        ) THEN 'Actif 2024'
        ELSE 'Inactif'
    END AS statut
FROM clients cl;

-- ============================================
-- QUESTION 3 : Top 3 clients vs moyenne
-- Concepts : Subquery scalaire + HAVING + LIMIT
-- ============================================
SELECT 
    cl.nom_cl,
    SUM(cmd.montant_achat) AS total_depense
FROM clients cl
INNER JOIN commandes cmd ON cl.client_id = cmd.client_id
GROUP BY cl.client_id, cl.nom_cl
HAVING SUM(cmd.montant_achat) > (
    -- Sous-requete : moyenne des dépenses par client
    SELECT AVG(total_client) 
    FROM (
        SELECT SUM(montant_achat) AS total_client
        FROM commandes 
        GROUP BY client_id
    ) AS moyennes
)
ORDER BY total_depense DESC
LIMIT 3;

-- ============================================
-- QUESTION 4 : Panier moyen par catégorie
-- Concepts : JOIN 3 tables + AVG + ROUND
-- ============================================
SELECT 
    p.category,
    COUNT(DISTINCT cmd.cmd_id) AS nb_commandes,
    ROUND(AVG(cmd.montant_achat), 2) AS panier_moyen
FROM produits p
INNER JOIN commandes cmd ON p.prod_id = cmd.prod_id  -- Suppose qu'on a prod_id dans commandes
GROUP BY p.category
HAVING COUNT(DISTINCT cmd.cmd_id) > 5  -- Seulement categories avec volume
ORDER BY panier_moyen DESC;

-- ============================================
-- BILAN COMPETENCES PROJET :
-- JOIN, Subquery corrélée, Subquery scalaire, EXISTS, 
-- NOT EXISTS, GROUP BY, HAVING, CASE WHEN, SUM, AVG, COUNT, 
-- ROUND, ORDER BY, LIMIT
-- ============================================
