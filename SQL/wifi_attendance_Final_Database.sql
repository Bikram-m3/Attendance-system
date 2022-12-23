-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 24, 2022 at 06:27 PM
-- Server version: 10.2.44-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `darksoul_wifi`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_crid`
--

CREATE TABLE `app_crid` (
  `API_KEY` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_crid`
--

INSERT INTO `app_crid` (`API_KEY`) VALUES
('171221-171400-171401');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `username` varchar(50) NOT NULL,
  `teacherID` varchar(50) NOT NULL,
  `attend` int(1) NOT NULL,
  `sem` int(1) NOT NULL,
  `sub` varchar(100) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `day` int(2) NOT NULL,
  `depart` varchar(10) NOT NULL,
  `shift` varchar(20) NOT NULL,
  `AUID` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`username`, `teacherID`, `attend`, `sem`, `sub`, `year`, `month`, `day`, `depart`, `shift`, `AUID`) VALUES
('171221_m', '171222_t', 1, 1, 'C', 2022, 8, 12, 'BECE', 'Morning', '9b0845f1-75ef-4b4e-9636-433baebd7805'),
('171221_m', '171222_t', 1, 1, 'C', 2022, 9, 24, 'BECE', 'Morning', 'b18af8dd-4485-4762-aaf6-a586f141b577'),
('171221_m', '171222_t', 1, 1, 'C', 2022, 9, 12, 'BECE', 'Morning', '8dc4d00b-bf4c-4340-b558-c039e9a16c91'),
('171221_m', '171222_t', 1, 1, 'C', 2022, 9, 23, 'BECE', 'Morning', '042f51e3-3d9e-45bb-ba3c-332cb0b4e4f3'),
('171200_m', '171222_t', 1, 1, 'C', 2022, 9, 12, 'BECE', 'Morning', '8dc4d00b-bf4c-4340-b558-c039e9a16c91');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `faculty` varchar(50) NOT NULL,
  `sem` int(1) NOT NULL,
  `subject` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`faculty`, `sem`, `subject`) VALUES
('BECE', 2, 'c++'),
('BECE', 3, 'LC'),
('BECIVIL', 1, 'CT'),
('BECE', 1, 'PT'),
('BECE', 1, 'CHEMISTRY'),
('BECE', 1, 'MATH-1'),
('BECE', 8, 'IS'),
('BECE', 8, 'SPIT'),
('BECE', 2, 'MATH-2'),
('BECE', 3, 'MATH-3'),
('BECE', 4, 'MATH-4'),
('BECE', 1, 'C');

-- --------------------------------------------------------

--
-- Table structure for table `detail`
--

