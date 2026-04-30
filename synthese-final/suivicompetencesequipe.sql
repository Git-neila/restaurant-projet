-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 25 avr. 2025 à 04:39
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `suivicompetencesequipe`
--

-- --------------------------------------------------------

--
-- Structure de la table `categoriescompetences`
--

CREATE TABLE `categoriescompetences` (
  `Nom` varchar(50) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `categoriescompetences`
--

INSERT INTO `categoriescompetences` (`Nom`, `Description`) VALUES
('Comportementale', 'Compétences transversales liées au comportement et à la communication'),
('Cuisine', 'Compétences liées à la préparation des plats, cuisson, dressage, etc.'),
('Pâtisserie', 'Compétences spécifiques à la pâtisserie, desserts, décoration, etc.');

-- --------------------------------------------------------

--
-- Structure de la table `competences`
--

CREATE TABLE `competences` (
  `Nom` varchar(50) NOT NULL,
  `Categorie` varchar(50) DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `competences`
--

INSERT INTO `competences` (`Nom`, `Categorie`, `Description`) VALUES
('Assistance en cuisine', 'Cuisine', 'Aider à la préparation des plats et au bon déroulement du service'),
('Cuisson des viandes', 'Cuisine', 'Maîtriser les différentes techniques de cuisson des viandes'),
('Dressage des plats', 'Cuisine', 'Savoir disposer les éléments dans l’assiette de manière esthétique'),
('Efficace/Dynamique', 'Comportementale', 'Travailler rapidement, efficacement et avec enthousiasme'),
('Leadership/Communication', 'Comportementale', 'Manager et communiquer efficacement avec l’équipe'),
('Pâtisserie fine', 'Pâtisserie', 'Réaliser des desserts raffinés'),
('Polyvalence', 'Comportementale', 'Être capable de s’adapter à différents rôles au sein de l’équipe');

-- --------------------------------------------------------

--
-- Structure de la table `employes`
--

CREATE TABLE `employes` (
  `ID_employe` int(11) NOT NULL,
  `Nom` varchar(30) NOT NULL,
  `Prenom` varchar(50) NOT NULL,
  `Poste` varchar(50) DEFAULT NULL,
  `DateEmbauche` date DEFAULT NULL,
  `Experience` int(11) DEFAULT NULL,
  `Specialite` varchar(50) DEFAULT NULL,
  `Contact` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `employes`
--

INSERT INTO `employes` (`ID_employe`, `Nom`, `Prenom`, `Poste`, `DateEmbauche`, `Experience`, `Specialite`, `Contact`) VALUES
(1, 'Yanna', 'Orneila', 'Chef cuisiniere', '2022-05-06', 8, 'Cuisine gastronomique', 'Orneila.yanna@example.com'),
(2, 'Guigma', 'Roxy', 'Chef Pâtissiere', '2022-01-10', 9, 'Pâtisserie fine', 'Roxy.guigma@example.com'),
(3, 'Leroy', 'Yanis', 'Commis', '2023-01-01', 4, 'Cuisine traditionnelle', 'Yanis.leroy@example.com'),
(4, 'Martins', 'Brandon', 'Plongeur', '2022-05-15', 3, 'Hygiene/Entretien', 'Brandon.Martins@example.com'),
(5, 'Banaken', 'Jordan', 'Manager', '2020-08-08', 7, 'Ressources humaines', 'Jordan.banaken@example.com'),
(6, 'Blanc', 'Lucie', 'Commis pâtissiere', '2024-10-01', 2, 'Pâtisserie', 'lucie.blanc@example.com');

-- --------------------------------------------------------

--
-- Structure de la table `evaluations`
--

CREATE TABLE `evaluations` (
  `ID_evaluation` int(11) NOT NULL,
  `ID_employe` int(11) DEFAULT NULL,
  `Competence` varchar(50) NOT NULL,
  `Niveau` varchar(20) NOT NULL CHECK (`Niveau` in ('Débutant','Intermédiaire','Avancé','Expert')),
  `DateEvaluation` date DEFAULT NULL,
  `Commentaires` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `evaluations`
--

INSERT INTO `evaluations` (`ID_evaluation`, `ID_employe`, `Competence`, `Niveau`, `DateEvaluation`, `Commentaires`) VALUES
(1, 1, 'Cuisson des viandes', 'Avancé', '2022-05-06', 'Très précis et rapide dans la découpe'),
(2, 2, 'Pâtisserie fine', 'Expert', '2022-01-10', 'Excellente maîtrise des desserts élaborés'),
(3, 2, 'Dressage des plats', 'Avancé', '2022-01-10', 'Bonne présentation des plats, mais peut encore améliorer la créativité'),
(4, 3, 'Assistance en cuisine', 'Avancé', '2023-01-01', 'Polyvalent, aide dans diverses tâches de cuisine avec efficacité'),
(5, 4, 'Efficace/Dynamique', 'Avancé', '2022-05-15', 'Maîtrise parfaite des techniques de pâtisserie fine'),
(6, 5, 'Leadership/Communication', 'Expert', '2020-01-01', 'Bonne connaissance des bases de la cuisine moderne, mais nécessite plus de pratique'),
(7, 6, 'Polyvalence', 'Intermédiaire', '2024-10-01', 'Doit améliorer ses compétences en présentation des plats'),
(8, 2, 'Assistance en cuisine', 'avance ', '2025-04-24', 'tres bien'),
(11, 2, 'Assistance en cuisine', 'avance', '2025-04-24', 'Bien avancer, parfait');

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

CREATE TABLE `formations` (
  `ID_formation` int(11) NOT NULL,
  `Nom` varchar(50) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `formations`
--

INSERT INTO `formations` (`ID_formation`, `Nom`, `Description`, `DateDebut`, `DateFin`) VALUES
(1, 'Formation pâtisserie', 'Formation avancée sur la pâtisserie fine et les techniques modernes de décoration', '2024-11-01', '2025-03-01'),
(2, 'Formation pâtisserie', 'Formation avancée sur la pâtisserie fine et les techniques modernes de décoration', '2022-02-01', '2022-05-01'),
(3, 'Gestion des viandes', 'Formation sur les différentes techniques de cuisson des viandes', '2023-05-01', '2023-08-01');

-- --------------------------------------------------------

--
-- Structure de la table `historiquecompetences`
--

CREATE TABLE `historiquecompetences` (
  `ID_historique` int(11) NOT NULL,
  `ID_employe` int(11) DEFAULT NULL,
  `Competence` varchar(50) DEFAULT NULL,
  `NiveauAvant` varchar(20) DEFAULT NULL,
  `NiveauApres` varchar(20) DEFAULT NULL,
  `DateModification` date DEFAULT NULL,
  `Commentaires` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `historiquecompetences`
--

INSERT INTO `historiquecompetences` (`ID_historique`, `ID_employe`, `Competence`, `NiveauAvant`, `NiveauApres`, `DateModification`, `Commentaires`) VALUES
(1, 1, 'Cuisson des viandes', 'Intermédiaire', 'Avancé', '2024-12-01', 'Amélioration notable dans la gestion des températures et la découpe des viandes'),
(2, 2, 'Pâtisserie fine', 'Avancé', 'Expert', '2024-12-01', 'Excellente maîtrise des techniques avancées de pâtisserie et de présentation des desserts'),
(3, 2, 'Dressage des plats', 'Intermédiaire', 'Avancé', '2024-12-01', 'Amélioration dans le design des plats, mais reste à peaufiner la créativité'),
(4, 3, 'Assistance en cuisine', 'Débutant', 'Avancé', '2024-12-01', 'Passage rapide au niveau avancé grâce à la formation et la pratique sur le terrain'),
(5, 4, 'Efficace/Dynamique', 'Intermédiaire', 'Avancé', '2024-12-01', 'Grand progrès en efficacité et dynamisme dans le travail en cuisine, gestion des tâches améliorée'),
(6, 5, 'Leadership/Communication', 'Intermédiaire', 'Expert', '2024-12-01', 'Maîtrise des techniques de communication en équipe et gestion du personnel efficace'),
(7, 6, 'Polyvalence', 'Débutant', 'Intermédiaire', '2024-12-01', 'A fait des progrès significatifs dans l’assistance et la gestion des tâches en pâtisserie');

-- --------------------------------------------------------

--
-- Structure de la table `objectifs`
--

CREATE TABLE `objectifs` (
  `ID_objectif` int(11) NOT NULL,
  `ID_employe` int(11) DEFAULT NULL,
  `Objectif` varchar(100) DEFAULT NULL,
  `DateLimite` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `objectifs`
--

INSERT INTO `objectifs` (`ID_objectif`, `ID_employe`, `Objectif`, `DateLimite`, `Status`) VALUES
(1, 1, 'Obtenir le niveau Expert en cuisson des viandes', '2025-01-31', 'Atteint'),
(2, 2, 'Améliorer le dressage créatif des plats', '2025-01-30', 'Atteint'),
(3, 3, 'Améliorer la gestion du temps en cuisine', '2025-01-31', 'En cours'),
(4, 4, 'Optimiser les techniques d’entretien de la cuisine', '2025-01-15', 'Non commencé'),
(5, 5, 'Améliorer la gestion de l’équipe et la communication', '2025-01-31', 'En cours'),
(6, 6, 'Atteindre le niveau avancé en pâtisserie', '2025-01-30', 'En cours');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categoriescompetences`
--
ALTER TABLE `categoriescompetences`
  ADD PRIMARY KEY (`Nom`);

--
-- Index pour la table `competences`
--
ALTER TABLE `competences`
  ADD PRIMARY KEY (`Nom`),
  ADD KEY `Categorie` (`Categorie`);

--
-- Index pour la table `employes`
--
ALTER TABLE `employes`
  ADD PRIMARY KEY (`ID_employe`);

--
-- Index pour la table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`ID_evaluation`),
  ADD KEY `ID_employe` (`ID_employe`),
  ADD KEY `Competence` (`Competence`);

--
-- Index pour la table `formations`
--
ALTER TABLE `formations`
  ADD PRIMARY KEY (`ID_formation`);

--
-- Index pour la table `historiquecompetences`
--
ALTER TABLE `historiquecompetences`
  ADD PRIMARY KEY (`ID_historique`),
  ADD KEY `ID_employe` (`ID_employe`),
  ADD KEY `Competence` (`Competence`);

--
-- Index pour la table `objectifs`
--
ALTER TABLE `objectifs`
  ADD PRIMARY KEY (`ID_objectif`),
  ADD KEY `ID_employe` (`ID_employe`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `employes`
--
ALTER TABLE `employes`
  MODIFY `ID_employe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `ID_evaluation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `formations`
--
ALTER TABLE `formations`
  MODIFY `ID_formation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `historiquecompetences`
--
ALTER TABLE `historiquecompetences`
  MODIFY `ID_historique` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `objectifs`
--
ALTER TABLE `objectifs`
  MODIFY `ID_objectif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `competences`
--
ALTER TABLE `competences`
  ADD CONSTRAINT `competences_ibfk_1` FOREIGN KEY (`Categorie`) REFERENCES `categoriescompetences` (`Nom`);

--
-- Contraintes pour la table `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `evaluations_ibfk_1` FOREIGN KEY (`ID_employe`) REFERENCES `employes` (`ID_employe`),
  ADD CONSTRAINT `evaluations_ibfk_2` FOREIGN KEY (`Competence`) REFERENCES `competences` (`Nom`);

--
-- Contraintes pour la table `historiquecompetences`
--
ALTER TABLE `historiquecompetences`
  ADD CONSTRAINT `historiquecompetences_ibfk_1` FOREIGN KEY (`ID_employe`) REFERENCES `employes` (`ID_employe`),
  ADD CONSTRAINT `historiquecompetences_ibfk_2` FOREIGN KEY (`Competence`) REFERENCES `competences` (`Nom`);

--
-- Contraintes pour la table `objectifs`
--
ALTER TABLE `objectifs`
  ADD CONSTRAINT `objectifs_ibfk_1` FOREIGN KEY (`ID_employe`) REFERENCES `employes` (`ID_employe`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
