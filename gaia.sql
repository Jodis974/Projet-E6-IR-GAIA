-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 20 mars 2024 à 07:56
-- Version du serveur : 10.4.21-MariaDB
-- Version de PHP : 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projetgaia`
--

-- --------------------------------------------------------

--
-- Structure de la table `donnees`
--

CREATE TABLE `donnees` (
  `IdDonnees` int(11) NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `DCE` float NOT NULL,
  `TCEAM` float NOT NULL,
  `TCEAMB` int(11) NOT NULL,
  `TCEAV` int(11) NOT NULL,
  `ENS` float NOT NULL,
  `EEC` float NOT NULL,
  `FKIdPosition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `donnees`
--

INSERT INTO `donnees` (`IdDonnees`, `Timestamp`, `DCE`, `TCEAM`, `TCEAMB`, `TCEAV`, `ENS`, `EEC`, `FKIdPosition`) VALUES
(1, '2024-03-13 09:48:57', 1.5, 24, 30, 26, 100, 2, 1),
(2, '2024-03-13 09:49:10', 1.4, 20, 22, 24, 80, 1.5, 2),
(3, '2024-03-13 09:49:45', 2, 10, 29, 24, 120, 3, 1),
(5, '2024-03-13 09:50:04', 2.5, 15, 26, 25, 40, 1, 2),
(6, '2024-03-13 09:50:31', 3.5, 9, 20, 26, 3.1, 3, 5);

-- --------------------------------------------------------

--
-- Structure de la table `position`
--

CREATE TABLE `position` (
  `IdPosition` int(11) NOT NULL,
  `Latitude` float NOT NULL,
  `Longitude` float NOT NULL,
  `Altitude` float NOT NULL,
  `FKIdUtilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `position`
--

INSERT INTO `position` (`IdPosition`, `Latitude`, `Longitude`, `Altitude`, `FKIdUtilisateur`) VALUES
(1, -20.8821, 55.4507, 50, 1),
(2, -21.3328, 55.4718, 150, 2),
(5, 21.287, 55.409, 50, 3);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `IdUtilisateur` int(11) NOT NULL,
  `Nom` varchar(100) NOT NULL,
  `Prenom` varchar(100) NOT NULL,
  `Age` int(11) NOT NULL,
  `Adresse` tinytext NOT NULL,
  `NumClient` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`IdUtilisateur`, `Nom`, `Prenom`, `Age`, `Adresse`, `NumClient`) VALUES
(1, 'BOYER', 'Jeremy', 48, '15 allee des lilas', '015905'),
(2, 'HOARAU', 'Jean', 30, '1 rue georges brassens', '047945'),
(3, 'FONTAINE', 'Thomas', 45, '8 rue des Jasmin ', '02542541');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `donnees`
--
ALTER TABLE `donnees`
  ADD PRIMARY KEY (`IdDonnees`),
  ADD KEY `FKIdPosition` (`FKIdPosition`);

--
-- Index pour la table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`IdPosition`),
  ADD KEY `FKIdUtilisateur` (`FKIdUtilisateur`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`IdUtilisateur`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `donnees`
--
ALTER TABLE `donnees`
  MODIFY `IdDonnees` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `position`
--
ALTER TABLE `position`
  MODIFY `IdPosition` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `IdUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `donnees`
--
ALTER TABLE `donnees`
  ADD CONSTRAINT `donnees_ibfk_1` FOREIGN KEY (`FKIdPosition`) REFERENCES `position` (`IdPosition`);

--
-- Contraintes pour la table `position`
--
ALTER TABLE `position`
  ADD CONSTRAINT `position_ibfk_1` FOREIGN KEY (`FKIdUtilisateur`) REFERENCES `utilisateur` (`IdUtilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
