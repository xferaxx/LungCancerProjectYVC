-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 22, 2022 at 07:04 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lungcancer`
--

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `exam` (
  `id` int(11) NOT NULL,
  `quesNo` int(11) NOT NULL,
  `rightAns` int(11) NOT NULL,
  `answer` text NOT NULL,
  `img_id` int(11) NOT NULL,
  `imgLevel` varchar(225) NOT NULL,
  `token` text NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `ImgName` text NOT NULL,
  `ImgType` varchar(255) NOT NULL,
  `ImgLevel` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `ImgName`, `ImgType`, `ImgLevel`) VALUES
(1, 'admin/uploads/4.png', 'adenocarcinoma', '1'),
(2, 'admin/uploads/19.png', 'large cell carcinoma', '1'),
(3, 'admin/uploads/13.png', 'normal', '1'),
(4, 'admin/uploads/40.png', 'squamous cell carcinoma', '1'),
(5, 'admin/uploads/23.png', 'squamous cell carcinoma', '2'),
(6, 'admin/uploads/39.png', 'squamous cell carcinoma', '2'),
(7, 'admin/uploads/30.png', 'squamous cell carcinoma', '2'),
(8, 'admin/uploads/47.png', 'normal', '2'),
(9, 'admin/uploads/41.png', 'normal', '3'),
(10, 'admin/uploads/31.png', 'adenocarcinoma', '3'),
(11, 'admin/uploads/3.png', 'normal', '1'),
(12, 'admin/uploads/32.png', 'adenocarcinoma', '1'),
(13, 'admin/uploads/35.png', 'adenocarcinoma', '1'),
(14, 'admin/uploads/000104.png', 'large cell carcinoma', '1'),
(15, 'admin/uploads/10.png', 'normal', '1'),
(16, 'admin/uploads/000145.png', 'adenocarcinoma', '1'),
(17, 'admin/uploads/000031.png', 'large cell carcinoma', '1'),
(18, 'admin/uploads/ad18.png', 'adenocarcinoma', '1'),
(19, 'admin/uploads/2.png', 'normal', '1'),
(20, 'admin/uploads/12.png', 'normal', '1'),
(21, 'admin/uploads/36.png', 'adenocarcinoma', '2'),
(22, 'admin/uploads/32.png', 'adenocarcinoma', '2'),
(23, 'admin/uploads/33.png', 'adenocarcinoma', '2'),
(24, 'admin/uploads/25.png', 'squamous cell carcinoma', '2'),
(25, 'admin/uploads/000169.png', 'large cell carcinoma', '2'),
(26, 'admin/uploads/000105 (2).png', 'large cell carcinoma', '2'),
(27, 'admin/uploads/000055 (4).png', 'large', '2'),
(28, 'admin/uploads/ad7.png', 'adenocarcinoma', '2'),
(29, 'admin/uploads/ad18.png', 'adenocarcinoma', '2'),
(30, 'admin/uploads/000133.png', 'large cell carcinoma', '2'),
(31, 'admin/uploads/000097 (2).png', 'large cell carcinoma', '3'),
(32, 'admin/uploads/000045.png', 'large cell carcinoma', '3'),
(33, 'admin/uploads/000006.png', 'squamous cell carcinoma', '3'),
(34, 'admin/uploads/000104 (2).png', 'squamous cell carcinoma', '3'),
(35, 'admin/uploads/000098 (8).png', 'adenocarcinoma', '3'),
(36, 'admin/uploads/000022.png', 'adenocarcinoma', '3'),
(37, 'admin/uploads/n7.png', 'normal', '3'),
(38, 'admin/uploads/000027 (2).png', 'squamous cell carcinoma', '3'),
(39, 'admin/uploads/000081.png', 'squamous cell carcinoma', '3'),
(40, 'admin/uploads/000122.png', 'squamous cell carcinoma', '3');

-- --------------------------------------------------------

--
-- Table structure for table `img_drawing`
--

CREATE TABLE `img_drawing` (
  `id_d` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `image` text CHARACTER SET utf8 NOT NULL,
  `ImgLevel` varchar(255) CHARACTER SET utf8 NOT NULL,
  `ImgSolution` text CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `img_drawing`
--

INSERT INTO `img_drawing` (`id_d`, `id`, `image`, `ImgLevel`, `ImgSolution`) VALUES
(1, 1, 'admin/uploads/d1.png', '1', 'admin/uploads/s1.png'),
(2, 2, 'admin/uploads/d2.png', '1', 'admin/uploads/s2.png'),
(3, 3, 'admin/uploads/d3.png', '1', 'admin/uploads/s3.png'),
(4, 4, 'admin/uploads/d4.png', '1', 'admin/uploads/s4.png'),
(5, 5, 'admin/uploads/d5.png', '1', 'admin/uploads/s5.png'),
(6, 6, 'admin/uploads/d6.png', '1', 'admin/uploads/s6.png'),
(7, 7, 'admin/uploads/d7.png', '1', 'admin/uploads/s7.png'),
(8, 8, 'admin/uploads/d8.png', '1', 'admin/uploads/s8.png'),
(9, 9, 'admin/uploads/d9.png', '1', 'admin/uploads/s9.png'),
(10, 10, 'admin/uploads/d10.png', '1', 'admin/uploads/s10.png'),
(11, 11, 'admin/uploads/d11.png', '1', 'admin/uploads/s11.png'),
(12, 12, 'admin/uploads/d12.png', '1', 'admin/uploads/s12.png'),
(13, 13, 'admin/uploads/d13.png', '1', 'admin/uploads/s13.png'),
(14, 14, 'admin/uploads/d14.png', '1', 'admin/uploads/s14.png'),
(15, 15, 'admin/uploads/d15.png', '1', 'admin/uploads/s15.png'),
(16, 16, 'admin/uploads/d16.png', '2', 'admin/uploads/s16.png'),
(17, 17, 'admin/uploads/d17.png', '2', 'admin/uploads/s17.png'),
(18, 18, 'admin/uploads/d18.png', '2', 'admin/uploads/s18.png'),
(19, 19, 'admin/uploads/d19.png', '2', 'admin/uploads/s19.png'),
(20, 20, 'admin/uploads/d20.png', '2', 'admin/uploads/s20.png'),
(21, 21, 'admin/uploads/d21.png', '2', 'admin/uploads/s21.png'),
(22, 22, 'admin/uploads/d22.png', '2', 'admin/uploads/s22.png'),
(23, 23, 'admin/uploads/d23.png', '2', 'admin/uploads/s23.png'),
(24, 24, 'admin/uploads/d24.png', '2', 'admin/uploads/s24.png'),
(25, 25, 'admin/uploads/d25.png', '3', 'admin/uploads/s25.png'),
(26, 26, 'admin/uploads/d26.png', '3', 'admin/uploads/s26.png'),
(27, 27, 'admin/uploads/d27.png', '3', 'admin/uploads/s27.png'),
(28, 28, 'admin/uploads/d28.png', '3', 'admin/uploads/s28.png'),
(29, 29, 'admin/uploads/d29.png', '3', 'admin/uploads/s29.png'),
(30, 30, 'admin/uploads/d30.png', '3', 'admin/uploads/s30.png'),
(31, 31, 'admin/uploads/d31.png', '3', 'admin/uploads/s31.png'),
(32, 32, 'admin/uploads/d32.png', '3', 'admin/uploads/s32.png'),
(33, 33, 'admin/uploads/d33.png', '3', 'admin/uploads/s33.png');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `adminId` int(11) NOT NULL,
  `adminUser` varchar(100) NOT NULL,
  `adminPass` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_admin`
