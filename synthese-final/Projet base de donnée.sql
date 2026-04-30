
CREATE DATABASE SuiviCompetencesEquipe;
USE SuiviCompetencesEquipe;


-- Supprimer les tables existantes, si elles existent
--DROP TABLE IF EXISTS Employes, CategoriesCompetences, Competences, Evaluations, HistoriqueCompetences, Formations, Objectifs;

-- Table des employés
CREATE TABLE Employes (
    ID_employe INT IDENTITY(1,1) PRIMARY KEY,
    Nom VARCHAR(30) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Poste VARCHAR(50),
    DateEmbauche DATE,
    Experience INT,
    Specialite VARCHAR(50),
    Contact VARCHAR(80)
);

-- Insertion des employés
INSERT INTO Employes (Nom, Prenom, Poste, DateEmbauche, Experience, Specialite, Contact) VALUES
('Yanna', 'Orneila', 'Chef cuisiniere', '2022-05-06', 8, 'Cuisine gastronomique', 'Orneila.yanna@example.com'),
('Guigma', 'Roxy', 'Chef Pâtissiere', '2022-01-10', 9, 'Pâtisserie fine', 'Roxy.guigma@example.com'),
('Leroy', 'Yanis', 'Commis', '2023-01-01', 4, 'Cuisine traditionnelle', 'Yanis.leroy@example.com'),
('Martins', 'Brandon', 'Plongeur', '2022-05-15', 3, 'Hygiene/Entretien', 'Brandon.Martins@example.com'),
('Banaken', 'Jordan', 'Manager', '2020-08-08', 7, 'Ressources humaines', 'Jordan.banaken@example.com'),
('Blanc', 'Lucie', 'Commis pâtissiere', '2024-10-01', 2, 'Pâtisserie', 'lucie.blanc@example.com');

-- Table des catégories de compétences
CREATE TABLE CategoriesCompetences (
    Nom VARCHAR(50) PRIMARY KEY,
    Description TEXT
);


-- Table des compétences
CREATE TABLE Competences (
    Nom VARCHAR(50) PRIMARY KEY,
    Categorie VARCHAR(50),
    Description TEXT,
    FOREIGN KEY (Categorie) REFERENCES CategoriesCompetences(Nom)
);

-- Insertion des compétences
INSERT INTO Competences (Nom, Categorie, Description) VALUES
('Cuisson des viandes', 'Cuisine', 'Maîtriser les différentes techniques de cuisson des viandes'),
('Pâtisserie fine', 'Pâtisserie', 'Réaliser des desserts raffinés'),
('Assistance en cuisine', 'Cuisine', 'Aider à la préparation des plats et au bon déroulement du service'),
('Polyvalence', 'Comportementale', 'Être capable de s’adapter à différents rôles au sein de l’équipe'),
('Leadership/Communication', 'Comportementale', 'Manager et communiquer efficacement avec l’équipe');

-- Insérer des compétences dans la table Competences
INSERT INTO Competences (Nom) VALUES
('Cuisson des viandes'),
('Pâtisserie fine'),
('Dressage des plats'),
('Assistance en cuisine'),
('Efficace/Dynamique'),
('Leadership/Communication'),
('Polyvalence');

DELETE FROM Competences 
WHERE Nom IN ('Cuisson des viandes', 'Pâtisserie fine', 'Dressage des plats', 
              'Assistance en cuisine', 'Efficace/Dynamique', 
              'Leadership/Communication', 'Polyvalence');


-- Table des évaluations
CREATE TABLE Evaluations (
    ID_evaluation INT IDENTITY(1,1) PRIMARY KEY,
    ID_employe INT,
    Competence VARCHAR(50) NOT NULL,
    Niveau VARCHAR(20) NOT NULL,
    DateEvaluation DATE,
    Commentaires TEXT,
    FOREIGN KEY (ID_employe) REFERENCES Employes(ID_employe),
    FOREIGN KEY (Competence) REFERENCES Competences(Nom),
    CHECK (Niveau IN ('Débutant', 'Intermédiaire', 'Avancé', 'Expert'))
);

