/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.33 : Database - medicine
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`medicine` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `medicine`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add distributor_table',7,'add_distributor_table'),
(26,'Can change distributor_table',7,'change_distributor_table'),
(27,'Can delete distributor_table',7,'delete_distributor_table'),
(28,'Can view distributor_table',7,'view_distributor_table'),
(29,'Can add login_table',8,'add_login_table'),
(30,'Can change login_table',8,'change_login_table'),
(31,'Can delete login_table',8,'delete_login_table'),
(32,'Can view login_table',8,'view_login_table'),
(33,'Can add medicine_table',9,'add_medicine_table'),
(34,'Can change medicine_table',9,'change_medicine_table'),
(35,'Can delete medicine_table',9,'delete_medicine_table'),
(36,'Can view medicine_table',9,'view_medicine_table'),
(37,'Can add pharmacy_table',10,'add_pharmacy_table'),
(38,'Can change pharmacy_table',10,'change_pharmacy_table'),
(39,'Can delete pharmacy_table',10,'delete_pharmacy_table'),
(40,'Can view pharmacy_table',10,'view_pharmacy_table'),
(41,'Can add user_table',11,'add_user_table'),
(42,'Can change user_table',11,'change_user_table'),
(43,'Can delete user_table',11,'delete_user_table'),
(44,'Can view user_table',11,'view_user_table'),
(45,'Can add pharmacyrequest_table',12,'add_pharmacyrequest_table'),
(46,'Can change pharmacyrequest_table',12,'change_pharmacyrequest_table'),
(47,'Can delete pharmacyrequest_table',12,'delete_pharmacyrequest_table'),
(48,'Can view pharmacyrequest_table',12,'view_pharmacyrequest_table'),
(49,'Can add distributorrequest_table',13,'add_distributorrequest_table'),
(50,'Can change distributorrequest_table',13,'change_distributorrequest_table'),
(51,'Can delete distributorrequest_table',13,'delete_distributorrequest_table'),
(52,'Can view distributorrequest_table',13,'view_distributorrequest_table'),
(61,'Can add orders_table',16,'add_orders_table'),
(62,'Can change orders_table',16,'change_orders_table'),
(63,'Can delete orders_table',16,'delete_orders_table'),
(64,'Can view orders_table',16,'view_orders_table'),
(65,'Can add order_details',17,'add_order_details'),
(66,'Can change order_details',17,'change_order_details'),
(67,'Can delete order_details',17,'delete_order_details'),
(68,'Can view order_details',17,'view_order_details'),
(69,'Can add pharmacy_stock_table',18,'add_pharmacy_stock_table'),
(70,'Can change pharmacy_stock_table',18,'change_pharmacy_stock_table'),
(71,'Can delete pharmacy_stock_table',18,'delete_pharmacy_stock_table'),
(72,'Can view pharmacy_stock_table',18,'view_pharmacy_stock_table'),
(73,'Can add distributor_stock_table',19,'add_distributor_stock_table'),
(74,'Can change distributor_stock_table',19,'change_distributor_stock_table'),
(75,'Can delete distributor_stock_table',19,'delete_distributor_stock_table'),
(76,'Can view distributor_stock_table',19,'view_distributor_stock_table'),
(77,'Can add distributor_medicine_table',20,'add_distributor_medicine_table'),
(78,'Can change distributor_medicine_table',20,'change_distributor_medicine_table'),
(79,'Can delete distributor_medicine_table',20,'delete_distributor_medicine_table'),
(80,'Can view distributor_medicine_table',20,'view_distributor_medicine_table'),
(81,'Can add pharmacy_medicine_table',21,'add_pharmacy_medicine_table'),
(82,'Can change pharmacy_medicine_table',21,'change_pharmacy_medicine_table'),
(83,'Can delete pharmacy_medicine_table',21,'delete_pharmacy_medicine_table'),
(84,'Can view pharmacy_medicine_table',21,'view_pharmacy_medicine_table'),
(85,'Can add order_medicine_details',22,'add_order_medicine_details'),
(86,'Can change order_medicine_details',22,'change_order_medicine_details'),
(87,'Can delete order_medicine_details',22,'delete_order_medicine_details'),
(88,'Can view order_medicine_details',22,'view_order_medicine_details');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$720000$YIwWaUTBpzJxMYhijfquyp$eEvXmb2EQThvyGhuUH7fBq28vBglYUUIwwWMpXlpqN8=','2024-01-19 07:49:11.312965',1,'admin','','','admin@gmail.com',1,1,'2024-01-12 06:19:04.543174');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(20,'med_app','distributor_medicine_table'),
(19,'med_app','distributor_stock_table'),
(7,'med_app','distributor_table'),
(13,'med_app','distributorrequest_table'),
(8,'med_app','login_table'),
(9,'med_app','medicine_table'),
(17,'med_app','order_details'),
(22,'med_app','order_medicine_details'),
(16,'med_app','orders_table'),
(21,'med_app','pharmacy_medicine_table'),
(18,'med_app','pharmacy_stock_table'),
(10,'med_app','pharmacy_table'),
(12,'med_app','pharmacyrequest_table'),
(11,'med_app','user_table'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-11-26 05:33:22.847332'),
(2,'auth','0001_initial','2023-11-26 05:33:23.023506'),
(3,'admin','0001_initial','2023-11-26 05:33:23.085370'),
(4,'admin','0002_logentry_remove_auto_add','2023-11-26 05:33:23.088437'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-11-26 05:33:23.088437'),
(6,'contenttypes','0002_remove_content_type_name','2023-11-26 05:33:23.116909'),
(7,'auth','0002_alter_permission_name_max_length','2023-11-26 05:33:23.148190'),
(8,'auth','0003_alter_user_email_max_length','2023-11-26 05:33:23.166922'),
(9,'auth','0004_alter_user_username_opts','2023-11-26 05:33:23.178903'),
(10,'auth','0005_alter_user_last_login_null','2023-11-26 05:33:23.211978'),
(11,'auth','0006_require_contenttypes_0002','2023-11-26 05:33:23.211978'),
(12,'auth','0007_alter_validators_add_error_messages','2023-11-26 05:33:23.211978'),
(13,'auth','0008_alter_user_username_max_length','2023-11-26 05:33:23.242353'),
(14,'auth','0009_alter_user_last_name_max_length','2023-11-26 05:33:23.259884'),
(15,'auth','0010_alter_group_name_max_length','2023-11-26 05:33:23.274535'),
(16,'auth','0011_update_proxy_permissions','2023-11-26 05:33:23.289554'),
(17,'auth','0012_alter_user_first_name_max_length','2023-11-26 05:33:23.308690'),
(18,'med_app','0001_initial','2023-11-26 05:33:23.505825'),
(19,'sessions','0001_initial','2023-11-26 05:33:23.522398'),
(22,'med_app','0002_order_details_orders_table','2023-12-08 05:53:36.644092'),
(23,'med_app','0003_rename_order_orders_table_total','2023-12-08 05:56:50.372060'),
(24,'med_app','0004_pharmacyrequest_table_distributor','2023-12-26 03:51:40.130894'),
(25,'med_app','0005_orders_table_phaarmacy','2023-12-28 05:44:27.165021'),
(26,'med_app','0006_auto_20231228_1105','2023-12-28 05:44:27.696721'),
(27,'med_app','0007_distributor_medicine_table_pharmacy_medicine_table','2024-01-15 10:08:29.094859'),
(28,'med_app','0008_alter_pharmacy_medicine_table_medicine_and_more','2024-01-15 10:10:41.342927'),
(29,'med_app','0009_distributor_medicine_table_status_and_more','2024-01-15 10:12:21.932650'),
(30,'med_app','0010_alter_order_medicine_details_medicine_id','2024-01-15 10:35:20.492564');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('d9tq8f2hlkorxf1jxdybfxekrdyyvy9p','eyJFTWlkIjoxLCJsaWQiOjgsIm1pZCI6NH0:1rBULv:BctWEH80ftT4_lYFNqbNbohKKZYbGuF822e9wY-I-F8','2023-12-22 06:28:47.893059'),
('kiw6bu5jr1z076midonojag26cvf4sec','eyJFTWlkIjozfQ:1rLcwn:W-Pzad8_oh2L1YK3Eom55xtaVORT6QdUtKg1VURJAto','2024-01-19 05:40:45.735679'),
('qa5y42yhklftsj1r9n4xpi7ok0237a6e','.eJxVjksOgzAMRO-SdRXhONDQZfecATm2aWhRIvFZVb17QWLRbufNPM3b9LStqd8WnftRzM2Aufxmkfil-QDypPwolkte5zHao2JPutiuiE73s_snSLSkfd14rWNwQDEGRhVAQmYBAQdM2Dr0sb0iMKtUQ00kWjW-ogEHdhjqXTod_8LnC8oVOrM:1rQjcl:vLjkIqsbZ2Ikf_h0_ClhqqEJCYKEXQFHqWhXP5OT0LQ','2024-02-02 07:49:11.315881'),
('qzq5mwa97itrlfy1u61cxv0jbs0zw4d8','.eJxVjrEOgzAMRP8lM4pwDDR07M43IMd2Ci0FicBU9d9LJIZ2Ounu3enepqd9G_o96dqPYq4GTPHrBeKnzjmQB833xfIyb-sYbEbsmSbbLaLT7WT_BgZKw9FuKq2Dd0AheEYVQEJmAQEHTNg6rEJ7QWBWKWNNJFo2VUkRIzv09TE65X--MK-s0Hy-5DM8_g:1rPKcW:C5ZedNKHMwXNTvOd3x5gYlbYln1bOWxytgOwzzfS-lw','2024-01-29 10:55:08.160989'),
('shwsv2bzbqjo2da41e669wza16s1wz5d','.eJyrVsrJTFGyMtRRyk2JB7GMdZRcfUEME6BQagqIZQZkQaXy88ECtQCx8Q99:1rLhEG:vbMnXYzzQzQx3TGun1_Ebj-DXc1-IS7cj8NACK5RrjY','2024-01-19 10:15:04.762160'),
('uwoznaczvko0vbjfhjlml4h34wlb6w0i','.eJyrVsrJTFGyMtRRygXRxkA6NQXKcvWFCaXEQ1lpYMXmOkr5-SCWaS0AQU8RvQ:1rJRKG:HvDsGXaiIFWxWMxaPCLQp6PZVYY_qH4zp2sN7mYxHJQ','2024-01-13 04:51:56.613981');

/*Table structure for table `med_app_distributor_medicine_table` */

DROP TABLE IF EXISTS `med_app_distributor_medicine_table`;

CREATE TABLE `med_app_distributor_medicine_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `MEDICINE_id` bigint NOT NULL,
  `REQUEST_id` bigint NOT NULL,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_distributor__MEDICINE_id_36c29542_fk_med_app_m` (`MEDICINE_id`),
  KEY `med_app_distributor__REQUEST_id_355c64b2_fk_med_app_d` (`REQUEST_id`),
  CONSTRAINT `med_app_distributor__MEDICINE_id_36c29542_fk_med_app_m` FOREIGN KEY (`MEDICINE_id`) REFERENCES `med_app_medicine_table` (`id`),
  CONSTRAINT `med_app_distributor__REQUEST_id_355c64b2_fk_med_app_d` FOREIGN KEY (`REQUEST_id`) REFERENCES `med_app_distributorrequest_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_distributor_medicine_table` */

insert  into `med_app_distributor_medicine_table`(`id`,`MEDICINE_id`,`REQUEST_id`,`status`) values 
(11,16,16,'na'),
(12,16,16,'na'),
(13,16,16,'na'),
(14,16,16,'na'),
(15,16,16,'na'),
(16,16,16,'na'),
(17,16,16,'na'),
(18,16,16,'na'),
(19,16,16,'na'),
(20,16,16,'na'),
(21,16,17,'na'),
(22,16,17,'na'),
(23,16,17,'na'),
(24,16,17,'na'),
(25,16,17,'na'),
(26,16,17,'na'),
(27,16,17,'na'),
(28,16,17,'na'),
(29,16,17,'na'),
(30,16,17,'na'),
(31,16,17,'available'),
(32,16,17,'available'),
(33,16,17,'available'),
(34,16,17,'available'),
(35,16,17,'available'),
(36,16,17,'available'),
(37,16,17,'available'),
(38,16,17,'available'),
(39,16,17,'available'),
(40,16,17,'available'),
(41,16,17,'available'),
(42,16,17,'available'),
(43,16,17,'available'),
(44,16,17,'available'),
(45,16,17,'available'),
(46,16,17,'available'),
(47,16,17,'available'),
(48,16,17,'available'),
(49,16,17,'available'),
(50,16,17,'available'),
(51,17,18,'available');

/*Table structure for table `med_app_distributor_stock_table` */

DROP TABLE IF EXISTS `med_app_distributor_stock_table`;

CREATE TABLE `med_app_distributor_stock_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock` int NOT NULL,
  `DISTRIBUTOR_id` bigint NOT NULL,
  `MEDICINE_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_distributor__DISTRIBUTOR_id_b37ba250_fk_med_app_d` (`DISTRIBUTOR_id`),
  KEY `med_app_distributor__MEDICINE_id_50810f3b_fk_med_app_m` (`MEDICINE_id`),
  CONSTRAINT `med_app_distributor__DISTRIBUTOR_id_b37ba250_fk_med_app_d` FOREIGN KEY (`DISTRIBUTOR_id`) REFERENCES `med_app_distributor_table` (`id`),
  CONSTRAINT `med_app_distributor__MEDICINE_id_50810f3b_fk_med_app_m` FOREIGN KEY (`MEDICINE_id`) REFERENCES `med_app_medicine_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_distributor_stock_table` */

insert  into `med_app_distributor_stock_table`(`id`,`stock`,`DISTRIBUTOR_id`,`MEDICINE_id`) values 
(1,40,1,16),
(2,1,1,17);

/*Table structure for table `med_app_distributor_table` */

DROP TABLE IF EXISTS `med_app_distributor_table`;

CREATE TABLE `med_app_distributor_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `phone_no` bigint NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `post` varchar(90) NOT NULL,
  `pin` int NOT NULL,
  `proof_id` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_distributor__LOGIN_id_1c4876ef_fk_med_app_l` (`LOGIN_id`),
  CONSTRAINT `med_app_distributor__LOGIN_id_1c4876ef_fk_med_app_l` FOREIGN KEY (`LOGIN_id`) REFERENCES `med_app_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_distributor_table` */

insert  into `med_app_distributor_table`(`id`,`firstname`,`lastname`,`phone_no`,`email`,`address`,`gender`,`post`,`pin`,`proof_id`,`LOGIN_id`) values 
(1,'almas','afifa',1234567,'almoaffa','drtyjnbvfg','FEMALE','sdftrde',676305,'Screenshot 2023-08-07 021122.png',1),
(2,'almas','afifa',1234567,'almoaffa','e456yujnbfdsw23','FEMALE','sdftrde',676305,'Screenshot 2023-08-07 021122_bXfay6O.png',9),
(3,'aloo','erushda',1234567,'almoaffa','zsertyujknbvgh','OTHERS','sdftrde',676305,'Screenshot 2023-08-07 021116_TvyA3U6.png',11),
(4,'poool','rrikuuu',1234567,'almoaffa','sertyuikjhvfh','FEMALE','sdftrde',676305,'Screenshot 2023-08-07 021116_wmRvRjF.png',12),
(5,'fathima','rushda',9876543212,'fathimarushda811@gmail.com','lkjhgf','FEMALE','sdftrde',456789,'Screenshot 2023-08-07 004318_gj0vDk0.png',14),
(6,'fathima','rushda',7012595373,'fathimarushda811@gmail.com','dyukl','GENDER','kolpm',676305,'Screenshot 2023-08-07 004318_wex8bLv.png',17),
(7,'Aswin','P K',9876543212,'aswin@gmail.com','Calicut','Male','Calicut',654321,'Screenshot 2023-08-07 004318_ZDrot1P.png',18);

/*Table structure for table `med_app_distributorrequest_table` */

DROP TABLE IF EXISTS `med_app_distributorrequest_table`;

CREATE TABLE `med_app_distributorrequest_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `date` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  `MEDICINE_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_distributorr_LOGIN_id_326c20f6_fk_med_app_d` (`LOGIN_id`),
  KEY `med_app_distributorr_MEDICINE_id_9a03d4c3_fk_med_app_m` (`MEDICINE_id`),
  CONSTRAINT `med_app_distributorr_LOGIN_id_326c20f6_fk_med_app_d` FOREIGN KEY (`LOGIN_id`) REFERENCES `med_app_distributor_table` (`id`),
  CONSTRAINT `med_app_distributorr_MEDICINE_id_9a03d4c3_fk_med_app_m` FOREIGN KEY (`MEDICINE_id`) REFERENCES `med_app_medicine_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_distributorrequest_table` */

insert  into `med_app_distributorrequest_table`(`id`,`quantity`,`date`,`status`,`LOGIN_id`,`MEDICINE_id`) values 
(16,10,'2024-01-19','accepted',1,16),
(17,30,'2024-01-19','accepted',1,16),
(18,1,'2024-01-19','accepted',1,17),
(19,12,'2024-01-19','pending',1,17);

/*Table structure for table `med_app_login_table` */

DROP TABLE IF EXISTS `med_app_login_table`;

CREATE TABLE `med_app_login_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_login_table` */

insert  into `med_app_login_table`(`id`,`username`,`password`,`type`) values 
(1,'distributor','456','distributor'),
(2,'admin','123','admin'),
(3,'afifaalmol','123456','pharmacy'),
(4,'afifaalmol','12345','pending'),
(5,'afifaalmol','1234','pending'),
(6,'afifaalmol','123412345','pending'),
(7,'afifaalmol','12345678','pharmacy'),
(8,'pharmacy','345','pharmacy'),
(9,'rushdaaaaaa','123456','distributor'),
(10,'ajjuka','ami','pharmacy'),
(11,'rushdaaaaaa','12345678','distributor'),
(12,'rushdaaaaaa','123456','distributor'),
(13,'ajjuka','56789','pharmacy'),
(14,'rushdaaaaaa','qwertyuj','distributor'),
(15,'rushdaaaaaa','98765432','pharmacy'),
(16,'nmlmknjbhvgcfd','jukjnhbgvfd','pharmacy'),
(17,'samsung','paperpaperpaper','distributor'),
(18,'aswin','Aswin@123','pending'),
(20,'raaya','jhgfdszxcvbnm','pharmacy');

/*Table structure for table `med_app_medicine_table` */

DROP TABLE IF EXISTS `med_app_medicine_table`;

CREATE TABLE `med_app_medicine_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `stock` int NOT NULL,
  `details` varchar(100) NOT NULL,
  `mnf_date` date NOT NULL,
  `exp_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_medicine_table` */

insert  into `med_app_medicine_table`(`id`,`name`,`image`,`price`,`stock`,`details`,`mnf_date`,`exp_date`) values 
(3,'adol','Screenshot 2023-08-06 235444_fcnG3Uq.png',123,1234,'234rfdswer','2023-12-13','2023-12-13'),
(4,'mecdi','Screenshot 2023-08-07 004353_7mcX1aP.png',12,345,'34rtgfxswertg','2023-12-20','2023-12-21'),
(5,'mecdi3er','Screenshot 2023-08-06 235429_KfysWNh.png',125,3456,'234r5tgfdew','2023-12-12','2024-01-04'),
(6,'adol','Screenshot 2023-08-07 021116_gbZx7Em.png',234,56,'123456ygfds','2023-12-15','2024-01-25'),
(13,'paracetamol','Screenshot 2023-08-06 235805_jUXoRfL.png',34567,238765,'piuytreasdfghjiuytrdsxcvhj','2024-01-02','2024-03-14'),
(14,'beatoct','Screenshot 2023-08-07 004353_YhcWO3J.png',122,39,'okay','2024-01-25','2024-02-08'),
(15,'insulin','Screenshot 2023-08-06 235225_y6OoIdo.png',999,678,'good','2024-01-10','2024-02-10'),
(16,'DOLO','Screenshot 2023-08-07 021140.png',888,50,'okY','2024-01-17','2024-03-02'),
(17,'evion','Screenshot 2023-08-07 004318_C5Z1IXZ.png',300,400,'vitamin E tablets','2024-01-04','2024-02-10');

/*Table structure for table `med_app_order_details` */

DROP TABLE IF EXISTS `med_app_order_details`;

CREATE TABLE `med_app_order_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `medicine_id_id` bigint NOT NULL,
  `order_id_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_order_detail_medicine_id_id_c081eade_fk_med_app_m` (`medicine_id_id`),
  KEY `med_app_order_detail_order_id_id_1f294cee_fk_med_app_o` (`order_id_id`),
  CONSTRAINT `med_app_order_detail_medicine_id_id_c081eade_fk_med_app_m` FOREIGN KEY (`medicine_id_id`) REFERENCES `med_app_medicine_table` (`id`),
  CONSTRAINT `med_app_order_detail_order_id_id_1f294cee_fk_med_app_o` FOREIGN KEY (`order_id_id`) REFERENCES `med_app_orders_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_order_details` */

insert  into `med_app_order_details`(`id`,`quantity`,`medicine_id_id`,`order_id_id`) values 
(1,10,16,15),
(2,5,16,16);

/*Table structure for table `med_app_order_medicine_details` */

DROP TABLE IF EXISTS `med_app_order_medicine_details`;

CREATE TABLE `med_app_order_medicine_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `medicine_id_id` bigint NOT NULL,
  `order_id_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_order_medici_order_id_id_ae296272_fk_med_app_o` (`order_id_id`),
  KEY `med_app_order_medici_medicine_id_id_2e15f916_fk_med_app_d` (`medicine_id_id`),
  CONSTRAINT `med_app_order_medici_medicine_id_id_2e15f916_fk_med_app_d` FOREIGN KEY (`medicine_id_id`) REFERENCES `med_app_distributor_medicine_table` (`id`),
  CONSTRAINT `med_app_order_medici_order_id_id_ae296272_fk_med_app_o` FOREIGN KEY (`order_id_id`) REFERENCES `med_app_orders_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_order_medicine_details` */

/*Table structure for table `med_app_orders_table` */

DROP TABLE IF EXISTS `med_app_orders_table`;

CREATE TABLE `med_app_orders_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `phone_no` bigint NOT NULL,
  `total` int NOT NULL,
  `date` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `status` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_orders_table` */

insert  into `med_app_orders_table`(`id`,`username`,`phone_no`,`total`,`date`,`email`,`status`) values 
(15,'raima',1234567890,8880,'2024-01-19','ajukka@gmail.com','finished'),
(16,'naveen',8987654321,4440,'2024-01-19','naveen@gmail.com','finished');

/*Table structure for table `med_app_pharmacy_medicine_table` */

DROP TABLE IF EXISTS `med_app_pharmacy_medicine_table`;

CREATE TABLE `med_app_pharmacy_medicine_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `MEDICINE_id` bigint NOT NULL,
  `PHAARMACY_id` bigint NOT NULL,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_pharmacy_med_PHAARMACY_id_d1f5f348_fk_med_app_p` (`PHAARMACY_id`),
  KEY `med_app_pharmacy_med_MEDICINE_id_279bfb46_fk_med_app_d` (`MEDICINE_id`),
  CONSTRAINT `med_app_pharmacy_med_MEDICINE_id_279bfb46_fk_med_app_d` FOREIGN KEY (`MEDICINE_id`) REFERENCES `med_app_distributor_medicine_table` (`id`),
  CONSTRAINT `med_app_pharmacy_med_PHAARMACY_id_d1f5f348_fk_med_app_p` FOREIGN KEY (`PHAARMACY_id`) REFERENCES `med_app_pharmacyrequest_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_pharmacy_medicine_table` */

insert  into `med_app_pharmacy_medicine_table`(`id`,`MEDICINE_id`,`PHAARMACY_id`,`status`) values 
(1,11,14,'na'),
(2,12,14,'na'),
(3,13,14,'na'),
(4,14,14,'na'),
(5,15,14,'na'),
(6,16,14,'na'),
(7,17,14,'na'),
(8,18,14,'na'),
(9,19,14,'na'),
(10,20,14,'na'),
(11,21,15,'na'),
(12,22,15,'na'),
(13,23,15,'na'),
(14,24,15,'na'),
(15,25,15,'na'),
(16,26,15,'available'),
(17,27,15,'available'),
(18,28,15,'available'),
(19,29,15,'available'),
(20,30,15,'available');

/*Table structure for table `med_app_pharmacy_stock_table` */

DROP TABLE IF EXISTS `med_app_pharmacy_stock_table`;

CREATE TABLE `med_app_pharmacy_stock_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock` int NOT NULL,
  `MEDICINE_id` bigint NOT NULL,
  `PHAARMACY_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_pharmacy_sto_MEDICINE_id_674dd105_fk_med_app_m` (`MEDICINE_id`),
  KEY `med_app_pharmacy_sto_PHAARMACY_id_10e759cb_fk_med_app_p` (`PHAARMACY_id`),
  CONSTRAINT `med_app_pharmacy_sto_MEDICINE_id_674dd105_fk_med_app_m` FOREIGN KEY (`MEDICINE_id`) REFERENCES `med_app_medicine_table` (`id`),
  CONSTRAINT `med_app_pharmacy_sto_PHAARMACY_id_10e759cb_fk_med_app_p` FOREIGN KEY (`PHAARMACY_id`) REFERENCES `med_app_pharmacy_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_pharmacy_stock_table` */

insert  into `med_app_pharmacy_stock_table`(`id`,`stock`,`MEDICINE_id`,`PHAARMACY_id`) values 
(1,20,16,3);

/*Table structure for table `med_app_pharmacy_table` */

DROP TABLE IF EXISTS `med_app_pharmacy_table`;

CREATE TABLE `med_app_pharmacy_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone_no` bigint NOT NULL,
  `email` varchar(50) NOT NULL,
  `location` varchar(100) NOT NULL,
  `pin` int NOT NULL,
  `proof_id` varchar(100) NOT NULL,
  `post` varchar(20) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_pharmacy_tab_LOGIN_id_1b10facc_fk_med_app_l` (`LOGIN_id`),
  CONSTRAINT `med_app_pharmacy_tab_LOGIN_id_1b10facc_fk_med_app_l` FOREIGN KEY (`LOGIN_id`) REFERENCES `med_app_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_pharmacy_table` */

insert  into `med_app_pharmacy_table`(`id`,`name`,`phone_no`,`email`,`location`,`pin`,`proof_id`,`post`,`LOGIN_id`) values 
(1,'rushda',1234,'jhgfds','tghjk',1234,'Screenshot 2023-08-06 235444_jkYtofg.png','wsdfds',3),
(2,'rushda',1234567,'jhgfds','ghjk',1234,'Screenshot 2023-08-07 021116.png','wsdfds',7),
(3,'rushda',1234567,'jhgfds','ghjk',1234,'Screenshot 2023-08-06 235444_uhakyWb.png','wsdfds',8),
(4,'ami',1234567890,'ajukka@gmail.com','',676305,'Screenshot 2023-08-06 235444_9DdUPHW.png','kolappuram',10),
(5,'fathima rushda',917012595373,'fathimarushda811@gmail.com','',2345,'Screenshot 2023-08-07 004318_sUXxWcM.png','kjhgfcxcvbnh',13),
(6,'sulaiman',9876543212,'ajukka@gmail.com','',765432,'Screenshot 2023-08-07 004318_LRqOszb.png','SXDCFVGmjkl',15),
(7,'fathima rushda',7012595373,'fathimarushda811@gmail.com','',676805,'Screenshot 2023-08-07 021116_zSUOL0t.png','hgfds',16),
(8,'fathima raaaya',7012595373,'fathimarushda811@gmail.com','',654321,'Screenshot 2023-08-07 004353_APops7y.png','wsdfds',20);

/*Table structure for table `med_app_pharmacyrequest_table` */

DROP TABLE IF EXISTS `med_app_pharmacyrequest_table`;

CREATE TABLE `med_app_pharmacyrequest_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `MEDICINE_id` bigint NOT NULL,
  `PHAARMACY_id` bigint NOT NULL,
  `DISTRIBUTOR_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_pharmacyrequ_MEDICINE_id_4a45cc1c_fk_med_app_m` (`MEDICINE_id`),
  KEY `med_app_pharmacyrequ_PHAARMACY_id_94e37188_fk_med_app_p` (`PHAARMACY_id`),
  KEY `med_app_pharmacyrequ_DISTRIBUTOR_id_7200f476_fk_med_app_d` (`DISTRIBUTOR_id`),
  CONSTRAINT `med_app_pharmacyrequ_DISTRIBUTOR_id_7200f476_fk_med_app_d` FOREIGN KEY (`DISTRIBUTOR_id`) REFERENCES `med_app_distributor_table` (`id`),
  CONSTRAINT `med_app_pharmacyrequ_MEDICINE_id_4a45cc1c_fk_med_app_m` FOREIGN KEY (`MEDICINE_id`) REFERENCES `med_app_medicine_table` (`id`),
  CONSTRAINT `med_app_pharmacyrequ_PHAARMACY_id_94e37188_fk_med_app_p` FOREIGN KEY (`PHAARMACY_id`) REFERENCES `med_app_pharmacy_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_pharmacyrequest_table` */

insert  into `med_app_pharmacyrequest_table`(`id`,`quantity`,`date`,`status`,`MEDICINE_id`,`PHAARMACY_id`,`DISTRIBUTOR_id`) values 
(14,10,'2024-01-19','Accepted',16,3,1),
(15,10,'2024-01-19','Accepted',16,3,1);

/*Table structure for table `med_app_user_table` */

DROP TABLE IF EXISTS `med_app_user_table`;

CREATE TABLE `med_app_user_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `phone_no` bigint NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `med_app_user_table_LOGIN_id_cad5a8ad_fk_med_app_login_table_id` (`LOGIN_id`),
  CONSTRAINT `med_app_user_table_LOGIN_id_cad5a8ad_fk_med_app_login_table_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `med_app_login_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `med_app_user_table` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