--

INSERT INTO `tbl_admin` (`adminId`, `adminUser`, `adminPass`) VALUES
(1, 'admin', 'D00F5D5217896FB7FD601412CB890830'),
(7, 'admin', '21232f297a57a5a743894a0e4a801fc3'),
(6, 'julian', '0192023a7bbd73250516f069df18b500');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ans`
--

CREATE TABLE `tbl_ans` (
  `id` int(11) NOT NULL,
  `quesNo` int(11) NOT NULL,
  `rightAns` int(11) NOT NULL DEFAULT 0,
  `ans` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_ans`
--

INSERT INTO `tbl_ans` (`id`, `quesNo`, `rightAns`, `ans`) VALUES
(1, 1, 1, 'yes'),
(2, 1, 0, 'no'),
(3, 2, 0, '1'),
(4, 2, 1, '2'),
(5, 2, 0, '3'),
(6, 2, 0, '4'),
(7, 3, 0, 'yes'),
(8, 3, 1, 'no'),
(9, 4, 1, 'lower'),
(10, 4, 0, 'upper'),
(11, 5, 0, 'left'),
(12, 5, 1, 'right'),
(13, 6, 1, 'left'),
(14, 6, 0, 'right'),
(15, 7, 1, '1'),
(16, 7, 0, '2'),
(17, 7, 0, '3'),
(18, 7, 0, '4'),
(19, 8, 0, 'yes'),
(20, 8, 1, 'no'),
(21, 9, 1, '0'),
(22, 9, 0, '1'),
(23, 9, 0, '2'),
(24, 9, 0, '3'),
(25, 10, 1, 'adenocarcinoma'),
(26, 10, 0, 'large cell carcinoma'),
(27, 10, 0, 'normal'),
(28, 10, 0, 'squamous cell carcinoma'),
(29, 11, 0, 'yes'),
(30, 11, 1, 'no'),
(31, 12, 0, 'left'),
(32, 12, 1, 'right'),
(33, 13, 0, 'lower'),
(34, 13, 1, 'upper'),
(35, 14, 1, 'yes , 1'),
(36, 14, 0, 'yes , 2'),
(37, 14, 0, 'yes , 3'),
(38, 14, 0, 'no'),
(39, 15, 1, '0'),
(40, 15, 0, '1'),
(41, 15, 0, '2'),
(42, 15, 0, '3'),
(43, 16, 1, 'lower'),
(44, 16, 0, 'upper'),
(45, 17, 0, 'small'),
(46, 17, 1, 'large'),
(47, 18, 1, 'small (adenocarcinoma)'),
(48, 18, 0, 'large (large cell carcinoma)'),
(49, 19, 0, 'yes'),
(50, 19, 1, 'no'),
(51, 20, 1, 'normal'),
(52, 20, 0, 'large (large cell carcinoma)'),
(53, 20, 0, 'small (adenocarcinoma)'),
(54, 20, 0, 'squamous cell carcinoma'),
(55, 21, 0, 'normal'),
(56, 21, 1, 'adenocarcinoma'),
(57, 22, 0, 'left'),
(58, 22, 1, 'right'),
(59, 22, 0, 'non'),
(60, 23, 0, 'lower'),
(61, 23, 0, 'upper'),
(62, 23, 1, 'central'),
(63, 24, 0, 'lower'),
(64, 24, 0, 'upper'),
(65, 24, 1, 'central'),
(66, 25, 0, 'small (adenocarcinoma)'),
(67, 25, 1, 'large (large cell carcinoma)'),
(68, 25, 0, 'normal'),
(69, 26, 1, 'lower'),
(70, 26, 0, 'upper'),
(71, 26, 0, 'central'),
(72, 27, 0, '0'),
(73, 27, 1, '1'),
(74, 27, 0, '2'),
(75, 27, 0, '3'),
(76, 28, 1, 'left , upper'),
(77, 28, 0, 'left , lower'),
(78, 28, 0, 'right , upper'),
(79, 28, 0, 'right , lower'),
(80, 29, 1, 'yes'),
(81, 29, 0, 'no'),
(82, 30, 0, 'small (adenocarcinoma)'),
(83, 30, 1, 'large (large cell carcinoma)'),
(84, 30, 0, 'normal'),
(85, 30, 0, 'squamous cell carcinoma'),
(86, 31, 0, 'small (adenocarcinoma)'),
(87, 31, 1, 'large (large cell carcinoma)'),
(88, 31, 0, 'normal'),
(89, 31, 0, 'squamous cell carcinoma'),
(90, 32, 0, '0'),
(91, 32, 1, '1'),
(92, 32, 0, '2'),
(93, 32, 0, '3'),
(94, 33, 0, 'small (adenocarcinoma)'),
(95, 33, 0, 'large (large cell carcinoma)'),
(96, 33, 0, 'normal'),
(97, 33, 1, 'squamous cell carcinoma'),
(98, 34, 0, 'small (adenocarcinoma)'),
(99, 34, 0, 'large (large cell carcinoma)'),
(100, 34, 0, 'normal'),
(101, 34, 1, 'squamous cell carcinoma'),
(102, 35, 0, 'left , upper'),
(103, 35, 1, 'left , lower'),
(104, 35, 0, 'right , upper'),
(105, 35, 0, 'right , lower'),
(106, 36, 1, 'small (adenocarcinoma)'),
(107, 36, 0, 'large (large cell carcinoma)'),
(108, 36, 0, 'normal'),
(109, 36, 0, 'squamous cell carcinoma'),
(110, 37, 0, 'yes'),
(111, 37, 1, 'no'),
(112, 38, 0, '1'),
(113, 38, 0, '2'),
(114, 38, 1, '3'),
(115, 38, 0, '4'),
(116, 39, 1, 'yes'),
(117, 39, 0, 'no'),
(118, 40, 1, 'left'),
(119, 40, 0, 'right');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ques`
--

CREATE TABLE `tbl_ques` (
  `id` int(11) NOT NULL,
  `quesNo` int(11) NOT NULL,
  `ques` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_ques`
