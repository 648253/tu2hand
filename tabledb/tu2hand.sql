-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2021 at 02:45 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tu2hand`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `idBuyer` text COLLATE utf8_unicode_ci NOT NULL,
  `idSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `idPd` text COLLATE utf8_unicode_ci NOT NULL,
  `nameSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `namePd` text COLLATE utf8_unicode_ci NOT NULL,
  `pricePd` text COLLATE utf8_unicode_ci NOT NULL,
  `amountPd` text COLLATE utf8_unicode_ci NOT NULL,
  `sumPd` text COLLATE utf8_unicode_ci NOT NULL,
  `imgPd` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderbuyer`
--

CREATE TABLE `orderbuyer` (
  `id` int(11) NOT NULL,
  `idSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `idPd` text COLLATE utf8_unicode_ci NOT NULL,
  `nameShop` text COLLATE utf8_unicode_ci NOT NULL,
  `namePd` text COLLATE utf8_unicode_ci NOT NULL,
  `pricePd` text COLLATE utf8_unicode_ci NOT NULL,
  `amountPd` text COLLATE utf8_unicode_ci NOT NULL,
  `sumPd` text COLLATE utf8_unicode_ci NOT NULL,
  `idBuyer` text COLLATE utf8_unicode_ci NOT NULL,
  `nameBuyer` text COLLATE utf8_unicode_ci NOT NULL,
  `addressBuyer` text COLLATE utf8_unicode_ci NOT NULL,
  `phoneBuyer` text COLLATE utf8_unicode_ci NOT NULL,
  `dateTime` text COLLATE utf8_unicode_ci NOT NULL,
  `status` text COLLATE utf8_unicode_ci NOT NULL,
  `imgPd` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orderbuyer`
--

INSERT INTO `orderbuyer` (`id`, `idSeller`, `idPd`, `nameShop`, `namePd`, `pricePd`, `amountPd`, `sumPd`, `idBuyer`, `nameBuyer`, `addressBuyer`, `phoneBuyer`, `dateTime`, `status`, `imgPd`) VALUES
(1, '1', '1', 'สอบจบ0', 'หูฟังบลูทูธ AKG', '1900', '1', '1900', '4', 'สอบจบ3', '99 ถนนเลนกลาง ตำบลไทรม้า อำเภอเมือง จังหวัดเชียงใหม่ 93221', '0612019351', '2021-12-14 01:23', 'เตรียมสินค้า', '/tu2hand/pdImg/pd_144521.jpg'),
(2, '2', '6', 'สอบจบ1', 'ลูกกลิ้งบริหารซิกแพค', '120', '1', '120', '4', 'สอบจบ3', '99 ถนนเลนกลาง ตำบลไทรม้า อำเภอเมือง จังหวัดเชียงใหม่ 93221', '0612019351', '2021-12-14 01:23', 'เตรียมสินค้า', '/tu2hand/pdImg/pd_398527.jpg'),
(3, '3', '5', 'สอบจบ2', 'รองเท้าบาส peak', '2300', '1', '2300', '4', 'สอบจบ3', '99 ถนนเลนกลาง ตำบลไทรม้า อำเภอเมือง จังหวัดเชียงใหม่ 93221', '0612019351', '2021-12-14 01:23', 'แพ็คสินค้า', '/tu2hand/pdImg/pd_715917.jpg'),
(4, '5', '8', 'finalexamEdit', 'กระเป๋าเงินหนังแท้E', '1200', '1', '1200', '4', 'สอบจบ3', '99 ถนนเลนกลาง ตำบลไทรม้า อำเภอเมือง จังหวัดเชียงใหม่ 93221', '0612019351', '2021-12-14 17:02', 'แพ็คสินค้า', '/tu2hand/pdImg/pd_967327.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `idSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `nameSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `namePd` text COLLATE utf8_unicode_ci NOT NULL,
  `pricePd` text COLLATE utf8_unicode_ci NOT NULL,
  `detailPd` text COLLATE utf8_unicode_ci NOT NULL,
  `imagesPd` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `idSeller`, `nameSeller`, `namePd`, `pricePd`, `detailPd`, `imagesPd`) VALUES
(1, '1', 'สอบจบ0', 'หูฟังบลูทูธ AKG', '1900', 'มีตำหนิ หูฟังเสียงออกข้างเดียว เเต่เสียงยังดี ฟังได้เเต่ไม่ดัง มีระบบตัดเสียงรบกวนใช้ได้บ้างไม่ได้บ้าง', '[/pdImg/pd_144521.jpg, /pdImg/pd_215480.jpg, /pdImg/pd_490357.jpg, /pdImg/pd_222782.jpg]'),
(2, '1', 'สอบจบ0', 'เสื้อรักบี้', '500', 'เสื้อไซส์ L รอบอก22 ตะเข็บเดี่ยวทั้งตัว made in USA ราคาออกห่าง 2000 บาท', '[/pdImg/pd_718458.jpg, /pdImg/pd_250570.jpg, /pdImg/pd_659419.jpg, /pdImg/pd_490435.jpg]'),
(3, '1', 'สอบจบ0', 'ไม้แบด Yonex yz2110', '990', 'ไม้แบดอย่างดี มีตำหนิเอ็นขาดหนึ่งเส้น เหมาะสำหรับสายตบ ', '[/pdImg/pd_600791.jpg, /pdImg/pd_941916.jpg, /pdImg/pd_325683.jpg, /pdImg/pd_102795.jpg]'),
(4, '3', 'สอบจบ2', 'ลูกบาส Spalding', '1200', 'มีตำหนิ รอยรั่วหนึ่งจุด เล่นได้เเต่ไม่นานต้องสูบลมใหม่ เล่นไม่กี่ครั้ง ใหม่แกะกล่อง', '[/pdImg/pd_322719.jpg, /pdImg/pd_592324.jpg, /pdImg/pd_792796.jpg, /pdImg/pd_704043.jpg]'),
(5, '3', 'สอบจบ2', 'รองเท้าบาส peak', '2300', 'ตำหนิมีรอยการซ่อมพื้นหนึ่งจุดให้เห็น แต่สามารถใส่ได้ ไซส์ 42 เหมาะสำหรับสายลุย', '[/pdImg/pd_715917.jpg, /pdImg/pd_374282.jpg, /pdImg/pd_967466.jpg, /pdImg/pd_18865.jpg]'),
(6, '2', 'สอบจบ1', 'ลูกกลิ้งบริหารซิกแพค', '120', 'ลูกกลิ้งบริหารซิกแพค กล้ามหน้าท้องเรียวสวยงาม มีสัดส่วน เล่นได้สองสามวันเลิก ตอนนี้นอนกล่อง', '[/pdImg/pd_398527.jpg, /pdImg/pd_520.jpg, /pdImg/pd_93106.jpg, /pdImg/pd_620858.jpg]'),
(7, '2', 'สอบจบ1', 'คีย์บอร์ดเรืองแสง', '2500', 'มีตำหนิ มีปุ่มไม่ครบเเต่กดได้ทุกปุ่ม ไฟสว่างมาก เหมาะสำหรับการเล่นเกมมาก', '[/pdImg/pd_572647.jpg, /pdImg/pd_168535.jpg, /pdImg/pd_364692.jpg, /pdImg/pd_564898.jpg]'),
(8, '5', 'finalexam', 'กระเป๋าเงินหนังแท้E', '1200', 'มีตำหนิสองจุด ไม่เห็นชัด สภาพออกจากกล่อง', '[/pdImg/pd_967327.jpg, /pdImg/pd_733636.jpg, /pdImg/pd_736250.jpg, /pdImg/pd_466137.jpg]');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `type` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `user` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `img` text COLLATE utf8_unicode_ci NOT NULL,
  `lat` text COLLATE utf8_unicode_ci NOT NULL,
  `long` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `type`, `address`, `phone`, `user`, `password`, `img`, `lat`, `long`) VALUES