SELECT 
    E.Nom, 
    E.Prenom, 
    Ev.Competence, 
    Ev.Niveau, 
    Ev.DateEvaluation, 
    Ev.Commentaires
FROM Evaluations Ev
JOIN Employes E ON Ev.ID_employe = E.ID_employe;


INSERT INTO Evaluations (ID_employe, Competence, Niveau, DateEvaluation, Commentaires) VALUES
(1, 'Cuisson des viandes', 'Avancé', '2022-05-06', 'Très précis et rapide dans la découpe'),
(2, 'Pâtisserie fine', 'Expert', '2022-01-10', 'Excellente maîtrise des desserts élaborés'),
(2, 'Dressage des plats', 'Avancé', '2022-01-10', 'Bonne présentation des plats, mais peut encore améliorer la créativité'),
(3, 'Assistance en cuisine', 'Avancé', '2023-01-01', 'Polyvalent, aide dans diverses tâches de cuisine avec efficacité'),
(4, 'Efficace/Dynamique', 'Avancé', '2022-05-15', 'Maîtrise parfaite des techniques de pâtisserie fine'),
(5, 'Leadership/Communication', 'Expert', '2020-01-01', 'Bonne connaissance des bases de la cuisine moderne, mais nécessite plus de pratique'),
(6, 'Polyvalence', 'Intermédiaire', '2024-10-01', 'Doit améliorer ses compétences en présentation des plats');

UPDATE Evaluations
SET Commentaires = 'Excellente gestion de l’équipe et communication efficace'
WHERE ID_employe = 5 AND Competence = 'Leadership/Communication';


-- Table de l'historique des compétences
CREATE TABLE HistoriqueCompetences (
    ID_historique INT IDENTITY(1,1) PRIMARY KEY,
    ID_employe INT,
    Competence VARCHAR(50),
    NiveauAvant VARCHAR(20),
    NiveauApres VARCHAR(20),
    DateModification DATE,
    Commentaires TEXT,
    FOREIGN KEY (ID_employe) REFERENCES Employes(ID_employe),
    FOREIGN KEY (Competence) REFERENCES Competences(Nom),
    CHECK (NiveauAvant IN ('Débutant', 'Intermédiaire', 'Avancé', 'Expert')),
    CHECK (NiveauApres IN ('Débutant', 'Intermédiaire', 'Avancé', 'Expert'))
);

-- Insertion des historiques pour tous les employés
INSERT INTO HistoriqueCompetences (ID_employe, Competence, NiveauAvant, NiveauApres, DateModification, Commentaires) VALUES
(1, 'Cuisson des viandes', 'Intermédiaire', 'Avancé', '2024-12-01', 'Amélioration notable dans la gestion des températures et la découpe des viandes'),
(2, 'Pâtisserie fine', 'Avancé', 'Expert', '2024-12-01', 'Excellente maîtrise des techniques avancées de pâtisserie et de présentation des desserts'),
(2, 'Dressage des plats', 'Intermédiaire', 'Avancé', '2024-12-01', 'Amélioration dans le design des plats, mais reste à peaufiner la créativité'),
(3, 'Assistance en cuisine', 'Débutant', 'Avancé', '2024-12-01', 'Passage rapide au niveau avancé grâce à la formation et la pratique sur le terrain'),
(4, 'Efficace/Dynamique', 'Intermédiaire', 'Avancé', '2024-12-01', 'Grand progrès en efficacité et dynamisme dans le travail en cuisine, gestion des tâches améliorée'),
(5, 'Leadership/Communication', 'Intermédiaire', 'Expert', '2024-12-01', 'Maîtrise des techniques de communication en équipe et gestion du personnel efficace'),
(6, 'Polyvalence', 'Débutant', 'Intermédiaire', '2024-12-01', 'A fait des progrès significatifs dans l’assistance et la gestion des tâches en patisserie');



-- Table des formations
CREATE TABLE Formations (
    ID_formation INT IDENTITY(1,1) PRIMARY KEY,
    Nom VARCHAR(50),
    Description TEXT,
    DateDebut DATE,
    DateFin DATE
);

