-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2024 at 05:19 PM
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
-- Database: `logistrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  `quantity` int(11) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `description`, `quantity`, `image`) VALUES
(1, 'Laptop', 'Laptop dengan spesifikasi tinggi', 10, 'https://carisinyal.com/wp-content/uploads/2023/07/advan-stylus-360_.webp'),
(2, 'Proyektor', 'Proyektor HD untuk presentasi', 5, 'https://alatsmk.com/storage/products/1/Desain%20Interior%20dan%20Teknik%20Furnitur/lcdproyektor.jpg'),
(3, 'Speaker', 'Speaker aktif dengan suara jernih', 8, 'https://resource.logitech.com/w_692,c_lpad,ar_4:3,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/da'),
(4, 'Whiteboard', 'Whiteboard dengan spidol', 3, 'https://www.officestock.com.au/assets/full/W1812.jpg?20230508201620'),
(5, 'LCD Projector', 'LCD Projector untuk presentasi besar', 2, 'https://2.bp.blogspot.com/-rZiWFuH-56g/Vd-_3Cr_-XI/AAAAAAAAATE/7aM6Hpkh4I0/s1600/paket%2Blcd%2Bcopy.'),
(6, 'Microphone', 'Microphone dengan kualitas tinggi', 6, 'https://cdn1.productnation.co/stg/sites/5/5efee8c454bd3.png'),
(7, 'Chairs', 'Kursi lipat untuk acara', 50, 'https://suburfurniture.com/wp-content/uploads/2018/11/Uno-Kursi-Texas.jpg'),
(8, 'Tables', 'Meja lipat untuk acara', 20, 'https://jeimart-indonesia.com/wp-content/uploads/2022/03/produsen-dan-distributor-meja-lipat-kaki-be'),
(9, 'Scoreboard', 'Scoreboard untuk pertandingan', 1, 'https://i.ebayimg.com/images/g/56MAAOSwujNj7uuJ/s-l1200.webp'),
(10, 'Sports Equipment', 'Perlengkapan olahraga', 30, 'https://static.vecteezy.com/system/resources/previews/023/477/419/non_2x/ai-generative-collection-of'),
(11, 'Komputer', 'Perangkat Komputer', 30, 'https://www.lifewire.com/thmb/WZdlwJIGSRA9Bkk7tKIj9Mgg-lk=/1500x0/filters:no_upscale():max_bytes(150');

-- --------------------------------------------------------

--
-- Table structure for table `loanrequest`
--

CREATE TABLE `loanrequest` (
  `id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `event_name` varchar(50) NOT NULL,
  `equipment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `room` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`room`)),
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(25) NOT NULL,
  `reason` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `loanrequest`
--

INSERT INTO `loanrequest` (`id`, `user_name`, `event_name`, `equipment`, `room`, `start_date`, `end_date`, `status`, `reason`) VALUES
(1, 'John Doe', 'Seminar Teknologi', '[ { \"id\": \"001\", \"jumlah\": 5 }, { \"id\": \"002\", \"jumlah\": 2 } ]', '[\"101\",\"102\"]', '2023-01-01', '2023-01-02', 'Ditolak', 'Peminjaman untuk seminar teknologi'),
(2, 'Jane Smith', 'Workshop Seni', '[ { \"id\": \"003\", \"jumlah\": 10 }, { \"id\": \"004\", \"jumlah\": 1 } ]', '[\"103\"]', '2023-02-01', '2023-02-03', 'Diajukan', 'Peminjaman untuk workshop seni'),
(3, 'Bob Johnson', 'Rapat Koordinasi', '[ { \"id\": \"005\", \"jumlah\": 3 }, { \"id\": \"006\", \"jumlah\": 1 } ]', '[\"102\"]', '2023-03-01', '2023-03-02', 'Ditolak', 'Peminjaman untuk rapat koordinasi'),
(4, 'Eva Garcia', 'Acara Musik', '[ { \"id\": \"007\", \"jumlah\": 8 }, { \"id\": \"008\", \"jumlah\": 2 } ]', '[\"105\"]', '2023-04-01', '2023-04-02', 'Diajukan', 'Peminjaman untuk acara musik'),
(5, 'Chris Williams', 'Diskusi Komunitas', '[ { \"id\": \"009\", \"jumlah\": 15 }, { \"id\": \"010\", \"jumlah\": 5 } ]', '[\"109\"]', '2023-05-01', '2023-05-02', 'Disetujui', 'Peminjaman untuk diskusi komunitas'),
(6, 'David Lee', 'Pertandingan Olahraga', '[ { \"id\": \"011\", \"jumlah\": 2 }, { \"id\": \"012\", \"jumlah\": 10 } ]', '[\"107\"]', '2023-06-01', '2023-06-02', 'Selesai', 'Peminjaman untuk pertandingan olahraga'),
(7, 'Grace Miller', 'Sosialisasi Kesehatan', '[ { \"id\": \"013\", \"jumlah\": 50 }, { \"id\": \"014\", \"jumlah\": 1 } ]', '[\"108\"]', '2023-07-01', '2023-07-02', 'Ditolak', 'Peminjaman untuk sosialisasi kesehatan'),
(8, 'Henry Clark', 'Ujian Online', '[ { \"id\": \"015\", \"jumlah\": 30 }, { \"id\": \"016\", \"jumlah\": 3 } ]', '[\"109\"]', '2023-08-01', '2023-08-02', 'Diajukan', 'Peminjaman untuk ujian online'),
(9, 'Olivia Turner', 'Seminar Keuangan', '[ { \"id\": \"017\", \"jumlah\": 1 }, { \"id\": \"018\", \"jumlah\": 5 } ]', '[\"110\"]', '2023-09-01', '2023-09-02', 'Disetujui', 'Peminjaman untuk seminar keuangan'),
(10, 'Samuel White', 'Pertunjukan Teater', '[ { \"id\": \"019\", \"jumlah\": 1 }, { \"id\": \"020\", \"jumlah\": 15 } ]', '[\"111\"]', '2023-10-01', '2023-10-02', 'Selesai', 'Peminjaman untuk pertunjukan teater');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  `capacity` int(11) NOT NULL,
  `image` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `name`, `description`, `capacity`, `image`) VALUES
(1, 'Aula Utama', 'Aula dengan panggung dan sound system lengkap', 100, 'https://bpsdm.kaltimprov.go.id/apps/reservasi/storage/files/galeri/pfyQgCUtnbB2lzy4jtPJwwGzCMtgN326JLb58uLQ.jpeg'),
(2, 'Ruang Meeting', 'Ruang pertemuan dengan meja bundar', 20, 'https://ifcjakarta.co.id/blog/uploads/berita/20230816153735_bg_ruang_meeting_kantor_(1).jpg'),
(3, 'Studio Seni', 'Studio untuk kegiatan seni', 30, 'https://media.istockphoto.com/id/1304287268/id/foto/studio-seniman-sukses.jpg?s=612x612&w=0&k=20&c=nx0fM54HLOywfty7DTmWoLZgI6OkyH1fTppJ-QuQpmY='),
(4, 'Ruang Pelatihan', 'Ruang untuk pelatihan dan workshop', 40, 'https://www.sabretn.co.id/wp-content/uploads/2016/04/WhatsApp-Image-2018-04-23-at-5.01.10-PM-1024x768.jpeg'),
(5, 'Auditorium', 'Auditorium dengan kursi teater', 150, 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Wien_-_Staatsoper%2C_Zuschauerraum_mit_B%C3%BChne.JPG'),
(6, 'Ruang Rapat', 'Ruang pertemuan formal', 15, 'https://arsitagx-master.s3.ap-southeast-1.amazonaws.com/img_medium/2183/1260/7871/photo-conference-room-view-2nd-floor-ajn-desain-arsitek-oleh-rieska-achmad.jpeg'),
(7, 'Community Center', 'Pusat kegiatan komunitas', 50, 'https://cdn.palmcoastgov.com/pcg/images/depts/recreation/parks/community-center/main-page.jpg'),
(8, 'Computer Lab', 'Laboratorium komputer dengan perangkat lengkap', 25, 'https://www.iq.harvard.edu/sites/projects.iq.harvard.edu/files/styles/os_files_xlarge/public/harvard-iqss/files/img_0338.jpeg?m=1585165451&itok=V7MO9V-b'),
(9, 'Ruang Seminar', 'Ruang untuk seminar dan presentasi', 50, 'https://ft.upnjatim.ac.id/images/seminar.jpeg'),
(10, 'Teater', 'Teater dengan panggung dan tempat duduk', 80, 'https://www.museumnasional.or.id/wp-content/uploads/2022/12/teater-1024x576.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `nama` varchar(50) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(25) NOT NULL,
  `nomor_induk` int(15) NOT NULL,
  `status` varchar(50) NOT NULL,
  `verif` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`nama`, `email`, `password`, `nomor_induk`, `status`, `verif`) VALUES
('Evan Hadi Sukuriyanto', '', '12345', 1203210016, 'Mahasiswa', 'INFORMATIK'),
('Gojo satoru', '', '12345', 1203210001, 'Mahasiswa', 'INFORMATIKA'),
('Hansen', '', '0', 1009452279, 'Dosen', 'Informatika'),
('Jupyter', '', 'jup123', 1203210018, 'Dosen', 'INFORMATIKA'),
('Fern', '', 'fern123', 1203210009, 'Mahasiswa', 'Sains Data'),
('John Doe', 'john.doe@example.com', 'password123', 123456, 'Dosen', 'Siapa nama ibu kandung Anda?.Jane Doe'),
('Jane Smith', 'jane.smith@example.com', 'pass456', 789012, 'Mahasiswa', 'Apa nama hewan peliharaan Anda?.Fluffy'),
('Bob Johnson', 'bob.johnson@example.com', 'pass789', 567890, 'Staff', 'Di kota manakah Anda lahir?.New York'),
('Alice Brown', 'alice.brown@example.com', 'pass321', 234567, 'Mahasiswa', 'Apa warna favorit Anda?.Blue');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loanrequest`
--
ALTER TABLE `loanrequest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `loanrequest`
--
ALTER TABLE `loanrequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