(1, 'สอบจบ0', 'seller', '99 ถนนกรุงไทย ตำบลสายพาน อำเภอเชียงของ จังหวัดตรัง 94110', '0612019351', 'test0', '7afzTJd2vrGUeKQSlIImgQ==', '/tu2hand/userImg/profile_55785.jpg', '14.0737248', '100.6003165'),
(2, 'สอบจบ1', 'seller', '98 ถนนพญาไท ตำบลกรุงศรี อำเภอคง จังหวัดเชียงใหม่ 12120', '0612019352', 'test2', '7afzTJd2vrGUeKQSlIImgQ==', '/tu2hand/userImg/edit74profile_38985.jpg', '14.0737243', '100.60032180000002'),
(3, 'สอบจบ2', 'seller', '97 ถนนนางน้ำ ตำบลนางไทย อำเภอจอม จังหวัดขอนแก่น 81221', '0612019353', 'test1', '7afzTJd2vrGUeKQSlIImgQ==', '/tu2hand/userImg/profile_20223.jpg', '14.0737248', '100.6003165'),
(4, 'สอบจบ3', 'buyer', '99 ถนนเลนกลาง ตำบลไทรม้า อำเภอเมือง จังหวัดเชียงใหม่ 93221', '0612019351', 'buyer', '7afzTJd2vrGUeKQSlIImgQ==', '/tu2hand/userImg/profile_1173.jpg', '14.0737481', '100.6003502'),
(5, 'finalexamEdit', 'seller', '99 ถนนธงชัย อำเภอหาดใหญ่ 99120', '0612019351', 'test9', '7afzTJd2vrGUeKQSlIImgQ==', '/tu2hand/userImg/profile_76308.jpg', '14.0737264', '100.60031570000001');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderbuyer`
--
ALTER TABLE `orderbuyer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orderbuyer`
--
ALTER TABLE `orderbuyer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
