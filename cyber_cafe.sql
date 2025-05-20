-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 20, 2025 at 12:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cyber_cafe`
--

-- --------------------------------------------------------

--
-- Table structure for table `billing_rates`
--

CREATE TABLE `billing_rates` (
  `rate_id` int(11) NOT NULL,
  `rate_name` varchar(50) NOT NULL,
  `rate_per_minute` decimal(5,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billing_rates`
--

INSERT INTO `billing_rates` (`rate_id`, `rate_name`, `rate_per_minute`, `created_at`) VALUES
(1, 'Standard Rate', 0.05, '2025-05-19 13:08:36'),
(2, 'Standard Rate', 0.05, '2025-05-20 08:37:02'),
(3, 'Premuim', 0.10, '2025-05-20 09:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `revenue`
--

CREATE TABLE `revenue` (
  `revenue_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_type` enum('prepaid','postpaid') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `revenue`
--

INSERT INTO `revenue` (`revenue_id`, `session_id`, `amount`, `payment_type`, `created_at`) VALUES
(1, 5, 0.30, 'postpaid', '2025-05-20 09:36:11'),
(2, 6, 2.30, 'prepaid', '2025-05-20 10:05:32');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `pc_number` int(11) NOT NULL,
  `status` enum('active','ended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `user_id`, `start_time`, `end_time`, `duration`, `total_cost`, `pc_number`, `status`, `created_at`) VALUES
(1, 2, '2025-05-20 10:53:41', '2025-05-20 10:54:38', 0, 0.00, 1, 'ended', '2025-05-20 08:53:41'),
(2, 2, '2025-05-20 10:56:41', '2025-05-20 10:56:44', 0, 0.00, 1, 'ended', '2025-05-20 08:56:41'),
(3, 2, '2025-05-20 11:01:51', '2025-05-20 11:08:55', 7, 0.35, 1, 'ended', '2025-05-20 09:01:51'),
(4, 2, '2025-05-20 11:12:29', '2025-05-20 11:20:36', 8, 0.40, 1, 'ended', '2025-05-20 09:12:29'),
(5, 2, '2025-05-20 11:32:33', '2025-05-20 11:36:11', 3, 0.30, 5, 'ended', '2025-05-20 09:32:33'),
(6, 4, '2025-05-20 11:42:23', '2025-05-20 12:05:32', 23, 2.30, 2, 'ended', '2025-05-20 09:42:23');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` enum('admin','customer') NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_type` enum('prepaid','postpaid') DEFAULT 'postpaid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `balance`, `created_at`, `payment_type`) VALUES
(1, 'admin', 'admin123', 'admin', 0.00, '2025-05-20 08:37:02', 'postpaid'),
(2, 'testuser', 'test123', 'customer', 0.00, '2025-05-20 08:52:20', 'postpaid'),
(4, 'prepay1', 'pass123', 'customer', 2.70, '2025-05-20 09:42:10', 'prepaid');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing_rates`
--
ALTER TABLE `billing_rates`
  ADD PRIMARY KEY (`rate_id`);

--
-- Indexes for table `revenue`
--
ALTER TABLE `revenue`
  ADD PRIMARY KEY (`revenue_id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing_rates`
--
ALTER TABLE `billing_rates`
  MODIFY `rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `revenue`
--
ALTER TABLE `revenue`
  MODIFY `revenue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `revenue`
--
ALTER TABLE `revenue`
  ADD CONSTRAINT `revenue_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`);

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