-- Insertion des formations pour Lucie, Brandon et Yanis ( c'est eux les commis)
INSERT INTO Formations (Nom, Description, DateDebut, DateFin) VALUES
('Formation pâtisserie', 'Formation avancée sur la pâtisserie fine et les techniques modernes de décoration', '2024-11-01', '2025-03-01'), -- Pour Lucie
('Formation pâtisserie', 'Formation avancée sur la pâtisserie fine et les techniques modernes de décoration', '2022-02-01', '2022-05-01'), -- Pour Brandon
('Gestion des viandes', 'Formation sur les différentes techniques de cuisson des viandes', '2023-05-01', '2023-08-01'); -- Pour Yanis


-- Table des objectifs
CREATE TABLE Objectifs (
    ID_objectif INT IDENTITY(1,1) PRIMARY KEY,
    ID_employe INT,
    Objectif VARCHAR(100),
    DateLimite DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ID_employe) REFERENCES Employes(ID_employe),
    CHECK (Status IN ('Non commencé', 'En cours', 'Atteint'))
);

-- Insertion des objectifs pour tous les employés
INSERT INTO Objectifs (ID_employe, Objectif, DateLimite, Status) VALUES
(1, 'Obtenir le niveau Expert en cuisson des viandes', '2025-01-31', 'Atteint'),
(2, 'Améliorer le dressage créatif des plats', '2025-01-30', 'Atteint'),
(3, 'Améliorer la gestion du temps en cuisine', '2025-01-31', 'En cours'),
(4, 'Optimiser les techniques d’entretien de la cuisine', '2025-01-15', 'Non commencé'),
(5, 'Améliorer la gestion de l’équipe et la communication', '2025-01-31', 'En cours'),
(6, 'Atteindre le niveau avancé en pâtisserie', '2025-01-30', 'En cours');

-- Objectifs atteints par certains employés
UPDATE Objectifs
SET Status = 'Atteint'
WHERE ID_employe = 1 AND Objectif = 'Obtenir le niveau Expert en cuisson des viandes';

UPDATE Objectifs
SET Status = 'Atteint'
WHERE ID_employe = 2 AND Objectif = 'Améliorer le dressage créatif des plats';

UPDATE Objectifs
SET Status = 'Atteint'
WHERE ID_employe = 5 AND Objectif = 'Améliorer la gestion de l’équipe et la communication';



	 
	 --Rapport d'analyse 1
	 SELECT 
    E.Nom, 
    E.Prenom,
    COUNT(O.ID_objectif) AS TotalObjectifs,
    SUM(CASE WHEN O.Status = 'Atteint' THEN 1 ELSE 0 END) AS ObjectifsAtteints,
    (SUM(CASE WHEN O.Status = 'Atteint' THEN 1 ELSE 0 END) * 100.0 / COUNT(O.ID_objectif)) AS PourcentageObjectifsAtteints
FROM 
    Employes E
JOIN 
    Objectifs O ON E.ID_employe = O.ID_employe
GROUP BY 
    E.ID_employe, E.Nom, E.Prenom
HAVING 
    COUNT(O.ID_objectif) > 0  -- Filtre uniquement les employés avec des objectifs
ORDER BY 
    PourcentageObjectifsAtteints DESC;


	--Rapport d'analyse 2
	SELECT 
    Competence, 
    COUNT(CASE WHEN Niveau IN ('Avancé', 'Expert') THEN 1 END) AS NombreAvances,
    COUNT(*) AS TotalEvaluations,
    (COUNT(CASE WHEN Niveau IN ('Avancé', 'Expert') THEN 1 END) * 100.0 / COUNT(*)) AS PourcentageAvances
FROM 
    Evaluations
GROUP BY 
    Competence
ORDER BY 
    PourcentageAvances DESC;

	
	SELECT * FROM Employes;
SELECT * FROM Competences;
SELECT * FROM Evaluations;
SELECT * FROM HistoriqueCompetences;
SELECT * FROM Formations;
SELECT * FROM Objectifs;




	