--

INSERT INTO `tbl_ques` (`id`, `quesNo`, `ques`) VALUES
(1, 1, 'is it cancerous?'),
(2, 2, 'how many cancer do you see?'),
(3, 3, 'is it cancerous?'),
(4, 4, 'The cancer in this image in the upper or lower lope? ?'),
(5, 5, 'The cancer in this image in the left or right part of lung? '),
(6, 6, 'The cancer in this image in the left or right part of lung? '),
(7, 7, 'how many cancer do you see?'),
(8, 8, 'is it cancerous?'),
(9, 9, 'how many cancer do you see?'),
(10, 10, 'what is the Biopsy type of the cancer ?'),
(11, 11, 'is it cancerous?'),
(12, 12, 'The cancer in this image in the left or right part of lung? '),
(13, 13, 'The cancer in this image in the upper or lower lope? ?'),
(14, 14, 'is it cancerous? and how many cancer you see if cancerous?'),
(15, 15, 'how many cancer do you see?'),
(16, 16, 'The cancer in this image in the upper or lower lope? ?'),
(17, 17, 'what is the Biopsy type of the cancer ?'),
(18, 18, 'what is the Biopsy type of the cancer ?'),
(19, 19, 'is it cancerous?'),
(20, 20, 'what is the Biopsy type of the cancer ?'),
(21, 21, 'what is the Biopsy type of the cancer ?'),
(22, 22, 'The cancer in this image in the left or right part of lung? '),
(23, 23, 'The cancer in this image in the upper or central or lower lope?'),
(24, 24, 'The cancer in this image in the upper or central or lower lope?'),
(25, 25, 'what is the Biopsy type of the cancer ?'),
(26, 26, 'The cancer in this image in the upper or central or lower lope?'),
(27, 27, 'if the Lung cancerous how many do you see?'),
(28, 28, 'The cancer in this image in the left or right part lower or upper? '),
(29, 29, 'is it cancerous?'),
(30, 30, 'what is the Biopsy type of the cancer ?'),
(31, 31, 'what is the Biopsy type of the cancer ?'),
(32, 32, 'how many cancer do you see?'),
(33, 33, 'what is the Biopsy type of the cancer ?'),
(34, 34, 'what is the Biopsy type of the cancer ?'),
(35, 35, 'The cancer in this image in the left or right part lower or upper? '),
(36, 36, 'what is the Biopsy type of the cancer ?'),
(37, 37, 'is it cancerous?'),
(38, 38, 'how many cancer do you see?'),
(39, 39, 'is it cancerous?'),
(40, 40, 'The cancer in this image in the left or right part of lung? ');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `userId` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `userName` varchar(32) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(32) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`userId`, `name`, `userName`, `password`, `email`, `status`) VALUES
(1, 'Julian Kshebon', 'julian', '25d55ad283aa400af464c76d713c07ad', 'julian@gmail.com', 0),
(4, 'Mahdi Zoabi', 'mahdi', '25d55ad283aa400af464c76d713c07ad', 'mahdi@gmail.com', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `img_drawing`
--
ALTER TABLE `img_drawing`
  ADD PRIMARY KEY (`id_d`);

--
-- Indexes for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`adminId`);

--
-- Indexes for table `tbl_ans`
--
ALTER TABLE `tbl_ans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_ques`
--
ALTER TABLE `tbl_ques`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exam`
--
ALTER TABLE `exam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `img_drawing`
--
ALTER TABLE `img_drawing`
  MODIFY `id_d` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `adminId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_ans`
--
ALTER TABLE `tbl_ans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `tbl_ques`
--
ALTER TABLE `tbl_ques`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
