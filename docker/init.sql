SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données : `mesureonline`
--
CREATE DATABASE IF NOT EXISTS mesureonline;
USE mesureonline;
-- --------------------------------------------------------

--
-- Structure de la table `evaluation`
--

CREATE TABLE `evaluation` (
  `id` int(11) NOT NULL,
  `scale_id` int(11) NOT NULL,
  `evaluator_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `patient_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `results` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `comment` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Structure de la table `invitation`
--

CREATE TABLE `invitation` (
  `id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `invite_string` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Structure de la table `migration_versions`
--

CREATE TABLE `migration_versions` (
  `version` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migration_versions`
--

INSERT INTO `migration_versions` (`version`, `executed_at`) VALUES
('20200514131938', '2020-05-18 08:38:55'),
('20200518084441', '2020-05-18 08:45:02'),
('20200518085000', '2020-05-26 08:18:27'),
('20200518090855', '2020-05-26 08:18:28'),
('20200526081649', '2020-05-26 08:18:33'),
('20200526122918', '2020-05-26 12:29:25'),
('20200618123452', '2020-06-18 12:35:11');

-- --------------------------------------------------------

--
-- Structure de la table `registration`
--

CREATE TABLE `registration` (
  `id` int(11) NOT NULL,
  `invite_string` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `role` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`role`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `scale`
--

CREATE TABLE `scale` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `render_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scale_display_category` tinyint(1) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  `display_score_percent` tinyint(1) NOT NULL,
  `display_scale_percent` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `scale`
--

INSERT INTO `scale` (`id`, `name`, `render_type`, `comment`, `scale_display_category`, `team_id`, `display_score_percent`, `display_scale_percent`) VALUES
(1, 'Fugl-Meyer Assessment UE - Woodbury 2007', 'horizontal_poly', 'Les données de cette échelle sont à vérifier.', 0, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `scale_item`
--

CREATE TABLE `scale_item` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `standard_error` double DEFAULT NULL,
  `standard_error_inf` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `scale_item`
--

INSERT INTO `scale_item` (`id`, `category_id`, `name`, `standard_error`, `standard_error_inf`) VALUES
(82, 18, 'wrist circumduction', 0.1, NULL),
(83, 18, 'Hook grasp', 0.1, NULL),
(84, 18, 'Shoulder flexion', 0.1, NULL),
(85, 18, 'Spherical grasp', 0.1, NULL),
(86, 18, 'Lateral Prehension', 0.1, NULL),
(87, 18, 'Wrist flexion-extension, elbow extended', 0.1, NULL),
(88, 18, 'Pronation-supination, elbow extended', 0.1, NULL),
(89, 18, 'Wrist stable, elbow extended', 0.1, NULL),
(90, 18, 'Movement with normal speed', 0.1, NULL),
(91, 18, 'Forearm supination', 0.1, NULL),
(92, 18, 'Shoulder abduction to 90°, elbow extended', 0.1, NULL),
(93, 18, 'Movement without dysmetria', 0.1, NULL),
(94, 18, 'Shoulder external rotation', 0.1, NULL),
(95, 18, 'Wrist stable, elbow at 90°', 0.1, NULL),
(96, 18, 'Wrist flexion-extension, elbow at 90°', 0.1, NULL),
(97, 18, 'Palmar prehension', 0.1, NULL),
(98, 18, 'Scapular retraction', 0.1, NULL),
(99, 18, 'Pronation-supination, elbow at 90°', 0.11, NULL),
(100, 18, 'Shoulder flexion to 90°, elbow extended', 0.11, NULL),
(101, 18, 'Hand to lumbar spine', 0.11, NULL),
(102, 18, 'Shoulder abduction', 0.11, NULL),
(103, 18, 'Elbow extension', 0.11, NULL),
(104, 18, 'Forearm pronation', 0.11, NULL),
(105, 18, 'Movement without tremor', 0.11, NULL),
(106, 18, 'Cylindrical grasp', 0.12, NULL),
(107, 18, 'Finger mass extension', 0.12, NULL),
(108, 18, 'Scapular elevation', 0.12, NULL),
(109, 18, 'Finger mass flexion', 0.12, NULL),
(110, 18, 'Shoulder adduction with internal rotation', 0.12, NULL),
(111, 18, 'Elbow flexion', 0.13, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `scale_item_category`
--

CREATE TABLE `scale_item_category` (
  `id` int(11) NOT NULL,
  `scale_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `scale_item_category`
--

INSERT INTO `scale_item_category` (`id`, `scale_id`, `name`) VALUES
(18, 1, 'Default');

-- --------------------------------------------------------

--
-- Structure de la table `scale_item_choice`
--

CREATE TABLE `scale_item_choice` (
  `id` int(11) NOT NULL,
  `scale_item_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` int(11) NOT NULL,
  `logit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `scale_item_choice`
--

INSERT INTO `scale_item_choice` (`id`, `scale_item_id`, `name`, `value`, `logit`) VALUES
(92, 82, 'Unable', 0, -0.63),
(93, 82, 'Partially Able', 1, 1.67),
(94, 82, 'Able', 2, 3.97),
(95, 83, 'Unable', 0, -0.97),
(96, 83, 'Partially Able', 1, 1.33),
(97, 83, 'Able', 2, 3.63),
(98, 84, 'Unable', 0, -1.04),
(99, 84, 'Partially Able', 1, 1.26),
(100, 84, 'Able', 2, 3.56),
(101, 85, 'Unable', 0, -1.1),
(102, 85, 'Partially Able', 1, 1.2),
(103, 85, 'Able', 2, 3.5),
(104, 86, 'Unable', 0, -1.22),
(105, 86, 'Partially Able', 1, 1.08),
(106, 86, 'Able', 2, 3.38),
(107, 87, 'Unable', 0, -1.24),
(108, 87, 'Partially Able', 1, 1.06),
(109, 87, 'Able', 2, 3.36),
(110, 88, 'Unable', 0, -1.3),
(111, 88, 'Partially Able', 1, 1),
(112, 88, 'Able', 2, 3.3),
(113, 89, 'Unable', 0, -1.35),
(114, 89, 'Partially Able', 1, 0.95),
(115, 89, 'Able', 2, 3.25),
(116, 90, 'Unable', 0, -1.41),
(117, 90, 'Partially Able', 1, 0.89),
(118, 90, 'Able', 2, 3.19),
(119, 91, 'Unable', 0, -1.65),
(120, 91, 'Partially Able', 1, 0.65),
(121, 91, 'Able', 2, 2.95),
(122, 92, 'Unable', 0, -2.02),
(123, 92, 'Partially Able', 1, 0.28),
(124, 92, 'Able', 2, 2.58),
(125, 93, 'Unable', 0, -2.03),
(126, 93, 'Partially Able', 1, 0.27),
(127, 93, 'Able', 2, 2.57),
(128, 94, 'Unable', 0, -2.06),
(129, 94, 'Partially Able', 1, 0.24),
(130, 94, 'Able', 2, 2.54),
(131, 95, 'Unable', 0, -2.12),
(132, 95, 'Partially Able', 1, 0.18),
(133, 95, 'Able', 2, 2.48),
(134, 96, 'Unable', 0, -2.18),
(135, 96, 'Partially Able', 1, 0.12),
(136, 96, 'Able', 2, 2.42),
(137, 97, 'Unable', 0, -2.24),
(138, 97, 'Partially Able', 1, 0.06),
(139, 97, 'Able', 2, 2.36),
(140, 98, 'Unable', 0, -2.27),
(141, 98, 'Partially Able', 1, 0.03),
(142, 98, 'Able', 2, 2.33),
(143, 99, 'Unable', 0, -2.47),
(144, 99, 'Partially Able', 1, -0.17),
(145, 99, 'Able', 2, 2.13),
(146, 100, 'Unable', 0, -2.51),
(147, 100, 'Partially Able', 1, -0.21),
(148, 100, 'Able', 2, 2.09),
(149, 101, 'Unable', 0, -2.7),
(150, 101, 'Partially Able', 1, -0.4),
(151, 101, 'Able', 2, 1.9),
(152, 102, 'Unable', 0, -2.86),
(153, 102, 'Partially Able', 1, -0.56),
(154, 102, 'Able', 2, 1.74),
(155, 103, 'Unable', 0, -2.94),
(156, 103, 'Partially Able', 1, -0.64),
(157, 103, 'Able', 2, 1.661),
(158, 104, 'Unable', 0, -3.17),
(159, 104, 'Partially Able', 1, -0.87),
(160, 104, 'Able', 2, 1.43),
(161, 105, 'Unable', 0, -3.21),
(162, 105, 'Partially Able', 1, -0.91),
(163, 105, 'Able', 2, 1.39),
(164, 106, 'Unable', 0, -3.4),
(165, 106, 'Partially Able', 1, -1.1),
(166, 106, 'Able', 2, 1.2),
(167, 107, 'Unable', 0, -3.55),
(168, 107, 'Partially Able', 1, -1.25),
(169, 107, 'Able', 2, 1.05),
(170, 108, 'Unable', 0, -3.7),
(171, 108, 'Partially Able', 1, -1.4),
(172, 108, 'Able', 2, 0.9),
(173, 109, 'Unable', 0, -3.74),
(174, 109, 'Partially Able', 1, -1.44),
(175, 109, 'Able', 2, 0.86),
(176, 110, 'Unable', 0, -3.86),
(177, 110, 'Partially Able', 1, -1.56),
(178, 110, 'Able', 2, 0.74),
(179, 111, 'Unable', 0, -4.06),
(180, 111, 'Partially Able', 1, -1.76),
(181, 111, 'Able', 2, 0.54);
-- --------------------------------------------------------

--
-- Structure de la table `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `leader_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `team_evaluation`
--

CREATE TABLE `team_evaluation` (
  `team_id` int(11) NOT NULL,
  `evaluation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `roles`, `password`) VALUES
(11, 'admin', '[\"ROLE_MASTER\"]', '$argon2id$v=19$m=65536,t=4,p=1$i0QYFWnPP32Vl5H4uxnuvA$dZe5Vc/etYEGo85VZjcEDg1p+e9/CYu4+1kDsTgrXj8');

-- --------------------------------------------------------

--
-- Structure de la table `user_team`
--

CREATE TABLE `user_team` (
  `user_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Index pour les tables déchargées
--

--
-- Index pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1323A575F73142C2` (`scale_id`),
  ADD KEY `IDX_1323A57543575BE2` (`evaluator_id`);

--
-- Index pour la table `invitation`
--
ALTER TABLE `invitation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F11D61A2296CD8AE` (`team_id`);

--
-- Index pour la table `migration_versions`
--
ALTER TABLE `migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `scale`
--
ALTER TABLE `scale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_EC462584296CD8AE` (`team_id`);

--
-- Index pour la table `scale_item`
--
ALTER TABLE `scale_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_176851C912469DE2` (`category_id`);

--
-- Index pour la table `scale_item_category`
--
ALTER TABLE `scale_item_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_3EE2A4BF73142C2` (`scale_id`);

--
-- Index pour la table `scale_item_choice`
--
ALTER TABLE `scale_item_choice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C243EFB118F6ED97` (`scale_item_id`);

--
-- Index pour la table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C4E0A61F73154ED4` (`leader_id`);

--
-- Index pour la table `team_evaluation`
--
ALTER TABLE `team_evaluation`
  ADD PRIMARY KEY (`team_id`,`evaluation_id`),
  ADD KEY `IDX_2DFAD7B0296CD8AE` (`team_id`),
  ADD KEY `IDX_2DFAD7B0456C5646` (`evaluation_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649F85E0677` (`username`);

--
-- Index pour la table `user_team`
--
ALTER TABLE `user_team`
  ADD PRIMARY KEY (`user_id`,`team_id`),
  ADD KEY `IDX_BE61EAD6A76ED395` (`user_id`),
  ADD KEY `IDX_BE61EAD6296CD8AE` (`team_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT pour la table `invitation`
--
ALTER TABLE `invitation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT pour la table `registration`
--
ALTER TABLE `registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `scale`
--
ALTER TABLE `scale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `scale_item`
--
ALTER TABLE `scale_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT pour la table `scale_item_category`
--
ALTER TABLE `scale_item_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `scale_item_choice`
--
ALTER TABLE `scale_item_choice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT pour la table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD CONSTRAINT `FK_1323A57543575BE2` FOREIGN KEY (`evaluator_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_1323A575F73142C2` FOREIGN KEY (`scale_id`) REFERENCES `scale` (`id`);

--
-- Contraintes pour la table `invitation`
--
ALTER TABLE `invitation`
  ADD CONSTRAINT `FK_F11D61A2296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`);

--
-- Contraintes pour la table `scale`
--
ALTER TABLE `scale`
  ADD CONSTRAINT `FK_EC462584296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`);

--
-- Contraintes pour la table `scale_item`
--
ALTER TABLE `scale_item`
  ADD CONSTRAINT `FK_176851C912469DE2` FOREIGN KEY (`category_id`) REFERENCES `scale_item_category` (`id`);

--
-- Contraintes pour la table `scale_item_category`
--
ALTER TABLE `scale_item_category`
  ADD CONSTRAINT `FK_3EE2A4BF73142C2` FOREIGN KEY (`scale_id`) REFERENCES `scale` (`id`);

--
-- Contraintes pour la table `scale_item_choice`
--
ALTER TABLE `scale_item_choice`
  ADD CONSTRAINT `FK_C243EFB118F6ED97` FOREIGN KEY (`scale_item_id`) REFERENCES `scale_item` (`id`);

--
-- Contraintes pour la table `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `FK_C4E0A61F73154ED4` FOREIGN KEY (`leader_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `team_evaluation`
--
ALTER TABLE `team_evaluation`
  ADD CONSTRAINT `FK_2DFAD7B0296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_2DFAD7B0456C5646` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_team`
--
ALTER TABLE `user_team`
  ADD CONSTRAINT `FK_BE61EAD6296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_BE61EAD6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
