-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 26, 2025 at 11:20 AM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `name`, `description`, `price`, `category`, `image_url`, `is_available`, `created_at`) VALUES
(1, 'كباب عراقي', 'سيخين من الكباب البلدي الطري، يُقدم مع الطماطم المشوية والخبز', '3000.00', 'مشاوي', 'https://i.redd.it/78yncu0a75a81.jpg', 1, '2025-04-24 03:16:23'),
(2, 'لف فلافل', 'قرصين فلافل مقرمشة داخل خبز صاج مع طماطم ومخللات', '500.00', 'ساندويتشات', 'https://images.deliveryhero.io/image/talabat/Menuitems/Falafl_Abu_Ali_Mix_Falafe638472232784214365.jpg?width=172&amp;amp;height=172', 1, '2025-04-24 03:17:14');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `status` enum('preparing','ready','delivered','paid') COLLATE utf8mb4_unicode_ci DEFAULT 'preparing',
  `total_amount` decimal(10,2) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `table_number`, `status`, `total_amount`, `notes`, `created_by`, `created_at`) VALUES
(1, 4, 'paid', '1500.00', '', 4, '2025-04-24 03:25:33'),
(2, 1, 'paid', '2000.00', '', 4, '2025-04-25 23:48:09'),
(3, 9, 'paid', '12000.00', '', 4, '2025-04-25 23:48:56');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `menu_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `menu_item_id`, `quantity`, `price`, `notes`) VALUES
(1, 1, 2, 3, '500.00', ''),
(2, 2, 2, 4, '500.00', ''),
(3, 3, 1, 2, '6000.00', '');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method` enum('cash','bank_transfer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT '0.00',
  `paid_amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `processed_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `payment_method`, `total_price`, `discount`, `paid_amount`, `payment_status`, `processed_by`, `created_at`) VALUES
