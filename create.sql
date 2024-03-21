-- Creating the database
CREATE DATABASE IF NOT EXISTS projetgaia;
USE projetgaia;

-- Creating the 'utilisateur' table
CREATE TABLE IF NOT EXISTS utilisateur (
    IdUtilisateur INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(255) NOT NULL,
    Prenom VARCHAR(255) NOT NULL,
    Age INT NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    NumClient VARCHAR(255) NOT NULL
);

-- Inserting data into 'utilisateur'
INSERT INTO utilisateur (IdUtilisateur, Nom, Prenom, Age, Adresse, NumClient) VALUES
(1,'DUPONT', 'Marie', 34, '10 rue de la République', '098765'),
(2,'MARTIN', 'Luc', 29, '22 avenue des Champs', '112233'),
(3,'BERNARD', 'Francoise', 45, '3 boulevard de la Liberté', '445566'),
(4,'DUBOIS', 'Julien', 37, '15 rue du Port', '778899'),
(5,'LEROY', 'Sophie', 26, '18 avenue de l’Opéra', '990011'),
(6,'MOREAU', 'Christophe', 48, '27 rue du Commerce', '223344'),
(7,'SIMON', 'Patricia', 52, '4 impasse des Lilas', '556677'),
(8,'LAURENT', 'Élodie', 31, '8 rue des Peupliers', '889900'),
(9,'LEFEVRE', 'Guillaume', 41, '11 rue de la Paix', '667788'),
(10,'MICHEL', 'Claire', 38, '9 avenue Victor Hugo', '334455');
-- Creating the 'position' table
CREATE TABLE IF NOT EXISTS position (
    IdPosition INT AUTO_INCREMENT PRIMARY KEY,
    Latitude DECIMAL(10, 6) NOT NULL,
    Longitude DECIMAL(10, 6) NOT NULL,
    Altitude DECIMAL(5, 2) NOT NULL,
    FKIdUtilisateur INT,
    FOREIGN KEY (FKIdUtilisateur) REFERENCES utilisateur(IdUtilisateur)
);

-- Inserting data into 'position'
INSERT INTO position (IdPosition, Latitude, Longitude, Altitude, FKIdUtilisateur) VALUES
(1, -20.8821, 55.4507, 50, 1),
(2, -21.3328, 55.4718, 150, 2),
(5, 21.287, 55.409, 50, 3);

-- Creating the 'donnees' table
CREATE TABLE IF NOT EXISTS donnees (
    IdDonnees INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp TIMESTAMP NOT NULL,
    DCE DECIMAL(3, 2) NOT NULL,
    TCEAM INT NOT NULL,
    TCEAMB INT NOT NULL,
    TCEAV INT NOT NULL,
    ENS DECIMAL(5, 2) NOT NULL,
    EEC DECIMAL(3, 2) NOT NULL,
    FKIdPosition INT,
    FOREIGN KEY (FKIdPosition) REFERENCES position(IdPosition)
);

-- Inserting data into 'donnees'
INSERT INTO donnees (IdDonnees, Timestamp, DCE, TCEAM, TCEAMB, TCEAV, ENS, EEC, FKIdPosition) VALUES
(1, '2024-03-13 13:48:57', 1.5, 24, 30, 26, 100, 2, 1),
(2, '2024-03-13 13:49:10', 1.4, 20, 22, 24, 80, 1.5, 2),
(3, '2024-03-13 13:49:45', 2, 10, 29, 24, 120, 3, 1),
(5, '2024-03-13 13:50:04', 2.5, 15, 26, 25, 40, 1, 2),
(6, '2024-03-13 13:50:31', 3.5, 9, 20, 26, 3.1, 3, 5);
