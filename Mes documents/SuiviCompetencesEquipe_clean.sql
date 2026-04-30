-- Désactivation des contraintes de clés étrangères
SET FOREIGN_KEY_CHECKS = 0;

-- Suppression des tables existantes
DROP TABLE IF EXISTS Evaluations, HistoriqueCompetences, Objectifs, Formations, Competences, CategoriesCompetences, Employes;

-- Réactivation des contraintes de clés étrangères
SET FOREIGN_KEY_CHECKS = 1;

-- Table des employés
CREATE TABLE Employes (
    ID_employe INT AUTO_INCREMENT PRIMARY KEY,
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

-- Insertion des catégories
INSERT INTO CategoriesCompetences (Nom, Description) VALUES
('Cuisine', 'Compétences liées à la préparation des plats, cuisson, dressage, etc.'),
('Pâtisserie', 'Compétences spécifiques à la pâtisserie, desserts, décoration, etc.'),
('Comportementale', 'Compétences transversales liées au comportement et à la communication');

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
('Leadership/Communication', 'Comportementale', 'Manager et communiquer efficacement avec l’équipe'),
('Dressage des plats', 'Cuisine', 'Savoir disposer les éléments dans l’assiette de manière esthétique'),
('Efficace/Dynamique', 'Comportementale', 'Travailler rapidement, efficacement et avec enthousiasme');

-- Table des évaluations (corrigée)
CREATE TABLE Evaluations (
    ID_evaluation INT AUTO_INCREMENT PRIMARY KEY,
    ID_employe INT,
    Competence VARCHAR(50) NOT NULL,
    Niveau VARCHAR(20) NOT NULL CHECK (Niveau IN ('Débutant', 'Intermédiaire', 'Avancé', 'Expert')),
    DateEvaluation DATE,
    Commentaires TEXT,
    FOREIGN KEY (ID_employe) REFERENCES Employes(ID_employe),
    FOREIGN KEY (Competence) REFERENCES Competences(Nom)
);

-- Insertion des évaluations (fonctionnelles)
INSERT INTO Evaluations (ID_employe, Competence, Niveau, DateEvaluation, Commentaires) VALUES
(1, 'Cuisson des viandes', 'Avancé', '2022-05-06', 'Très précis et rapide dans la découpe'),
(2, 'Pâtisserie fine', 'Expert', '2022-01-10', 'Excellente maîtrise des desserts élaborés'),
(2, 'Dressage des plats', 'Avancé', '2022-01-10', 'Bonne présentation des plats, mais peut encore améliorer la créativité'),
(3, 'Assistance en cuisine', 'Avancé', '2023-01-01', 'Polyvalent, aide dans diverses tâches de cuisine avec efficacité'),
(4, 'Efficace/Dynamique', 'Avancé', '2022-05-15', 'Maîtrise parfaite des techniques de pâtisserie fine'),
(5, 'Leadership/Communication', 'Expert', '2020-01-01', 'Bonne connaissance des bases de la cuisine moderne, mais nécessite plus de pratique'),
(6, 'Polyvalence', 'Intermédiaire', '2024-10-01', 'Doit améliorer ses compétences en présentation des plats');

-- Table de l'historique des compétences
CREATE TABLE HistoriqueCompetences (
    ID_historique INT AUTO_INCREMENT PRIMARY KEY,
    ID_employe INT,
    Competence VARCHAR(50),
    NiveauAvant VARCHAR(20),
    NiveauApres VARCHAR(20),
    DateModification DATE,
    Commentaires TEXT,
    FOREIGN KEY (ID_employe) REFERENCES Employes(ID_employe),
    FOREIGN KEY (Competence) REFERENCES Competences(Nom)
);

-- Insertion de l'historique
INSERT INTO HistoriqueCompetences (ID_employe, Competence, NiveauAvant, NiveauApres, DateModification, Commentaires) VALUES
(1, 'Cuisson des viandes', 'Intermédiaire', 'Avancé', '2024-12-01', 'Amélioration notable dans la gestion des températures et la découpe des viandes'),
(2, 'Pâtisserie fine', 'Avancé', 'Expert', '2024-12-01', 'Excellente maîtrise des techniques avancées de pâtisserie et de présentation des desserts'),
(2, 'Dressage des plats', 'Intermédiaire', 'Avancé', '2024-12-01', 'Amélioration dans le design des plats, mais reste à peaufiner la créativité'),
(3, 'Assistance en cuisine', 'Débutant', 'Avancé', '2024-12-01', 'Passage rapide au niveau avancé grâce à la formation et la pratique sur le terrain'),
(4, 'Efficace/Dynamique', 'Intermédiaire', 'Avancé', '2024-12-01', 'Grand progrès en efficacité et dynamisme dans le travail en cuisine, gestion des tâches améliorée'),
(5, 'Leadership/Communication', 'Intermédiaire', 'Expert', '2024-12-01', 'Maîtrise des techniques de communication en équipe et gestion du personnel efficace'),
(6, 'Polyvalence', 'Débutant', 'Intermédiaire', '2024-12-01', 'A fait des progrès significatifs dans l’assistance et la gestion des tâches en pâtisserie');

-- Table des formations
CREATE TABLE Formations (
    ID_formation INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50),
    Description TEXT,
    DateDebut DATE,
    DateFin DATE
);

-- Insertion des formations
INSERT INTO Formations (Nom, Description, DateDebut, DateFin) VALUES
('Formation pâtisserie', 'Formation avancée sur la pâtisserie fine et les techniques modernes de décoration', '2024-11-01', '2025-03-01'),
('Formation pâtisserie', 'Formation avancée sur la pâtisserie fine et les techniques modernes de décoration', '2022-02-01', '2022-05-01'),
('Gestion des viandes', 'Formation sur les différentes techniques de cuisson des viandes', '2023-05-01', '2023-08-01');

-- Table des objectifs
CREATE TABLE Objectifs (
    ID_objectif INT AUTO_INCREMENT PRIMARY KEY,
    ID_employe INT,
    Objectif VARCHAR(100),
    DateLimite DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ID_employe) REFERENCES Employes(ID_employe)
);

-- Insertion des objectifs
INSERT INTO Objectifs (ID_employe, Objectif, DateLimite, Status) VALUES
(1, 'Obtenir le niveau Expert en cuisson des viandes', '2025-01-31', 'Atteint'),
(2, 'Améliorer le dressage créatif des plats', '2025-01-30', 'Atteint'),
(3, 'Améliorer la gestion du temps en cuisine', '2025-01-31', 'En cours'),
(4, 'Optimiser les techniques d’entretien de la cuisine', '2025-01-15', 'Non commencé'),
(5, 'Améliorer la gestion de l’équipe et la communication', '2025-01-31', 'En cours'),
(6, 'Atteindre le niveau avancé en pâtisserie', '2025-01-30', 'En cours');
