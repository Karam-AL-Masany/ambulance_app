-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 11, 2024 at 08:23 PM
-- Server version: 5.7.31
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ambulancebooking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  `quantity` varchar(100) NOT NULL,
  `count` int(5) NOT NULL,
  `img` text,
  `date` timestamp NULL DEFAULT NULL,
  `bookingCase` varchar(100) NOT NULL,
  `bookingActive` varchar(100) DEFAULT NULL,
  `userId` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `type`, `quantity`, `count`, `img`, `date`, `bookingCase`, `bookingActive`, `userId`) VALUES
(4, 'Fire', 'Minor', 1, '40341748093a-32f3-4b94-85ab-5e727e55aa02-1847118936.jpg', NULL, 'pending', 'new', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `cnicNum` varchar(100) NOT NULL,
  `fullName` varchar(200) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `pass` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `district` varchar(200) DEFAULT NULL,
  `cnicImg` text,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `cnicNum`, `fullName`, `phone`, `pass`, `address`, `district`, `cnicImg`, `type`) VALUES
(1, 'admin@admin.com', '010106655', 'admin', '+967 777777777', '123', 'sawan', 'Shooob', '22395c865cf5-4afb-4087-a324-4b8961177d3d-298147490.jpg', 'admin'),
(2, 'driver@driver.com', '010105533', 'Ahmed', '+967 777777777', '123', 'Hayeel', 'Azzal', '18562458e037-1c71-4082-828a-2994b7668d6f-1908631434.jpg', 'driver'),
(3, 'kamal@gmail.com', '01010223', 'Kamal', '+967 777777777', '123', 'haddah', 'Azzal', '448673d2d93c-ece2-4ed2-8613-45afdb5688a588296795.jpg', 'person');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `userId_id` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