(1, 1, 'cash', '1500.00', '0.00', '1500.00', 'completed', 3, '2025-04-24 03:49:26'),
(2, 2, 'cash', '2000.00', '0.00', '2000.00', 'completed', 3, '2025-04-25 23:50:53'),
(3, 3, 'bank_transfer', '12000.00', '4000.00', '8000.00', 'completed', 3, '2025-04-25 23:51:34');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','in_progress','closed') COLLATE utf8mb4_unicode_ci DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `subject`, `message`, `status`, `created_at`) VALUES
(1, 4, 'Some ', 'thing not working', 'open', '2025-04-24 03:01:00');

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `log_type` enum('info','warning','error','security') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_logs`
--

INSERT INTO `system_logs` (`id`, `user_id`, `log_type`, `message`, `context`, `ip_address`, `created_at`) VALUES
(1, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-25 23:41:48'),
(2, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-25 23:44:16'),
(3, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-25 23:44:30'),
(4, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-25 23:45:00'),
(5, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-25 23:45:11'),
(6, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-25 23:45:29'),
(7, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-25 23:45:38'),
(8, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-25 23:46:01'),
(9, 4, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"4\",\"username\":\"order_handler\",\"role\":\"order_handler\"}', '::1', '2025-04-25 23:46:03'),
(10, 4, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"4\",\"role\":\"order_handler\"}', '::1', '2025-04-25 23:46:06'),
(11, 3, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"3\",\"username\":\"cashier\",\"role\":\"cashier\"}', '::1', '2025-04-25 23:46:08'),
(12, 3, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"3\",\"role\":\"cashier\"}', '::1', '2025-04-25 23:46:10'),
(13, 5, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"5\",\"username\":\"chef\",\"role\":\"chef\"}', '::1', '2025-04-25 23:46:12'),
(14, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:46:16'),
(15, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:47:44'),
(16, 5, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:47:51'),
(17, 4, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"4\",\"username\":\"order_handler\",\"role\":\"order_handler\"}', '::1', '2025-04-25 23:47:55'),
(18, 4, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"4\",\"role\":\"order_handler\"}', '::1', '2025-04-25 23:49:15'),
(19, 5, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"5\",\"username\":\"chef\",\"role\":\"chef\"}', '::1', '2025-04-25 23:49:20'),
(20, 5, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:49:30'),
(21, 4, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"4\",\"username\":\"order_handler\",\"role\":\"order_handler\"}', '::1', '2025-04-25 23:49:32'),
(22, 4, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"4\",\"role\":\"order_handler\"}', '::1', '2025-04-25 23:50:15'),
(23, 3, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"3\",\"username\":\"cashier\",\"role\":\"cashier\"}', '::1', '2025-04-25 23:50:17'),
(24, 3, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"3\",\"role\":\"cashier\"}', '::1', '2025-04-25 23:51:48'),
(25, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-25 23:51:53'),
(26, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-25 23:52:20'),
(27, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-25 23:54:16'),
(28, 5, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"5\",\"username\":\"chef\",\"role\":\"chef\"}', '::1', '2025-04-25 23:56:14'),
(29, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:56:24'),
(30, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:56:30'),
(31, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:56:32'),
(32, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:56:32'),
(33, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-25 23:56:33'),
(34, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 00:01:48'),
(35, 5, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"5\",\"username\":\"chef\",\"role\":\"chef\"}', '::1', '2025-04-26 00:01:50'),
(36, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:01:52'),
(37, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:01:58'),
(38, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:01:59'),
(39, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:02:45'),
(40, 5, 'info', 'تم الوصول إلى صفحة تقدير وقت التحضير', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:02:47'),
(41, 5, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:04:33'),
(42, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 00:04:35'),
(43, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 00:04:58'),
(44, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"info\"}', '::1', '2025-04-26 00:05:35'),
(45, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"warning\"}', '::1', '2025-04-26 00:05:36'),
(46, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"error\"}', '::1', '2025-04-26 00:05:39'),
(47, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"security\"}', '::1', '2025-04-26 00:05:40'),
(48, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 00:05:41'),
(49, 5, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 00:15:50'),
(50, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 00:15:52'),
(51, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 00:22:06'),
(52, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 00:22:08'),
(53, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 00:53:22'),
(54, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 00:53:23'),
(55, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 00:53:26'),
(56, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 00:59:35'),
(57, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 01:06:19'),
(58, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 01:06:22'),
(59, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 01:27:51'),
(60, 3, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"3\",\"username\":\"cashier\",\"role\":\"cashier\"}', '::1', '2025-04-26 01:28:05'),
(61, 3, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"3\",\"role\":\"cashier\"}', '::1', '2025-04-26 01:28:27'),
(62, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 02:09:37'),
(63, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"warning\"}', '::1', '2025-04-26 02:09:45'),
(64, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"error\"}', '::1', '2025-04-26 02:09:47'),
(65, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":\"security\"}', '::1', '2025-04-26 02:09:48'),
(66, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 02:09:50'),
(67, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 02:50:40'),
(68, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 02:56:44'),
(69, 1, 'info', 'تم تحديث إعدادات النظام', '{\"user_id\":\"1\",\"settings\":{\"site_name\":\"نظام إدارة المطعم\",\"currency_symbol\":\"د.ع\",\"developer_name\":\"قيدار احمد\",\"default_language\":\"ar\",\"enable_dark_mode\":0,\"enable_notifications\":1,\"enable_logging\":1}}', '::1', '2025-04-26 03:12:08'),
(70, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 03:13:01'),
(71, 5, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"5\",\"username\":\"chef\",\"role\":\"chef\"}', '::1', '2025-04-26 03:13:21'),
(72, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 03:13:29'),
(73, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 03:13:32'),
(74, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:16:58'),
(75, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:17:39'),
(76, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:17:40'),
(77, 5, 'info', 'تم الوصول إلى صفحة الوصفات التفاعلية', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:17:41'),
(78, 5, 'info', 'تم الوصول إلى صفحة تقدير وقت التحضير', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:17:42'),
(79, 5, 'info', 'تم الوصول إلى صفحة تقدير وقت التحضير', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:17:46'),
(80, 5, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"5\",\"role\":\"chef\"}', '::1', '2025-04-26 08:38:40'),
(81, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 08:38:48'),
(82, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 11:00:53'),
(83, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 11:01:12'),
(84, 1, 'info', 'تم الوصول إلى صفحة سجلات النظام', '{\"user_id\":\"1\",\"filter_type\":null}', '::1', '2025-04-26 11:01:13'),
(85, 1, 'security', 'تسجيل خروج المستخدم', '{\"user_id\":\"1\",\"role\":\"admin\"}', '::1', '2025-04-26 11:01:14'),
(86, 3, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"3\",\"username\":\"cashier\",\"role\":\"cashier\"}', '::1', '2025-04-26 11:01:23'),
(87, 1, 'security', 'تسجيل دخول ناجح', '{\"user_id\":\"1\",\"username\":\"admin\",\"role\":\"admin\"}', '::1', '2025-04-26 11:19:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','cashier','order_handler','chef') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `role`, `created_at`) VALUES
(1, 'admin', '$2y$10$5qdc4RmCU1hCHJrFSBb5WOf21X0HFp7OUrxmzF.RwoNU6rAZt7dLG', 'System Administrator', 'admin', '2025-04-23 02:33:38'),
(3, 'cashier', '$2y$10$GjdMWWl2xQoIQcecBdN7oe./L/6a04Sh9nWNMTxxlUwoGdm1tjC1q', 'Qaedar Ahmed', 'cashier', '2025-04-23 02:56:50'),
(4, 'order_handler', '$2y$10$yZufpjUjbbkHCe/mEigqv.a/D5BwDKlampedAfFsamjWVxW0QcjLK', 'Ali Masood', 'order_handler', '2025-04-24 02:59:35'),
(5, 'chef', '$2y$10$xXYhuf8mCDjm0TX6sQPp2.mgpZqtU.BzrpN.3ph59F.UsVt/Gpzdq', 'Salah Sadeeq', 'chef', '2025-04-24 03:06:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `menu_item_id` (`menu_item_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `processed_by` (`processed_by`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_system_logs_type` (`log_type`),
  ADD KEY `idx_system_logs_user` (`user_id`),
  ADD KEY `idx_system_logs_created_at` (`created_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `support_tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD CONSTRAINT `system_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
