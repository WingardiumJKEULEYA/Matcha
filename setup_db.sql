CREATE TABLE IF NOT EXISTS `users` ( 
  `id` VARCHAR(36) NOT NULL , 
  `username` VARCHAR(32) NOT NULL , 
  `password` TEXT NOT NULL , 
  `mail` TEXT NOT NULL , 
  `firstname` VARCHAR(32) NOT NULL , 
  `lastname` VARCHAR(32) NOT NULL ,
  `age` INT(11) NOT NULL DEFAULT '18',
  `gender` ENUM('MAN','WOMAN') NULL , 
  `bio` TEXT NULL , 
  `location` VARCHAR(50) NOT NULL DEFAULT '48.8965568,2.3163477' , 
  `picture` TEXT NULL , 
  `orientation` ENUM('HETERO','BI','HOMO') NOT NULL DEFAULT 'BI' , 
  `score` INT NOT NULL DEFAULT '0' , 
  `status` ENUM('WAITING','CONFIRMED','BANNED') NOT NULL DEFAULT 'WAITING' ,
  `last_visit` TIMESTAMP NULL ,
  `register_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('c90e8efd-35f7-42d0-97a8-a621ac176768', 'jkeuleya', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'jkeuleya@student.42.fr', 'Jean-Michel', 'Keuleyan', 'MAN', 'xxx', '48.8965568,2.3163477', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); #42
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('8801f84a-81e7-4bf3-b433-88684240a851', 'user1', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail1@mail.fr', 'Alain', 'Lussier', 'MAN', 'xxx', '48.894092,2.314158', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Porte de Clichy
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('4c142618-5720-45de-bd00-7de76428fb05', 'user2', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail2@mail.fr', 'Marc', 'Varden', 'MAN', 'xxx', '48.892725,2.327201', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Guy Moquet
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('cc003c50-17d0-4c46-9abe-53dec3a4b5c9', 'user3', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail3@mail.fr', 'Paul', 'Fouquet', 'MAN', 'xxx', '48.887645,2.325382', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # La Fourche
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('f3a80b83-755f-48d3-af4a-43af10ac112a', 'user4', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail4@mail.fr', 'Catherine', 'Fremont', 'WOMAN', 'xxx', '48.876048,2.324591', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Saint Lazare
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('234bc097-e7f1-4d51-8691-cb38a9e7088c', 'user5', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail5@mail.fr', 'Pauline', 'Labbe', 'WOMAN', 'xxx', '48.880885,2.355140', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Gare du Nord
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('a279879b-8c26-4e04-a82d-465fd9b0b7d7', 'user6', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail6@mail.fr', 'Chloe', 'Girard', 'WOMAN', 'xxx', '48.868987,2.340585', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Bourse
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('b8a2bd25-917b-4717-9606-906cb7a59fd0', 'user7', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail7@mail.fr', 'Gaetan', 'Brousseau', 'MAN', 'xxx', '48.866228,2.323621', NULL, 'HOMO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Concorde
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('16abf513-ed05-4997-a85f-e783c8c7f920', 'user8', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail8@mail.fr', 'Laurie', 'Voisine', 'WOMAN', 'xxx', '48.861780,2.346970', NULL, 'HOMO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Chatelet
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('8f1556fc-e53f-46a5-9c65-8ddd29d3d716', 'user9', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail9@mail.fr', 'Gautier', 'Frappier', 'MAN', 'xxx', '48.839001, 2.330632', NULL, 'HOMO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Raspail
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('2b2ba1c4-a3c1-4216-837e-1668f0b3b975', 'user10', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail10@mail.fr', 'Deborah', 'Francoeur', 'WOMAN', 'xxx', '48.791482,2.402023', NULL, 'HOMO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Vitry (banlieue)
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('f00aec2f-6793-47a1-9226-8ca33149142d', 'user11', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail11@mail.fr', 'Axel', 'Cormier', 'MAN', 'xxx', '48.801722,2.124218', NULL, 'BI', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Versailles (banlieue)
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('eab91049-8d88-454c-823a-b09571e3a551', 'user12', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail12@mail.fr', 'Sixtine', 'Cantin', 'WOMAN', 'xxx', '48.986869,2.441039', NULL, 'BI', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Gonesse (banlieue)
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('03a37c25-ceaf-4212-a8da-ea01b4c6f541', 'user13', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail13@mail.fr', 'Remi', 'Dennis', 'MAN', 'xxx', '48.962067,2.554927', NULL, 'BI', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Villepinte (banlieue)
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('24c9a3f4-90fa-4490-8e44-f4d74f1bfb35', 'user14', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail14@mail.fr', 'Julie', 'Hervieux', 'WOMAN', 'xxx', '48.791964,2.452215', NULL, 'BI', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Créteil (banlieue)
INSERT INTO `sql8193488`.`users` (`id`, `username`, `password`, `mail`, `firstname`, `lastname`, `gender`, `bio`, `location`, `picture`, `orientation`, `score`, `status`, `last_visit`, `register_date`) VALUES ('41093145-40c7-4a9b-ac5a-3a6a1664b24b', 'user15', '$2a$06$Jh4jkBWTBglDLjPfHggeH.eFZF0hwcfoDG6fx/34bmpEmWYY7xz.6', 'mail15@mail.fr', 'Sarah', 'Heureux', 'WOMAN', 'xxx', '48.727412,2.362808', NULL, 'HETERO', '0', 'CONFIRMED', NULL, CURRENT_TIMESTAMP); # Orly ADP (banlieue)

CREATE TABLE IF NOT EXISTS `tags` (
  `id` INT(36) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(30) NOT NULL,
  primary key (id)
) ENGINE = InnoDB;

INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (1, 'first');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (2, 'second');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (3, 'third');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (4, 'fourth');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (5, 'fifth');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (6, 'sixth');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (7, 'seventh');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (8, 'eighth');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (9, 'nineth');
INSERT INTO `sql8193488`.`tags`(`id`, `name`) VALUES (10, 'tenth');

CREATE TABLE IF NOT EXISTS `user_tags` (
  `user` varchar(36) NOT NULL,
  `tag` VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('c90e8efd-35f7-42d0-97a8-a621ac176768', 'first');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('c90e8efd-35f7-42d0-97a8-a621ac176768', 'second');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('8801f84a-81e7-4bf3-b433-88684240a851', 'third');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('8801f84a-81e7-4bf3-b433-88684240a851', 'fourth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('4c142618-5720-45de-bd00-7de76428fb05', 'fifth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('4c142618-5720-45de-bd00-7de76428fb05', 'sixth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('cc003c50-17d0-4c46-9abe-53dec3a4b5c9', 'seventh');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('cc003c50-17d0-4c46-9abe-53dec3a4b5c9', 'eighth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('f3a80b83-755f-48d3-af4a-43af10ac112a', 'nineth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('f3a80b83-755f-48d3-af4a-43af10ac112a', 'tenth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('234bc097-e7f1-4d51-8691-cb38a9e7088c', 'first');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('234bc097-e7f1-4d51-8691-cb38a9e7088c', 'second');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('a279879b-8c26-4e04-a82d-465fd9b0b7d7', 'third');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('a279879b-8c26-4e04-a82d-465fd9b0b7d7', 'fourth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('b8a2bd25-917b-4717-9606-906cb7a59fd0', 'fifth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('b8a2bd25-917b-4717-9606-906cb7a59fd0', 'sixth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('16abf513-ed05-4997-a85f-e783c8c7f920', 'seventh');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('16abf513-ed05-4997-a85f-e783c8c7f920', 'eighth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('8f1556fc-e53f-46a5-9c65-8ddd29d3d716', 'nineth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('8f1556fc-e53f-46a5-9c65-8ddd29d3d716', 'tenth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('2b2ba1c4-a3c1-4216-837e-1668f0b3b975', 'first');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('2b2ba1c4-a3c1-4216-837e-1668f0b3b975', 'second');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('f00aec2f-6793-47a1-9226-8ca33149142d', 'third');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('f00aec2f-6793-47a1-9226-8ca33149142d', 'fourth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('eab91049-8d88-454c-823a-b09571e3a551', 'fifth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('eab91049-8d88-454c-823a-b09571e3a551', 'sixth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('03a37c25-ceaf-4212-a8da-ea01b4c6f541', 'seventh');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('03a37c25-ceaf-4212-a8da-ea01b4c6f541', 'eighth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('24c9a3f4-90fa-4490-8e44-f4d74f1bfb35', 'nineth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('24c9a3f4-90fa-4490-8e44-f4d74f1bfb35', 'tenth');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('41093145-40c7-4a9b-ac5a-3a6a1664b24b', 'first');
INSERT INTO `sql8193488`.`user_tags`(`user`, `tag`) VALUES ('41093145-40c7-4a9b-ac5a-3a6a1664b24b', 'second');


CREATE TABLE IF NOT EXISTS `images` (
  `user` VARCHAR(36) NOT NULL ,
  `img` MEDIUMTEXT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `blocked_users` (
  `user` varchar(36) NOT NULL,
  `blocked_target` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `matchs` (
  `user` varchar(36) NOT NULL,
  `match_target` varchar(36) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reciprocal` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `visits` (
  `user` varchar(36) NOT NULL,
  `visit_target` varchar(36) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_alerts` (
  `id` varchar(36) NOT NULL,
  `visitor` varchar(36) NOT NULL,
  `message` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `displayed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `chats` (
  `id` varchar(36) NOT NULL,
  `user_1` varchar(36) NOT NULL,
  `user_2` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `chat_msgs` (
  `id` varchar(36) NOT NULL,
  `user` varchar(36) NOT NULL,
  `msg` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reports` (
  `id` varchar(36) NOT NULL,
  `user` varchar(36) NOT NULL,
  `reported_target` varchar(36) NOT NULL,
  `type` enum('FAKE','HARASSMENT','INSULTS') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bugs` (
  `id` INT(36) NOT NULL AUTO_INCREMENT ,
  `user` VARCHAR(36) NOT NULL,
  `description` text NOT NULL,
  primary key (id)
) ENGINE = InnoDB;


ALTER TABLE `chats`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `reports`
--
ALTER TABLE `reports`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `tokens`
--
-- ALTER TABLE `tokens`
--  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_alerts`
--
ALTER TABLE `user_alerts`
 ADD PRIMARY KEY (`id`);