CREATE TABLE `detail` (
  `username` varchar(50) NOT NULL,
  `faculty` varchar(50) NOT NULL,
  `shift` varchar(50) NOT NULL,
  `Batch` varchar(10) NOT NULL,
  `sem` varchar(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail`
--

INSERT INTO `detail` (`username`, `faculty`, `shift`, `Batch`, `sem`) VALUES
('171221_m', 'BECE', 'Morning', '2017', '1'),
('171200_m', 'BECE', 'Morning', '2017', '1'),
('181221_m', 'BECIVIL', 'Morning', '2018', '1');

-- --------------------------------------------------------

--
-- Table structure for table `dipartment`
--

CREATE TABLE `dipartment` (
  `dipart` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dipartment`
--

INSERT INTO `dipartment` (`dipart`) VALUES
('BECE'),
('BEIT'),
('BECIVIL');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `roll` int(50) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `role` int(11) NOT NULL,
  `uid` varchar(150) NOT NULL,
  `encrypted_password` varchar(300) NOT NULL,
  `salt_password` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`name`, `username`, `roll`, `phone`, `role`, `uid`, `encrypted_password`, `salt_password`) VALUES
('Nitesh Mandal', '171221_m', 171221, '9810400649', 0, 'b210eb77-ab39-45d9-a43e-81b9fb874b02', 'd32e6d6e7205989d3a954aa5ffaaa826f90e7b948aa3975bda0b39d4205cc70547094b0ff22f75c6c17f4cec089fdae132d65a42c67694c89c6b73be2756fb3c', 'a098867adcdde457'),
('Dark Soul', '171222_t', 171222, '9810400649', 1, 'b210eb77-ab39-45d9-a43e-81b9fb874b02', 'e745b70f975675e4b00575bbf751da3270b1951048b751f7c650e48591eeb560ff33784df472c9c9b85ca6b3e20bbb76a0ecb78930408772f93b81ba130c997c', '20b29282e82c7930'),
('Nitesh Test', '171223_t', 171223, '9810400649', 1, 'e2fbcd72-dad5-43af-a937-41caa52698ee', '42baf6e8b57cd33addc42276bf409cc453c6c87013af949cefcdc9524f7ce3c68e265c495bd132f0e786e5c55fb719981d316b3041c95afd25a2478c61fae7b9', '104932c5a01766a1'),
('Bikram Mandal', '171200_m', 171200, '9809650354', 0, 'b210eb77-ab39-45d9-a43e-81b9fb874b02', '2b00e17554c0f25ed2ea1deda4ce4e3ee4fafd979cb1aa7b75eebc8e01b2ea749cdae706b1ab8317016a4a95ef56ff84fb88e0a9dd0f64353124e3bd351d62c6', 'aadd67eef21d22e7'),
('Darko Baba', '171000_a', 171000, '9810400649', 2, '7ca019ef-26bd-4a4c-86a1-47b2aa3b0c0a', '3359b2f1266567447a4ed8a277ace97a3755a0c713327a26dc1540b02b9fb93d2486658197f27d42572a662b74453b66d966c77c9395be434da9d1f9ce4b1935', '93a8b6e970d0c94a'),
('Test Test', '181221_m', 181221, '9809650354', 0, '8861af3f-654d-4b98-a92a-92e0119ec678', '40be0eeed4ec188a66bb3f7cfe15f03ee79ac6c35e8455b3984936e827884934de975e9cadd79a5cb2da717d7bbcaacc6957f894569d12080d21d3eb8ff362c6', '2e2a0af109f6c187'),
('NCIT', '123456_a', 123456, '9823735342', 2, 'e4ed8a9e-7c4d-466c-be9b-e0527424475a', 'd6056e605506ffcc9b1fd21b06caf5385a0f42ad94f129443cabfcf4507350085a0c768dc1d629c2c2ecf986eb0616cb244bea782bc4349258c2cf8e91c71c6d', '4daf9b47b8f0be65');

-- --------------------------------------------------------

--
-- Table structure for table `teacherAttend`
--

CREATE TABLE `teacherAttend` (
  `AUID` varchar(150) NOT NULL,
  `teacherID` varchar(50) NOT NULL,
  `sem` int(1) NOT NULL,
  `sub` varchar(50) NOT NULL,
  `depart` varchar(50) NOT NULL,
  `shift` varchar(10) NOT NULL,
  `batch` varchar(4) NOT NULL,
  `day` int(2) NOT NULL,
  `month` int(2) NOT NULL,
  `year` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacherAttend`
--

INSERT INTO `teacherAttend` (`AUID`, `teacherID`, `sem`, `sub`, `depart`, `shift`, `batch`, `day`, `month`, `year`) VALUES
('042f51e3-3d9e-45bb-ba3c-332cb0b4e4f3', '171222_t', 1, 'C', 'BECE', 'Morning', '2017', 23, 9, 2022),
('8dc4d00b-bf4c-4340-b558-c039e9a16c91', '171222_t', 1, 'C', 'BECE', 'Morning', '2017', 12, 9, 2022),
('9b0845f1-75ef-4b4e-9636-433baebd7805', '171222_t', 1, 'C', 'BECE', 'Morning', '2017', 12, 8, 2022),
('b18af8dd-4485-4762-aaf6-a586f141b577', '171222_t', 1, 'C', 'BECE', 'Morning', '2017', 24, 9, 2022);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD KEY `username` (`username`),
  ADD KEY `teacherID` (`teacherID`),
  ADD KEY `AUID` (`AUID`);

--
-- Indexes for table `detail`
--
ALTER TABLE `detail`
  ADD KEY `username` (`username`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `teacherAttend`
--
ALTER TABLE `teacherAttend`
  ADD PRIMARY KEY (`AUID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
