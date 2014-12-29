-- phpMyAdmin SQL Dump
-- version 3.3.10.4
-- http://www.phpmyadmin.net
--
-- Host: mysql.wiki.austinyellowbike.org
-- Generation Time: Dec 29, 2014 at 09:52 AM
-- Server version: 5.1.56
-- PHP Version: 5.4.20

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ybdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL DEFAULT '',
  `middle_initial` char(2) NOT NULL DEFAULT '',
  `last_name` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(70) NOT NULL DEFAULT '',
  `phone` varchar(45) NOT NULL DEFAULT '',
  `address1` varchar(70) NOT NULL DEFAULT '',
  `address2` varchar(70) NOT NULL DEFAULT '',
  `city` varchar(25) NOT NULL DEFAULT '',
  `state` char(2) NOT NULL DEFAULT '',
  `country` varchar(25) NOT NULL DEFAULT '',
  `receive_newsletter` tinyint(1) NOT NULL DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `invited_newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `DOB` date NOT NULL DEFAULT '0000-00-00',
  `pass` varbinary(30) NOT NULL DEFAULT '',
  `zip` varchar(5) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `location_name` varchar(45) NOT NULL DEFAULT '',
  `location_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `location_type` (`location_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 5120 kB' AUTO_INCREMENT=17512 ;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` varchar(50) NOT NULL DEFAULT '',
  `date_established` date NOT NULL DEFAULT '0000-00-00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `mechanic` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sale_log`
--

CREATE TABLE IF NOT EXISTS `sale_log` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sale_type` varchar(45) NOT NULL DEFAULT '',
  `description` varchar(200) NOT NULL DEFAULT '',
  `amount` float NOT NULL DEFAULT '0',
  `sold_by` varchar(45) NOT NULL DEFAULT '',
  `sold_to` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE IF NOT EXISTS `shops` (
  `shop_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `shop_location` varchar(45) NOT NULL DEFAULT '',
  `shop_type` varchar(45) NOT NULL DEFAULT '',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_id`),
  KEY `shop_type` (`shop_type`),
  KEY `shop_location` (`shop_location`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2944 ;

-- --------------------------------------------------------

--
-- Table structure for table `shop_hours`
--

CREATE TABLE IF NOT EXISTS `shop_hours` (
  `shop_visit_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `shop_id` int(10) unsigned NOT NULL DEFAULT '0',
  `shop_user_role` varchar(45) NOT NULL DEFAULT '',
  `project_id` varchar(45) DEFAULT NULL,
  `time_in` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_out` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment` tinytext,
  PRIMARY KEY (`shop_visit_id`),
  KEY `contact_id` (`contact_id`),
  KEY `shop_user_role` (`shop_user_role`),
  KEY `project_id` (`project_id`),
  KEY `shop_id` (`shop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 4096 kB; (`contact_id`) REFER `nwilkes_ybdb/con' AUTO_INCREMENT=54088 ;

-- --------------------------------------------------------

--
-- Table structure for table `shop_locations`
--

CREATE TABLE IF NOT EXISTS `shop_locations` (
  `shop_location_id` varchar(30) NOT NULL DEFAULT '',
  `date_established` date NOT NULL DEFAULT '0000-00-00',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shop_types`
--

CREATE TABLE IF NOT EXISTS `shop_types` (
  `shop_type_id` varchar(30) NOT NULL DEFAULT '',
  `list_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shop_user_roles`
--

CREATE TABLE IF NOT EXISTS `shop_user_roles` (
  `shop_user_role_id` varchar(45) NOT NULL DEFAULT '',
  `hours_rank` int(10) unsigned NOT NULL DEFAULT '0',
  `volunteer` tinyint(1) NOT NULL DEFAULT '0',
  `sales` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `paid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_log`
--

CREATE TABLE IF NOT EXISTS `transaction_log` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_startstorage` datetime DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `transaction_type` varchar(45) NOT NULL DEFAULT '',
  `amount` float DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  `sold_to` int(10) unsigned DEFAULT NULL,
  `sold_by` int(10) unsigned DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '1',
  `shop_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`transaction_id`),
  KEY `transaction_type` (`transaction_type`),
  KEY `sold_to` (`sold_to`),
  KEY `sold_by` (`sold_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15292 ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_types`
--

CREATE TABLE IF NOT EXISTS `transaction_types` (
  `transaction_type_id` varchar(45) NOT NULL DEFAULT '',
  `rank` varchar(45) NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `community_bike` tinyint(1) NOT NULL DEFAULT '0',
  `show_transaction_id` tinyint(1) NOT NULL DEFAULT '0',
  `show_type` tinyint(1) NOT NULL DEFAULT '0',
  `show_startdate` tinyint(1) NOT NULL DEFAULT '0',
  `show_amount` tinyint(1) NOT NULL DEFAULT '0',
  `show_description` tinyint(1) NOT NULL DEFAULT '0',
  `show_soldto` tinyint(1) NOT NULL DEFAULT '0',
  `show_soldby` tinyint(1) NOT NULL DEFAULT '0',
  `fieldname_date` varchar(25) NOT NULL DEFAULT '',
  `fieldname_soldby` varchar(25) NOT NULL DEFAULT '',
  `message_transaction_id` varchar(200) NOT NULL DEFAULT '',
  `fieldname_soldto` varchar(45) NOT NULL DEFAULT '',
  `show_soldto_location` tinyint(1) NOT NULL DEFAULT '0',
  `fieldname_description` varchar(45) NOT NULL,
  `accounting_group` varchar(45) NOT NULL,
  PRIMARY KEY (`transaction_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours` (
`Date` date
,`DayName` varchar(9)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`ShopUserRole` varchar(45)
,`Project` varchar(45)
,`Hours` decimal(23,2)
,`Pay` decimal(26,2)
,`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`YearWeek` int(5)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`Week` int(2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byMonth`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byMonth` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byMonth1_AllHours`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byMonth1_AllHours` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byMonth1_NoSpProj`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byMonth1_NoSpProj` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byMonth2`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byMonth2` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byMonth_WholeOper`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byMonth_WholeOper` (
`Year` int(4)
,`Month` int(2)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byPayPeriod2`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byPayPeriod2` (
`Year` int(5)
,`PayPeriod` int(5)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Pay_All` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byQuarter`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byQuarter` (
`Year` int(4)
,`Quarter` int(1)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byQuarter1_AllHours`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byQuarter1_AllHours` (
`Year` int(4)
,`Quarter` int(1)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byQuarter1_NoSpProj`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byQuarter1_NoSpProj` (
`Year` int(4)
,`Quarter` int(1)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byQuarter2`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byQuarter2` (
`Year` int(4)
,`Quarter` int(1)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byQuarter_WholeOper`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byQuarter_WholeOper` (
`Year` int(4)
,`Quarter` int(1)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byWeek`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byWeek` (
`Year` int(5)
,`Week` int(2)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byWeek1_AllHours`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byWeek1_AllHours` (
`Year` int(5)
,`Week` int(2)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byWeek1_NoSpProj`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byWeek1_NoSpProj` (
`Year` int(5)
,`Week` int(2)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byWeek2`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byWeek2` (
`Year` int(5)
,`Week` int(2)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byWeek_WholeOper`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byWeek_WholeOper` (
`Year` int(5)
,`Week` int(2)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byYear`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byYear` (
`Year` int(4)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byYear1_AllHours`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byYear1_AllHours` (
`Year` int(4)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byYear1_NoSpProj`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byYear1_NoSpProj` (
`Year` int(4)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byYear2`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byYear2` (
`Year` int(4)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_byYear_WholeOper`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_byYear_WholeOper` (
`Year` int(4)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_NoSpProj`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_NoSpProj` (
`Date` date
,`DayName` varchar(9)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`ShopUserRole` varchar(45)
,`Project` varchar(45)
,`Hours` decimal(23,2)
,`Pay` decimal(26,2)
,`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`YearWeek` int(5)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`Week` int(2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeHours_WholeOper`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeHours_WholeOper` (
`Date` date
,`DayName` varchar(9)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`ShopUserRole` varchar(45)
,`Project` varchar(45)
,`Hours` decimal(23,2)
,`Pay` decimal(26,2)
,`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`YearWeek` int(5)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`Week` int(2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics1_AllTransactions`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics1_AllTransactions` (
`Date` datetime
,`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`YearWeek` int(5)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`Week` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`TransactionType` varchar(45)
,`TransactionGroup` varchar(45)
,`Value` float
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics2_byMonth_AllTransactions`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics2_byMonth_AllTransactions` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`TransactionType` varchar(45)
,`TransactionGroup` varchar(45)
,`Total` double(17,0)
,`Count` bigint(21)
,`Average` double(17,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics2_byWeek_AllTransactions`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics2_byWeek_AllTransactions` (
`Year` int(5)
,`Week` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`TransactionType` varchar(45)
,`TransactionGroup` varchar(45)
,`Total` double(17,0)
,`Count` bigint(21)
,`Average` double(17,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics3a_byMonth_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics3a_byMonth_pvTbl` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`NumBikesSold` bigint(20)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` bigint(20)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` bigint(20)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics3a_byWeek_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics3a_byWeek_pvTbl` (
`Year` int(5)
,`Week` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`NumBikesSold` bigint(20)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` bigint(20)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` bigint(20)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics3b_byQuarter`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics3b_byQuarter` (
`Year` int(4)
,`Quarter` int(1)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`NumBikesSold` decimal(41,0)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` decimal(41,0)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` decimal(41,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics3b_byYear`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics3b_byYear` (
`Year` int(4)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`NumBikesSold` decimal(41,0)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` decimal(41,0)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` decimal(41,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics4_byMonth_Calc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics4_byMonth_Calc` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`NumBikesSold` bigint(20)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` bigint(20)
,`NetValueBikesFixed` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` bigint(20)
,`AverageValueWheelsFixed` double(17,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics4_byQuarter_Calc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics4_byQuarter_Calc` (
`Year` int(4)
,`Quarter` int(1)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`NumBikesSold` decimal(41,0)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` decimal(41,0)
,`NetValueBikesFixed` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` decimal(41,0)
,`AverageValueWheelsFixed` double(17,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics4_byWeek_Calc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics4_byWeek_Calc` (
`Year` int(5)
,`Week` int(2)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`NumBikesSold` bigint(20)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` bigint(20)
,`NetValueBikesFixed` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` bigint(20)
,`AverageValueWheelsFixed` double(17,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics4_byYear_Calc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics4_byYear_Calc` (
`Year` int(4)
,`contact_id` int(10) unsigned
,`Name` varchar(45)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`NumBikesSold` decimal(41,0)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NumBikesFixed` decimal(41,0)
,`NetValueBikesFixed` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` decimal(41,0)
,`AverageValueWheelsFixed` double(17,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics5_byMonth_HoursCalc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics5_byMonth_HoursCalc` (
`Year` int(4)
,`Quarter` int(1)
,`Month` int(2)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`SalesPerHour` double(19,2)
,`NumBikesSold` bigint(20)
,`HoursPerBikeSold` decimal(46,2)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NetValueBikesFixed` double(19,2)
,`NetValueBikesFixedPerHour` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`NumBikesFixed` bigint(20)
,`HoursPerBikeFixed` decimal(46,2)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` bigint(20)
,`AverageValueWheelsFixed` double(17,0)
,`NetProductionPerHour` double(19,2)
,`NetProductionToPayValueRatio` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics5_byQuarter_HoursCalc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics5_byQuarter_HoursCalc` (
`Year` int(4)
,`Quarter` int(1)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`SalesPerHour` double(19,2)
,`NumBikesSold` decimal(41,0)
,`HoursPerBikeSold` decimal(46,2)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NetValueBikesFixed` double(19,2)
,`NetValueBikesFixedPerHour` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`NumBikesFixed` decimal(41,0)
,`HoursPerBikeFixed` decimal(46,2)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` decimal(41,0)
,`AverageValueWheelsFixed` double(17,0)
,`NetProductionPerHour` double(19,2)
,`NetProductionToPayValueRatio` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics5_byWeek_HoursCalc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics5_byWeek_HoursCalc` (
`Year` int(5)
,`Week` int(2)
,`PayPeriod` int(5)
,`PayPeriodWeek` int(5)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`SalesPerHour` double(19,2)
,`NumBikesSold` bigint(20)
,`HoursPerBikeSold` decimal(46,2)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NetValueBikesFixed` double(19,2)
,`NetValueBikesFixedPerHour` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`NumBikesFixed` bigint(20)
,`HoursPerBikeFixed` decimal(46,2)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` bigint(20)
,`AverageValueWheelsFixed` double(17,0)
,`NetProductionPerHour` double(19,2)
,`NetProductionToPayValueRatio` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_EmployeeMetrics5_byYear_HoursCalc`
--
CREATE TABLE IF NOT EXISTS `view_EmployeeMetrics5_byYear_HoursCalc` (
`Year` int(4)
,`ContactID` int(10) unsigned
,`Name` varchar(45)
,`Hours_All` decimal(45,2)
,`Hours_Spec` decimal(46,2)
,`Hours_NoSpec` decimal(45,2)
,`Pay_All` decimal(48,2)
,`Pay_Spec` decimal(49,2)
,`Pay_NoSpec` decimal(48,2)
,`NetSalesNewParts` double(18,1)
,`SalesUsedParts` double(17,0)
,`SalesBikes` double(17,0)
,`TotalSales` double(17,0)
,`SalesPerHour` double(19,2)
,`NumBikesSold` decimal(41,0)
,`HoursPerBikeSold` decimal(46,2)
,`ValueBikesFixed` double(17,0)
,`ValueNewPartsOnBikes` double(17,0)
,`NetValueBikesFixed` double(19,2)
,`NetValueBikesFixedPerHour` double(19,2)
,`AverageValueBikesFixed` double(17,0)
,`AverageValueNewPartsOnBikes` double(17,0)
,`AverageNetValueBikesFixed` double(17,0)
,`NumBikesFixed` decimal(41,0)
,`HoursPerBikeFixed` decimal(46,2)
,`ValueWheelsFixed` double(17,0)
,`NumWheelsFixed` decimal(41,0)
,`AverageValueWheelsFixed` double(17,0)
,`NetProductionPerHour` double(19,2)
,`NetProductionToPayValueRatio` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_MechanicOperationMetrics_byMonth`
--
CREATE TABLE IF NOT EXISTS `view_MechanicOperationMetrics_byMonth` (
`Year` int(4)
,`Month` int(2)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
,`ValueBikesFixed` double(19,2)
,`ValueWheelsFixed` double(19,2)
,`ValueNewPartsOnBikes` double(19,2)
,`EstimatedNetIncome` double(19,2)
,`EstimatedNetPerHour` double(23,6)
,`TotalBikesFixed` bigint(20)
,`TotalWheelsFixed` bigint(20)
,`HoursPerBike` decimal(45,1)
,`AverageBikeValue` double(18,1)
,`SalesBikes` double(19,2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`TotalSales` double(19,2)
,`TotalBikesSold` bigint(20)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_MechanicOperationMetrics_byQuarter`
--
CREATE TABLE IF NOT EXISTS `view_MechanicOperationMetrics_byQuarter` (
`Year` int(4)
,`Quarter` int(1)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
,`ValueBikesFixed` double(19,2)
,`ValueWheelsFixed` double(19,2)
,`ValueNewPartsOnBikes` double(19,2)
,`EstimatedNetIncome` double(19,2)
,`EstimatedNetPerHour` double(23,6)
,`TotalBikesFixed` bigint(20)
,`TotalWheelsFixed` bigint(20)
,`HoursPerBike` decimal(45,1)
,`AverageBikeValue` double(18,1)
,`SalesBikes` double(19,2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`TotalSales` double(19,2)
,`TotalBikesSold` bigint(20)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_MechanicOperationMetrics_byWeek`
--
CREATE TABLE IF NOT EXISTS `view_MechanicOperationMetrics_byWeek` (
`Year` int(5)
,`Week` int(2)
,`Hours` decimal(45,2)
,`Pay` decimal(48,2)
,`ValueBikesFixed` double(19,2)
,`ValueWheelsFixed` double(19,2)
,`ValueNewPartsOnBikes` double(19,2)
,`EstimatedNetIncome` double(19,2)
,`EstimatedNetPerHour` double(23,6)
,`TotalBikesFixed` bigint(20)
,`TotalWheelsFixed` bigint(20)
,`HoursPerBike` decimal(45,1)
,`AverageBikeValue` double(18,1)
,`SalesBikes` double(19,2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`TotalSales` double(19,2)
,`TotalBikesSold` bigint(20)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_sales_by_week`
--
CREATE TABLE IF NOT EXISTS `view_sales_by_week` (
`Year` int(5)
,`Week` int(2)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`CountOfTrans` bigint(21)
,`AccountingGroup` varchar(45)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions`
--
CREATE TABLE IF NOT EXISTS `view_Transactions` (
`Year` int(4)
,`Month` int(2)
,`Quarter` int(1)
,`YearWeek` int(5)
,`Week` int(2)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`AccountingGroup` varchar(45)
,`ShopType` varchar(23)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_MechOper_byMonth`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_MechOper_byMonth` (
`Year` int(4)
,`Month` int(2)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`Count` bigint(21)
,`AccountingGroup` varchar(45)
,`ShopType` varchar(23)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_MechOper_byMonth_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_MechOper_byMonth_pvTbl` (
`Year` int(4)
,`Month` int(2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`SalesBikes` double(19,2)
,`ValueBikesFixed` double(19,2)
,`ValueWheelsFixed` double(19,2)
,`TotalBikesSold` bigint(20)
,`TotalBikesFixed` bigint(20)
,`TotalWheelsFixed` bigint(20)
,`ValueNewPartsOnBikes` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_MechOper_byQuarter`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_MechOper_byQuarter` (
`Year` int(4)
,`Quarter` int(1)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`Count` bigint(21)
,`AccountingGroup` varchar(45)
,`ShopType` varchar(23)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_MechOper_byQuarter_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_MechOper_byQuarter_pvTbl` (
`Year` int(4)
,`Quarter` int(1)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`SalesBikes` double(19,2)
,`ValueBikesFixed` double(19,2)
,`ValueWheelsFixed` double(19,2)
,`TotalBikesSold` bigint(20)
,`TotalBikesFixed` bigint(20)
,`TotalWheelsFixed` bigint(20)
,`ValueNewPartsOnBikes` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_MechOper_byWeek`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_MechOper_byWeek` (
`Year` int(5)
,`Week` int(2)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`Count` bigint(21)
,`AccountingGroup` varchar(45)
,`ShopType` varchar(23)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_MechOper_byWeek_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_MechOper_byWeek_pvTbl` (
`Year` int(5)
,`Week` int(2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`SalesBikes` double(19,2)
,`ValueBikesFixed` double(19,2)
,`ValueWheelsFixed` double(19,2)
,`TotalBikesSold` bigint(20)
,`TotalBikesFixed` bigint(20)
,`TotalWheelsFixed` bigint(20)
,`ValueNewPartsOnBikes` double(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_VolRunShop_byMonth`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_VolRunShop_byMonth` (
`Year` int(4)
,`Month` int(2)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`Count` bigint(21)
,`AccountingGroup` varchar(45)
,`ShopType` varchar(23)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_VolRunShop_byMonth_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_VolRunShop_byMonth_pvTbl` (
`Year` int(4)
,`Month` int(2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`SalesBikes` double(19,2)
,`TotalBikesSold` bigint(20)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_VolRunShop_byWeek`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_VolRunShop_byWeek` (
`Year` int(5)
,`Week` int(2)
,`TransactionType` varchar(45)
,`Total` double(19,2)
,`Count` bigint(21)
,`AccountingGroup` varchar(45)
,`ShopType` varchar(23)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_Transactions_VolRunShop_byWeek_pvTbl`
--
CREATE TABLE IF NOT EXISTS `view_Transactions_VolRunShop_byWeek_pvTbl` (
`Year` int(5)
,`Week` int(2)
,`NetSalesNewParts` double(19,2)
,`SalesUsedParts` double(19,2)
,`SalesBikes` double(19,2)
,`TotalBikesSold` bigint(20)
);
-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours`
--
DROP TABLE IF EXISTS `view_EmployeeHours`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours` AS select cast(`shop_hours`.`time_in` as date) AS `Date`,dayname(`shop_hours`.`time_in`) AS `DayName`,`contacts`.`contact_id` AS `ContactID`,concat(`contacts`.`last_name`,', ',`contacts`.`first_name`,' ',`contacts`.`middle_initial`) AS `Name`,`shop_hours`.`shop_user_role` AS `ShopUserRole`,`shop_hours`.`project_id` AS `Project`,round((timestampdiff(SECOND,`shop_hours`.`time_in`,`shop_hours`.`time_out`) / 3600),2) AS `Hours`,round((((timestampdiff(SECOND,`shop_hours`.`time_in`,`shop_hours`.`time_out`) / 3600) * 12) * 1.1),2) AS `Pay`,year(`shop_hours`.`time_in`) AS `Year`,quarter(`shop_hours`.`time_in`) AS `Quarter`,month(`shop_hours`.`time_in`) AS `Month`,if((week(`shop_hours`.`time_in`,0) <> 0),year(`shop_hours`.`time_in`),(year(`shop_hours`.`time_in`) - 1)) AS `YearWeek`,(((if((week(`shop_hours`.`time_in`,0) <> 0),week(`shop_hours`.`time_in`,0),53) - 1) DIV 2) + 1) AS `PayPeriod`,(((if((week(`shop_hours`.`time_in`,0) <> 0),week(`shop_hours`.`time_in`,0),53) - 1) % 2) + 1) AS `PayPeriodWeek`,if((week(`shop_hours`.`time_in`,0) <> 0),week(`shop_hours`.`time_in`,0),53) AS `Week` from ((`shop_hours` left join `contacts` on((`shop_hours`.`contact_id` = `contacts`.`contact_id`))) left join `shop_user_roles` on((`shop_hours`.`shop_user_role` = `shop_user_roles`.`shop_user_role_id`))) where (`shop_user_roles`.`paid` = 1) order by `shop_hours`.`time_in` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byMonth`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byMonth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byMonth` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`Month` AS `Month`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`Year`,`v`.`Month`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Month` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byMonth1_AllHours`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byMonth1_AllHours`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byMonth1_AllHours` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`Month` AS `Month`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`Year`,`v`.`Month`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Month` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byMonth1_NoSpProj`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byMonth1_NoSpProj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byMonth1_NoSpProj` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`Month` AS `Month`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_NoSpProj` `v` group by `v`.`Year`,`v`.`Month`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Month` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byMonth2`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byMonth2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byMonth2` AS select `eh1`.`Year` AS `Year`,`eh1`.`Quarter` AS `Quarter`,`eh1`.`Month` AS `Month`,`eh1`.`ContactID` AS `ContactID`,`eh1`.`Name` AS `Name`,`eh1`.`Hours` AS `Hours_All`,(`eh1`.`Hours` - `eh2`.`Hours`) AS `Hours_Spec`,`eh2`.`Hours` AS `Hours_NoSpec`,`eh1`.`Pay` AS `Pay_All`,(`eh1`.`Pay` - `eh2`.`Pay`) AS `Pay_Spec`,`eh2`.`Pay` AS `Pay_NoSpec` from (`view_EmployeeHours_byMonth1_AllHours` `eh1` left join `view_EmployeeHours_byMonth1_NoSpProj` `eh2` on(((`eh1`.`Year` = `eh2`.`Year`) and (`eh1`.`Month` = `eh2`.`Month`) and (`eh1`.`ContactID` = `eh2`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byMonth_WholeOper`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byMonth_WholeOper`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byMonth_WholeOper` AS select `v`.`Year` AS `Year`,`v`.`Month` AS `Month`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_WholeOper` `v` group by `v`.`Year`,`v`.`Month` order by `v`.`Year` desc,`v`.`Month` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byPayPeriod2`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byPayPeriod2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byPayPeriod2` AS select `view_EmployeeHours`.`YearWeek` AS `Year`,`view_EmployeeHours`.`PayPeriod` AS `PayPeriod`,`view_EmployeeHours`.`ContactID` AS `ContactID`,`view_EmployeeHours`.`Name` AS `Name`,sum(`view_EmployeeHours`.`Hours`) AS `Hours_All`,sum(`view_EmployeeHours`.`Pay`) AS `Pay_All` from `view_EmployeeHours` group by `view_EmployeeHours`.`YearWeek`,`view_EmployeeHours`.`PayPeriod`,`view_EmployeeHours`.`ContactID` order by `view_EmployeeHours`.`YearWeek` desc,`view_EmployeeHours`.`PayPeriod` desc,`view_EmployeeHours`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byQuarter`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byQuarter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byQuarter` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`Year`,`v`.`Quarter`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Quarter` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byQuarter1_AllHours`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byQuarter1_AllHours`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byQuarter1_AllHours` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`Year`,`v`.`Quarter`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Quarter` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byQuarter1_NoSpProj`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byQuarter1_NoSpProj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byQuarter1_NoSpProj` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_NoSpProj` `v` group by `v`.`Year`,`v`.`Quarter`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Quarter` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byQuarter2`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byQuarter2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byQuarter2` AS select `eh1`.`Year` AS `Year`,`eh1`.`Quarter` AS `Quarter`,`eh1`.`ContactID` AS `ContactID`,`eh1`.`Name` AS `Name`,`eh1`.`Hours` AS `Hours_All`,(`eh1`.`Hours` - `eh2`.`Hours`) AS `Hours_Spec`,`eh2`.`Hours` AS `Hours_NoSpec`,`eh1`.`Pay` AS `Pay_All`,(`eh1`.`Pay` - `eh2`.`Pay`) AS `Pay_Spec`,`eh2`.`Pay` AS `Pay_NoSpec` from (`view_EmployeeHours_byQuarter1_AllHours` `eh1` left join `view_EmployeeHours_byQuarter1_NoSpProj` `eh2` on(((`eh1`.`Year` = `eh2`.`Year`) and (`eh1`.`Quarter` = `eh2`.`Quarter`) and (`eh1`.`ContactID` = `eh2`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byQuarter_WholeOper`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byQuarter_WholeOper`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byQuarter_WholeOper` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_WholeOper` `v` group by `v`.`Year`,`v`.`Quarter` order by `v`.`Year` desc,`v`.`Quarter` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byWeek`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byWeek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byWeek` AS select `v`.`YearWeek` AS `Year`,`v`.`Week` AS `Week`,`v`.`PayPeriod` AS `PayPeriod`,`v`.`PayPeriodWeek` AS `PayPeriodWeek`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`YearWeek`,`v`.`Week`,`v`.`ContactID` order by `v`.`YearWeek` desc,`v`.`Week` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byWeek1_AllHours`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byWeek1_AllHours`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byWeek1_AllHours` AS select `v`.`YearWeek` AS `Year`,`v`.`Week` AS `Week`,`v`.`PayPeriod` AS `PayPeriod`,`v`.`PayPeriodWeek` AS `PayPeriodWeek`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`YearWeek`,`v`.`Week`,`v`.`ContactID` order by `v`.`YearWeek` desc,`v`.`Week` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byWeek1_NoSpProj`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byWeek1_NoSpProj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byWeek1_NoSpProj` AS select `v`.`YearWeek` AS `Year`,`v`.`Week` AS `Week`,`v`.`PayPeriod` AS `PayPeriod`,`v`.`PayPeriodWeek` AS `PayPeriodWeek`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_NoSpProj` `v` group by `v`.`YearWeek`,`v`.`Week`,`v`.`ContactID` order by `v`.`YearWeek` desc,`v`.`Week` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byWeek2`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byWeek2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byWeek2` AS select `eh1`.`Year` AS `Year`,`eh1`.`Week` AS `Week`,`eh1`.`PayPeriod` AS `PayPeriod`,`eh1`.`PayPeriodWeek` AS `PayPeriodWeek`,`eh1`.`ContactID` AS `ContactID`,`eh1`.`Name` AS `Name`,`eh1`.`Hours` AS `Hours_All`,(`eh1`.`Hours` - `eh2`.`Hours`) AS `Hours_Spec`,`eh2`.`Hours` AS `Hours_NoSpec`,`eh1`.`Pay` AS `Pay_All`,(`eh1`.`Pay` - `eh2`.`Pay`) AS `Pay_Spec`,`eh2`.`Pay` AS `Pay_NoSpec` from (`view_EmployeeHours_byWeek1_AllHours` `eh1` left join `view_EmployeeHours_byWeek1_NoSpProj` `eh2` on(((`eh1`.`Year` = `eh2`.`Year`) and (`eh1`.`Week` = `eh2`.`Week`) and (`eh1`.`ContactID` = `eh2`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byWeek_WholeOper`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byWeek_WholeOper`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byWeek_WholeOper` AS select `v`.`YearWeek` AS `Year`,`v`.`Week` AS `Week`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_WholeOper` `v` group by `v`.`YearWeek`,`v`.`Week` order by `v`.`YearWeek` desc,`v`.`Week` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byYear`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byYear`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byYear` AS select `v`.`Year` AS `Year`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`Year`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byYear1_AllHours`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byYear1_AllHours`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byYear1_AllHours` AS select `v`.`Year` AS `Year`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours` `v` group by `v`.`Year`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byYear1_NoSpProj`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byYear1_NoSpProj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byYear1_NoSpProj` AS select `v`.`Year` AS `Year`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_NoSpProj` `v` group by `v`.`Year`,`v`.`ContactID` order by `v`.`Year` desc,`v`.`Name`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byYear2`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byYear2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byYear2` AS select `eh1`.`Year` AS `Year`,`eh1`.`ContactID` AS `ContactID`,`eh1`.`Name` AS `Name`,`eh1`.`Hours` AS `Hours_All`,(`eh1`.`Hours` - `eh2`.`Hours`) AS `Hours_Spec`,`eh2`.`Hours` AS `Hours_NoSpec`,`eh1`.`Pay` AS `Pay_All`,(`eh1`.`Pay` - `eh2`.`Pay`) AS `Pay_Spec`,`eh2`.`Pay` AS `Pay_NoSpec` from (`view_EmployeeHours_byYear1_AllHours` `eh1` left join `view_EmployeeHours_byYear1_NoSpProj` `eh2` on(((`eh1`.`Year` = `eh2`.`Year`) and (`eh1`.`ContactID` = `eh2`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_byYear_WholeOper`
--
DROP TABLE IF EXISTS `view_EmployeeHours_byYear_WholeOper`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_byYear_WholeOper` AS select `v`.`Year` AS `Year`,sum(`v`.`Hours`) AS `Hours`,sum(`v`.`Pay`) AS `Pay` from `view_EmployeeHours_WholeOper` `v` group by `v`.`Year` order by `v`.`Year` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_NoSpProj`
--
DROP TABLE IF EXISTS `view_EmployeeHours_NoSpProj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_NoSpProj` AS select `v`.`Date` AS `Date`,`v`.`DayName` AS `DayName`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,`v`.`ShopUserRole` AS `ShopUserRole`,`v`.`Project` AS `Project`,`v`.`Hours` AS `Hours`,`v`.`Pay` AS `Pay`,`v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`Month` AS `Month`,`v`.`YearWeek` AS `YearWeek`,`v`.`PayPeriod` AS `PayPeriod`,`v`.`PayPeriodWeek` AS `PayPeriodWeek`,`v`.`Week` AS `Week` from `view_EmployeeHours` `v` where (`v`.`ShopUserRole` <> 'Paid Mechanic - Special Projects');

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeHours_WholeOper`
--
DROP TABLE IF EXISTS `view_EmployeeHours_WholeOper`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeHours_WholeOper` AS select `v`.`Date` AS `Date`,`v`.`DayName` AS `DayName`,`v`.`ContactID` AS `ContactID`,`v`.`Name` AS `Name`,`v`.`ShopUserRole` AS `ShopUserRole`,`v`.`Project` AS `Project`,`v`.`Hours` AS `Hours`,`v`.`Pay` AS `Pay`,`v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`Month` AS `Month`,`v`.`YearWeek` AS `YearWeek`,`v`.`PayPeriod` AS `PayPeriod`,`v`.`PayPeriodWeek` AS `PayPeriodWeek`,`v`.`Week` AS `Week` from `view_EmployeeHours` `v` where ((`v`.`ShopUserRole` = 'Paid Mechanic - Special Projects') or (`v`.`ShopUserRole` = 'Paid Mechanic'));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics1_AllTransactions`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics1_AllTransactions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics1_AllTransactions` AS select `t`.`date` AS `Date`,year(`t`.`date`) AS `Year`,quarter(`t`.`date`) AS `Quarter`,month(`t`.`date`) AS `Month`,if((week(`t`.`date`,0) <> 0),year(`t`.`date`),(year(`t`.`date`) - 1)) AS `YearWeek`,(((if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) - 1) DIV 2) + 1) AS `PayPeriod`,(((if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) - 1) % 2) + 1) AS `PayPeriodWeek`,if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) AS `Week`,`t`.`sold_by` AS `contact_id`,concat(`c`.`last_name`,', ',`c`.`first_name`,' ',`c`.`middle_initial`) AS `Name`,`t`.`transaction_type` AS `TransactionType`,`tt`.`accounting_group` AS `TransactionGroup`,`t`.`amount` AS `Value` from (((`transaction_log` `t` left join `transaction_types` `tt` on((`t`.`transaction_type` = `tt`.`transaction_type_id`))) left join `shops` `s` on((`t`.`shop_id` = `s`.`shop_id`))) left join `contacts` `c` on((`t`.`sold_by` = `c`.`contact_id`))) where (((`tt`.`accounting_group` = 'Sales') or (`tt`.`accounting_group` = 'Metrics')) and (`s`.`shop_type` = 'Mechanic Operation Shop')) order by year(`t`.`date`) desc,if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) desc,`t`.`sold_by`,`t`.`transaction_type`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics2_byMonth_AllTransactions`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics2_byMonth_AllTransactions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics2_byMonth_AllTransactions` AS select `em`.`Year` AS `Year`,`em`.`Quarter` AS `Quarter`,`em`.`Month` AS `Month`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,`em`.`TransactionType` AS `TransactionType`,`em`.`TransactionGroup` AS `TransactionGroup`,round(sum(`em`.`Value`),0) AS `Total`,count(`em`.`Value`) AS `Count`,round(avg(`em`.`Value`),0) AS `Average` from `view_EmployeeMetrics1_AllTransactions` `em` group by `em`.`Year`,`em`.`Month`,`em`.`contact_id`,`em`.`TransactionType` order by `em`.`Year` desc,`em`.`Month` desc,`em`.`contact_id`,`em`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics2_byWeek_AllTransactions`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics2_byWeek_AllTransactions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics2_byWeek_AllTransactions` AS select `em`.`YearWeek` AS `Year`,`em`.`Week` AS `Week`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,`em`.`TransactionType` AS `TransactionType`,`em`.`TransactionGroup` AS `TransactionGroup`,round(sum(`em`.`Value`),0) AS `Total`,count(`em`.`Value`) AS `Count`,round(avg(`em`.`Value`),0) AS `Average` from `view_EmployeeMetrics1_AllTransactions` `em` group by `em`.`YearWeek`,`em`.`Week`,`em`.`contact_id`,`em`.`TransactionType` order by `em`.`YearWeek` desc,`em`.`Week` desc,`em`.`contact_id`,`em`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics3a_byMonth_pvTbl`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics3a_byMonth_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics3a_byMonth_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`Month` AS `Month`,`v`.`contact_id` AS `contact_id`,`v`.`Name` AS `Name`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `NumBikesSold`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Total`,0)) AS `ValueBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - New Parts on a Completed Bike'),`v2`.`Total`,0)) AS `ValueNewPartsOnBikes`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Count`,0)) AS `NumBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Total`,0)) AS `ValueWheelsFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Count`,0)) AS `NumWheelsFixed` from (`view_EmployeeMetrics2_byMonth_AllTransactions` `v` left join `view_EmployeeMetrics2_byMonth_AllTransactions` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Month` = `v2`.`Month`) and (`v`.`contact_id` = `v2`.`contact_id`)))) group by `v`.`Year`,`v`.`Month`,`v`.`contact_id` order by `v`.`Year` desc,`v`.`Month` desc,`v`.`contact_id`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics3a_byWeek_pvTbl`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics3a_byWeek_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics3a_byWeek_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Week` AS `Week`,`v`.`contact_id` AS `contact_id`,`v`.`Name` AS `Name`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `NumBikesSold`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Total`,0)) AS `ValueBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - New Parts on a Completed Bike'),`v2`.`Total`,0)) AS `ValueNewPartsOnBikes`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Count`,0)) AS `NumBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Total`,0)) AS `ValueWheelsFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Count`,0)) AS `NumWheelsFixed` from (`view_EmployeeMetrics2_byWeek_AllTransactions` `v` left join `view_EmployeeMetrics2_byWeek_AllTransactions` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Week` = `v2`.`Week`) and (`v`.`contact_id` = `v2`.`contact_id`)))) group by `v`.`Year`,`v`.`Week`,`v`.`contact_id` order by `v`.`Year` desc,`v`.`Week` desc,`v`.`contact_id`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics3b_byQuarter`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics3b_byQuarter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics3b_byQuarter` AS select `em`.`Year` AS `Year`,`em`.`Quarter` AS `Quarter`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,sum(`em`.`NetSalesNewParts`) AS `NetSalesNewParts`,sum(`em`.`SalesUsedParts`) AS `SalesUsedParts`,sum(`em`.`SalesBikes`) AS `SalesBikes`,sum(`em`.`NumBikesSold`) AS `NumBikesSold`,sum(`em`.`ValueBikesFixed`) AS `ValueBikesFixed`,sum(`em`.`ValueNewPartsOnBikes`) AS `ValueNewPartsOnBikes`,sum(`em`.`NumBikesFixed`) AS `NumBikesFixed`,sum(`em`.`ValueWheelsFixed`) AS `ValueWheelsFixed`,sum(`em`.`NumWheelsFixed`) AS `NumWheelsFixed` from `view_EmployeeMetrics3a_byMonth_pvTbl` `em` group by `em`.`Year`,`em`.`Quarter`,`em`.`contact_id` order by `em`.`Year` desc,`em`.`Quarter` desc,`em`.`Name` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics3b_byYear`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics3b_byYear`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics3b_byYear` AS select `em`.`Year` AS `Year`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,sum(`em`.`NetSalesNewParts`) AS `NetSalesNewParts`,sum(`em`.`SalesUsedParts`) AS `SalesUsedParts`,sum(`em`.`SalesBikes`) AS `SalesBikes`,sum(`em`.`NumBikesSold`) AS `NumBikesSold`,sum(`em`.`ValueBikesFixed`) AS `ValueBikesFixed`,sum(`em`.`ValueNewPartsOnBikes`) AS `ValueNewPartsOnBikes`,sum(`em`.`NumBikesFixed`) AS `NumBikesFixed`,sum(`em`.`ValueWheelsFixed`) AS `ValueWheelsFixed`,sum(`em`.`NumWheelsFixed`) AS `NumWheelsFixed` from `view_EmployeeMetrics3a_byMonth_pvTbl` `em` group by `em`.`Year`,`em`.`contact_id` order by `em`.`Year` desc,`em`.`Name` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics4_byMonth_Calc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics4_byMonth_Calc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics4_byMonth_Calc` AS select `em`.`Year` AS `Year`,`em`.`Quarter` AS `Quarter`,`em`.`Month` AS `Month`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,round(`em`.`NetSalesNewParts`,1) AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,round(((`em`.`NetSalesNewParts` + `em`.`SalesUsedParts`) + `em`.`SalesBikes`),0) AS `TotalSales`,`em`.`NumBikesSold` AS `NumBikesSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`),2) AS `NetValueBikesFixed`,round((`em`.`ValueBikesFixed` / `em`.`NumBikesFixed`),0) AS `AverageValueBikesFixed`,round((`em`.`ValueNewPartsOnBikes` / `em`.`NumBikesFixed`),0) AS `AverageValueNewPartsOnBikes`,round(((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) / `em`.`NumBikesFixed`),0) AS `AverageNetValueBikesFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,round((`em`.`ValueWheelsFixed` / `em`.`NumWheelsFixed`),0) AS `AverageValueWheelsFixed` from `view_EmployeeMetrics3a_byMonth_pvTbl` `em`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics4_byQuarter_Calc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics4_byQuarter_Calc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics4_byQuarter_Calc` AS select `em`.`Year` AS `Year`,`em`.`Quarter` AS `Quarter`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,round(`em`.`NetSalesNewParts`,1) AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,round(((`em`.`NetSalesNewParts` + `em`.`SalesUsedParts`) + `em`.`SalesBikes`),0) AS `TotalSales`,`em`.`NumBikesSold` AS `NumBikesSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`),2) AS `NetValueBikesFixed`,round((`em`.`ValueBikesFixed` / `em`.`NumBikesFixed`),0) AS `AverageValueBikesFixed`,round((`em`.`ValueNewPartsOnBikes` / `em`.`NumBikesFixed`),0) AS `AverageValueNewPartsOnBikes`,round(((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) / `em`.`NumBikesFixed`),0) AS `AverageNetValueBikesFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,round((`em`.`ValueWheelsFixed` / `em`.`NumWheelsFixed`),0) AS `AverageValueWheelsFixed` from `view_EmployeeMetrics3b_byQuarter` `em`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics4_byWeek_Calc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics4_byWeek_Calc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics4_byWeek_Calc` AS select `em`.`Year` AS `Year`,`em`.`Week` AS `Week`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,round(`em`.`NetSalesNewParts`,1) AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,round(((`em`.`NetSalesNewParts` + `em`.`SalesUsedParts`) + `em`.`SalesBikes`),0) AS `TotalSales`,`em`.`NumBikesSold` AS `NumBikesSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`),2) AS `NetValueBikesFixed`,round((`em`.`ValueBikesFixed` / `em`.`NumBikesFixed`),0) AS `AverageValueBikesFixed`,round((`em`.`ValueNewPartsOnBikes` / `em`.`NumBikesFixed`),0) AS `AverageValueNewPartsOnBikes`,round(((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) / `em`.`NumBikesFixed`),0) AS `AverageNetValueBikesFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,round((`em`.`ValueWheelsFixed` / `em`.`NumWheelsFixed`),0) AS `AverageValueWheelsFixed` from `view_EmployeeMetrics3a_byWeek_pvTbl` `em`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics4_byYear_Calc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics4_byYear_Calc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics4_byYear_Calc` AS select `em`.`Year` AS `Year`,`em`.`contact_id` AS `contact_id`,`em`.`Name` AS `Name`,round(`em`.`NetSalesNewParts`,1) AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,round(((`em`.`NetSalesNewParts` + `em`.`SalesUsedParts`) + `em`.`SalesBikes`),0) AS `TotalSales`,`em`.`NumBikesSold` AS `NumBikesSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`),2) AS `NetValueBikesFixed`,round((`em`.`ValueBikesFixed` / `em`.`NumBikesFixed`),0) AS `AverageValueBikesFixed`,round((`em`.`ValueNewPartsOnBikes` / `em`.`NumBikesFixed`),0) AS `AverageValueNewPartsOnBikes`,round(((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) / `em`.`NumBikesFixed`),0) AS `AverageNetValueBikesFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,round((`em`.`ValueWheelsFixed` / `em`.`NumWheelsFixed`),0) AS `AverageValueWheelsFixed` from `view_EmployeeMetrics3b_byYear` `em`;

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics5_byMonth_HoursCalc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics5_byMonth_HoursCalc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics5_byMonth_HoursCalc` AS select `eh`.`Year` AS `Year`,`eh`.`Quarter` AS `Quarter`,`eh`.`Month` AS `Month`,`eh`.`ContactID` AS `ContactID`,`eh`.`Name` AS `Name`,`eh`.`Hours_All` AS `Hours_All`,`eh`.`Hours_Spec` AS `Hours_Spec`,`eh`.`Hours_NoSpec` AS `Hours_NoSpec`,`eh`.`Pay_All` AS `Pay_All`,`eh`.`Pay_Spec` AS `Pay_Spec`,`eh`.`Pay_NoSpec` AS `Pay_NoSpec`,`em`.`NetSalesNewParts` AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,`em`.`TotalSales` AS `TotalSales`,round((`em`.`TotalSales` / `eh`.`Hours_NoSpec`),2) AS `SalesPerHour`,`em`.`NumBikesSold` AS `NumBikesSold`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesSold`),2) AS `HoursPerBikeSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NetValueBikesFixed` AS `NetValueBikesFixed`,round((`em`.`NetValueBikesFixed` / `eh`.`Hours_NoSpec`),2) AS `NetValueBikesFixedPerHour`,`em`.`AverageValueBikesFixed` AS `AverageValueBikesFixed`,`em`.`AverageValueNewPartsOnBikes` AS `AverageValueNewPartsOnBikes`,`em`.`AverageNetValueBikesFixed` AS `AverageNetValueBikesFixed`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesFixed`),2) AS `HoursPerBikeFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,`em`.`AverageValueWheelsFixed` AS `AverageValueWheelsFixed`,round(((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) - `eh`.`Pay_NoSpec`) / `eh`.`Hours_NoSpec`),2) AS `NetProductionPerHour`,round((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) / `eh`.`Pay_NoSpec`),2) AS `NetProductionToPayValueRatio` from (`view_EmployeeHours_byMonth2` `eh` left join `view_EmployeeMetrics4_byMonth_Calc` `em` on(((`em`.`Year` = `eh`.`Year`) and (`em`.`Month` = `eh`.`Month`) and (`em`.`contact_id` = `eh`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics5_byQuarter_HoursCalc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics5_byQuarter_HoursCalc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics5_byQuarter_HoursCalc` AS select `eh`.`Year` AS `Year`,`eh`.`Quarter` AS `Quarter`,`eh`.`ContactID` AS `ContactID`,`eh`.`Name` AS `Name`,`eh`.`Hours_All` AS `Hours_All`,`eh`.`Hours_Spec` AS `Hours_Spec`,`eh`.`Hours_NoSpec` AS `Hours_NoSpec`,`eh`.`Pay_All` AS `Pay_All`,`eh`.`Pay_Spec` AS `Pay_Spec`,`eh`.`Pay_NoSpec` AS `Pay_NoSpec`,`em`.`NetSalesNewParts` AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,`em`.`TotalSales` AS `TotalSales`,round((`em`.`TotalSales` / `eh`.`Hours_NoSpec`),2) AS `SalesPerHour`,`em`.`NumBikesSold` AS `NumBikesSold`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesSold`),2) AS `HoursPerBikeSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NetValueBikesFixed` AS `NetValueBikesFixed`,round((`em`.`NetValueBikesFixed` / `eh`.`Hours_NoSpec`),2) AS `NetValueBikesFixedPerHour`,`em`.`AverageValueBikesFixed` AS `AverageValueBikesFixed`,`em`.`AverageValueNewPartsOnBikes` AS `AverageValueNewPartsOnBikes`,`em`.`AverageNetValueBikesFixed` AS `AverageNetValueBikesFixed`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesFixed`),2) AS `HoursPerBikeFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,`em`.`AverageValueWheelsFixed` AS `AverageValueWheelsFixed`,round(((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) - `eh`.`Pay_NoSpec`) / `eh`.`Hours_NoSpec`),2) AS `NetProductionPerHour`,round((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) / `eh`.`Pay_NoSpec`),2) AS `NetProductionToPayValueRatio` from (`view_EmployeeHours_byQuarter2` `eh` left join `view_EmployeeMetrics4_byQuarter_Calc` `em` on(((`em`.`Year` = `eh`.`Year`) and (`em`.`Quarter` = `eh`.`Quarter`) and (`em`.`contact_id` = `eh`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics5_byWeek_HoursCalc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics5_byWeek_HoursCalc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics5_byWeek_HoursCalc` AS select `eh`.`Year` AS `Year`,`eh`.`Week` AS `Week`,`eh`.`PayPeriod` AS `PayPeriod`,`eh`.`PayPeriodWeek` AS `PayPeriodWeek`,`eh`.`ContactID` AS `ContactID`,`eh`.`Name` AS `Name`,`eh`.`Hours_All` AS `Hours_All`,`eh`.`Hours_Spec` AS `Hours_Spec`,`eh`.`Hours_NoSpec` AS `Hours_NoSpec`,`eh`.`Pay_All` AS `Pay_All`,`eh`.`Pay_Spec` AS `Pay_Spec`,`eh`.`Pay_NoSpec` AS `Pay_NoSpec`,`em`.`NetSalesNewParts` AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,`em`.`TotalSales` AS `TotalSales`,round((`em`.`TotalSales` / `eh`.`Hours_NoSpec`),2) AS `SalesPerHour`,`em`.`NumBikesSold` AS `NumBikesSold`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesSold`),2) AS `HoursPerBikeSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NetValueBikesFixed` AS `NetValueBikesFixed`,round((`em`.`NetValueBikesFixed` / `eh`.`Hours_NoSpec`),2) AS `NetValueBikesFixedPerHour`,`em`.`AverageValueBikesFixed` AS `AverageValueBikesFixed`,`em`.`AverageValueNewPartsOnBikes` AS `AverageValueNewPartsOnBikes`,`em`.`AverageNetValueBikesFixed` AS `AverageNetValueBikesFixed`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesFixed`),2) AS `HoursPerBikeFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,`em`.`AverageValueWheelsFixed` AS `AverageValueWheelsFixed`,round(((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) - `eh`.`Pay_NoSpec`) / `eh`.`Hours_NoSpec`),2) AS `NetProductionPerHour`,round((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) / `eh`.`Pay_NoSpec`),2) AS `NetProductionToPayValueRatio` from (`view_EmployeeHours_byWeek2` `eh` left join `view_EmployeeMetrics4_byWeek_Calc` `em` on(((`em`.`Year` = `eh`.`Year`) and (`em`.`Week` = `eh`.`Week`) and (`em`.`contact_id` = `eh`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_EmployeeMetrics5_byYear_HoursCalc`
--
DROP TABLE IF EXISTS `view_EmployeeMetrics5_byYear_HoursCalc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_EmployeeMetrics5_byYear_HoursCalc` AS select `eh`.`Year` AS `Year`,`eh`.`ContactID` AS `ContactID`,`eh`.`Name` AS `Name`,`eh`.`Hours_All` AS `Hours_All`,`eh`.`Hours_Spec` AS `Hours_Spec`,`eh`.`Hours_NoSpec` AS `Hours_NoSpec`,`eh`.`Pay_All` AS `Pay_All`,`eh`.`Pay_Spec` AS `Pay_Spec`,`eh`.`Pay_NoSpec` AS `Pay_NoSpec`,`em`.`NetSalesNewParts` AS `NetSalesNewParts`,`em`.`SalesUsedParts` AS `SalesUsedParts`,`em`.`SalesBikes` AS `SalesBikes`,`em`.`TotalSales` AS `TotalSales`,round((`em`.`TotalSales` / `eh`.`Hours_NoSpec`),2) AS `SalesPerHour`,`em`.`NumBikesSold` AS `NumBikesSold`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesSold`),2) AS `HoursPerBikeSold`,`em`.`ValueBikesFixed` AS `ValueBikesFixed`,`em`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,`em`.`NetValueBikesFixed` AS `NetValueBikesFixed`,round((`em`.`NetValueBikesFixed` / `eh`.`Hours_NoSpec`),2) AS `NetValueBikesFixedPerHour`,`em`.`AverageValueBikesFixed` AS `AverageValueBikesFixed`,`em`.`AverageValueNewPartsOnBikes` AS `AverageValueNewPartsOnBikes`,`em`.`AverageNetValueBikesFixed` AS `AverageNetValueBikesFixed`,`em`.`NumBikesFixed` AS `NumBikesFixed`,round((`eh`.`Hours_NoSpec` / `em`.`NumBikesFixed`),2) AS `HoursPerBikeFixed`,`em`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`em`.`NumWheelsFixed` AS `NumWheelsFixed`,`em`.`AverageValueWheelsFixed` AS `AverageValueWheelsFixed`,round(((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) - `eh`.`Pay_NoSpec`) / `eh`.`Hours_NoSpec`),2) AS `NetProductionPerHour`,round((((`em`.`ValueBikesFixed` - `em`.`ValueNewPartsOnBikes`) + `em`.`ValueWheelsFixed`) / `eh`.`Pay_NoSpec`),2) AS `NetProductionToPayValueRatio` from (`view_EmployeeHours_byYear2` `eh` left join `view_EmployeeMetrics4_byYear_Calc` `em` on(((`em`.`Year` = `eh`.`Year`) and (`em`.`contact_id` = `eh`.`ContactID`))));

-- --------------------------------------------------------

--
-- Structure for view `view_MechanicOperationMetrics_byMonth`
--
DROP TABLE IF EXISTS `view_MechanicOperationMetrics_byMonth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_MechanicOperationMetrics_byMonth` AS select `Hours`.`Year` AS `Year`,`Hours`.`Month` AS `Month`,`Hours`.`Hours` AS `Hours`,`Hours`.`Pay` AS `Pay`,`Trans`.`ValueBikesFixed` AS `ValueBikesFixed`,`Trans`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`Trans`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,(((((`Trans`.`NetSalesNewParts` + `Trans`.`SalesUsedParts`) + `Trans`.`ValueBikesFixed`) + `Trans`.`ValueWheelsFixed`) - `Hours`.`Pay`) - `Trans`.`ValueNewPartsOnBikes`) AS `EstimatedNetIncome`,((((((`Trans`.`NetSalesNewParts` + `Trans`.`SalesUsedParts`) + `Trans`.`ValueBikesFixed`) + `Trans`.`ValueWheelsFixed`) - `Hours`.`Pay`) - `Trans`.`ValueNewPartsOnBikes`) / `Hours`.`Hours`) AS `EstimatedNetPerHour`,`Trans`.`TotalBikesFixed` AS `TotalBikesFixed`,`Trans`.`TotalWheelsFixed` AS `TotalWheelsFixed`,round((`Hours`.`Hours` / `Trans`.`TotalBikesFixed`),1) AS `HoursPerBike`,round((`Trans`.`ValueBikesFixed` / `Trans`.`TotalBikesFixed`),1) AS `AverageBikeValue`,`Trans`.`SalesBikes` AS `SalesBikes`,`Trans`.`NetSalesNewParts` AS `NetSalesNewParts`,`Trans`.`SalesUsedParts` AS `SalesUsedParts`,((`Trans`.`SalesBikes` + `Trans`.`NetSalesNewParts`) + `Trans`.`SalesUsedParts`) AS `TotalSales`,`Trans`.`TotalBikesSold` AS `TotalBikesSold` from (`view_EmployeeHours_byMonth_WholeOper` `Hours` left join `view_Transactions_MechOper_byMonth_pvTbl` `Trans` on(((`Hours`.`Year` = `Trans`.`Year`) and (`Hours`.`Month` = `Trans`.`Month`)))) order by `Hours`.`Year` desc,`Hours`.`Month` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_MechanicOperationMetrics_byQuarter`
--
DROP TABLE IF EXISTS `view_MechanicOperationMetrics_byQuarter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_MechanicOperationMetrics_byQuarter` AS select `Hours`.`Year` AS `Year`,`Hours`.`Quarter` AS `Quarter`,`Hours`.`Hours` AS `Hours`,`Hours`.`Pay` AS `Pay`,`Trans`.`ValueBikesFixed` AS `ValueBikesFixed`,`Trans`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`Trans`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,(((((`Trans`.`NetSalesNewParts` + `Trans`.`SalesUsedParts`) + `Trans`.`ValueBikesFixed`) + `Trans`.`ValueWheelsFixed`) - `Hours`.`Pay`) - `Trans`.`ValueNewPartsOnBikes`) AS `EstimatedNetIncome`,((((((`Trans`.`NetSalesNewParts` + `Trans`.`SalesUsedParts`) + `Trans`.`ValueBikesFixed`) + `Trans`.`ValueWheelsFixed`) - `Hours`.`Pay`) - `Trans`.`ValueNewPartsOnBikes`) / `Hours`.`Hours`) AS `EstimatedNetPerHour`,`Trans`.`TotalBikesFixed` AS `TotalBikesFixed`,`Trans`.`TotalWheelsFixed` AS `TotalWheelsFixed`,round((`Hours`.`Hours` / `Trans`.`TotalBikesFixed`),1) AS `HoursPerBike`,round((`Trans`.`ValueBikesFixed` / `Trans`.`TotalBikesFixed`),1) AS `AverageBikeValue`,`Trans`.`SalesBikes` AS `SalesBikes`,`Trans`.`NetSalesNewParts` AS `NetSalesNewParts`,`Trans`.`SalesUsedParts` AS `SalesUsedParts`,((`Trans`.`SalesBikes` + `Trans`.`NetSalesNewParts`) + `Trans`.`SalesUsedParts`) AS `TotalSales`,`Trans`.`TotalBikesSold` AS `TotalBikesSold` from (`view_EmployeeHours_byQuarter_WholeOper` `Hours` left join `view_Transactions_MechOper_byQuarter_pvTbl` `Trans` on(((`Hours`.`Year` = `Trans`.`Year`) and (`Hours`.`Quarter` = `Trans`.`Quarter`)))) order by `Hours`.`Year` desc,`Hours`.`Quarter` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_MechanicOperationMetrics_byWeek`
--
DROP TABLE IF EXISTS `view_MechanicOperationMetrics_byWeek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_MechanicOperationMetrics_byWeek` AS select `Hours`.`Year` AS `Year`,`Hours`.`Week` AS `Week`,`Hours`.`Hours` AS `Hours`,`Hours`.`Pay` AS `Pay`,`Trans`.`ValueBikesFixed` AS `ValueBikesFixed`,`Trans`.`ValueWheelsFixed` AS `ValueWheelsFixed`,`Trans`.`ValueNewPartsOnBikes` AS `ValueNewPartsOnBikes`,(((((`Trans`.`NetSalesNewParts` + `Trans`.`SalesUsedParts`) + `Trans`.`ValueBikesFixed`) + `Trans`.`ValueWheelsFixed`) - `Hours`.`Pay`) - `Trans`.`ValueNewPartsOnBikes`) AS `EstimatedNetIncome`,((((((`Trans`.`NetSalesNewParts` + `Trans`.`SalesUsedParts`) + `Trans`.`ValueBikesFixed`) + `Trans`.`ValueWheelsFixed`) - `Hours`.`Pay`) - `Trans`.`ValueNewPartsOnBikes`) / `Hours`.`Hours`) AS `EstimatedNetPerHour`,`Trans`.`TotalBikesFixed` AS `TotalBikesFixed`,`Trans`.`TotalWheelsFixed` AS `TotalWheelsFixed`,round((`Hours`.`Hours` / `Trans`.`TotalBikesFixed`),1) AS `HoursPerBike`,round((`Trans`.`ValueBikesFixed` / `Trans`.`TotalBikesFixed`),1) AS `AverageBikeValue`,`Trans`.`SalesBikes` AS `SalesBikes`,`Trans`.`NetSalesNewParts` AS `NetSalesNewParts`,`Trans`.`SalesUsedParts` AS `SalesUsedParts`,((`Trans`.`SalesBikes` + `Trans`.`NetSalesNewParts`) + `Trans`.`SalesUsedParts`) AS `TotalSales`,`Trans`.`TotalBikesSold` AS `TotalBikesSold` from (`view_EmployeeHours_byWeek_WholeOper` `Hours` left join `view_Transactions_MechOper_byWeek_pvTbl` `Trans` on(((`Hours`.`Year` = `Trans`.`Year`) and (`Hours`.`Week` = `Trans`.`Week`)))) order by `Hours`.`Year` desc,`Hours`.`Week` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_sales_by_week`
--
DROP TABLE IF EXISTS `view_sales_by_week`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_sales_by_week` AS select if((week(`t`.`date`,0) <> 0),year(`t`.`date`),(year(`t`.`date`) - 1)) AS `Year`,if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) AS `Week`,`t`.`transaction_type` AS `TransactionType`,round(sum(`t`.`amount`),2) AS `Total`,count(`t`.`transaction_id`) AS `CountOfTrans`,`transaction_types`.`accounting_group` AS `AccountingGroup` from ((`transaction_log` `t` left join `transaction_types` on((`t`.`transaction_type` = `transaction_types`.`transaction_type_id`))) left join `shops` on((`t`.`shop_id` = `shops`.`shop_id`))) where (`shops`.`shop_type` = 'Mechanic Operation Shop') group by `transaction_types`.`accounting_group`,`t`.`transaction_type`,year(`t`.`date`),quarter(`t`.`date`),month(`t`.`date`) order by if((week(`t`.`date`,0) <> 0),year(`t`.`date`),(year(`t`.`date`) - 1)) desc,if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) desc,`transaction_types`.`accounting_group`,`t`.`transaction_id`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions`
--
DROP TABLE IF EXISTS `view_Transactions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions` AS select year(`t`.`date`) AS `Year`,month(`t`.`date`) AS `Month`,quarter(`t`.`date`) AS `Quarter`,if((week(`t`.`date`,0) <> 0),year(`t`.`date`),(year(`t`.`date`) - 1)) AS `YearWeek`,if((week(`t`.`date`,0) <> 0),week(`t`.`date`,0),53) AS `Week`,`t`.`transaction_type` AS `TransactionType`,round(`t`.`amount`,2) AS `Total`,`transaction_types`.`accounting_group` AS `AccountingGroup`,if((`shops`.`shop_type` = 'Mechanic Operation Shop'),'Mechanic Operation Shop','Volunteer Run Shop') AS `ShopType` from ((`transaction_log` `t` left join `transaction_types` on((`t`.`transaction_type` = `transaction_types`.`transaction_type_id`))) left join `shops` on((`t`.`shop_id` = `shops`.`shop_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_MechOper_byMonth`
--
DROP TABLE IF EXISTS `view_Transactions_MechOper_byMonth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_MechOper_byMonth` AS select `v`.`Year` AS `Year`,`v`.`Month` AS `Month`,`v`.`TransactionType` AS `TransactionType`,sum(`v`.`Total`) AS `Total`,count(`v`.`Total`) AS `Count`,`v`.`AccountingGroup` AS `AccountingGroup`,`v`.`ShopType` AS `ShopType` from `view_Transactions` `v` where (`v`.`ShopType` = 'Mechanic Operation Shop') group by `v`.`Year`,`v`.`Month`,`v`.`TransactionType` order by `v`.`Year` desc,`v`.`Month` desc,`v`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_MechOper_byMonth_pvTbl`
--
DROP TABLE IF EXISTS `view_Transactions_MechOper_byMonth_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_MechOper_byMonth_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Month` AS `Month`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Total`,0)) AS `ValueBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Total`,0)) AS `ValueWheelsFixed`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `TotalBikesSold`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Count`,0)) AS `TotalBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Count`,0)) AS `TotalWheelsFixed`,max(if((`v2`.`TransactionType` = 'Metrics - New Parts on a Completed Bike'),`v2`.`Total`,0)) AS `ValueNewPartsOnBikes` from (`view_Transactions_MechOper_byMonth` `v` left join `view_Transactions_MechOper_byMonth` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Month` = `v2`.`Month`)))) group by `v`.`Year`,`v`.`Month` order by `v`.`Year` desc,`v`.`Month` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_MechOper_byQuarter`
--
DROP TABLE IF EXISTS `view_Transactions_MechOper_byQuarter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_MechOper_byQuarter` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,`v`.`TransactionType` AS `TransactionType`,sum(`v`.`Total`) AS `Total`,count(`v`.`Total`) AS `Count`,`v`.`AccountingGroup` AS `AccountingGroup`,`v`.`ShopType` AS `ShopType` from `view_Transactions` `v` where (`v`.`ShopType` = 'Mechanic Operation Shop') group by `v`.`Year`,`v`.`Quarter`,`v`.`TransactionType` order by `v`.`Year` desc,`v`.`Quarter` desc,`v`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_MechOper_byQuarter_pvTbl`
--
DROP TABLE IF EXISTS `view_Transactions_MechOper_byQuarter_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_MechOper_byQuarter_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Quarter` AS `Quarter`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Total`,0)) AS `ValueBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Total`,0)) AS `ValueWheelsFixed`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `TotalBikesSold`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Count`,0)) AS `TotalBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Count`,0)) AS `TotalWheelsFixed`,max(if((`v2`.`TransactionType` = 'Metrics - New Parts on a Completed Bike'),`v2`.`Total`,0)) AS `ValueNewPartsOnBikes` from (`view_Transactions_MechOper_byQuarter` `v` left join `view_Transactions_MechOper_byQuarter` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Quarter` = `v2`.`Quarter`)))) group by `v`.`Year`,`v`.`Quarter` order by `v`.`Year` desc,`v`.`Quarter` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_MechOper_byWeek`
--
DROP TABLE IF EXISTS `view_Transactions_MechOper_byWeek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_MechOper_byWeek` AS select `v`.`YearWeek` AS `Year`,`v`.`Week` AS `Week`,`v`.`TransactionType` AS `TransactionType`,sum(`v`.`Total`) AS `Total`,count(`v`.`Total`) AS `Count`,`v`.`AccountingGroup` AS `AccountingGroup`,`v`.`ShopType` AS `ShopType` from `view_Transactions` `v` where (`v`.`ShopType` = 'Mechanic Operation Shop') group by `v`.`YearWeek`,`v`.`Week`,`v`.`TransactionType` order by `v`.`YearWeek`,`v`.`Week`,`v`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_MechOper_byWeek_pvTbl`
--
DROP TABLE IF EXISTS `view_Transactions_MechOper_byWeek_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_MechOper_byWeek_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Week` AS `Week`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Total`,0)) AS `ValueBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Total`,0)) AS `ValueWheelsFixed`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `TotalBikesSold`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Bike'),`v2`.`Count`,0)) AS `TotalBikesFixed`,max(if((`v2`.`TransactionType` = 'Metrics - Completed Mechanic Operation Wheel'),`v2`.`Count`,0)) AS `TotalWheelsFixed`,max(if((`v2`.`TransactionType` = 'Metrics - New Parts on a Completed Bike'),`v2`.`Total`,0)) AS `ValueNewPartsOnBikes` from (`view_Transactions_MechOper_byWeek` `v` left join `view_Transactions_MechOper_byWeek` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Week` = `v2`.`Week`)))) group by `v`.`Year`,`v`.`Week` order by `v`.`Year` desc,`v`.`Week` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_VolRunShop_byMonth`
--
DROP TABLE IF EXISTS `view_Transactions_VolRunShop_byMonth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_VolRunShop_byMonth` AS select `v`.`Year` AS `Year`,`v`.`Month` AS `Month`,`v`.`TransactionType` AS `TransactionType`,sum(`v`.`Total`) AS `Total`,count(`v`.`Total`) AS `Count`,`v`.`AccountingGroup` AS `AccountingGroup`,`v`.`ShopType` AS `ShopType` from `view_Transactions` `v` where (`v`.`ShopType` = 'Volunteer Run Shop') group by `v`.`Year`,`v`.`Month`,`v`.`TransactionType` order by `v`.`Year`,`v`.`Month`,`v`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_VolRunShop_byMonth_pvTbl`
--
DROP TABLE IF EXISTS `view_Transactions_VolRunShop_byMonth_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_VolRunShop_byMonth_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Month` AS `Month`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `TotalBikesSold` from (`view_Transactions_VolRunShop_byMonth` `v` left join `view_Transactions_VolRunShop_byMonth` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Month` = `v2`.`Month`)))) group by `v`.`Year`,`v`.`Month`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_VolRunShop_byWeek`
--
DROP TABLE IF EXISTS `view_Transactions_VolRunShop_byWeek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_VolRunShop_byWeek` AS select `v`.`YearWeek` AS `Year`,`v`.`Week` AS `Week`,`v`.`TransactionType` AS `TransactionType`,sum(`v`.`Total`) AS `Total`,count(`v`.`Total`) AS `Count`,`v`.`AccountingGroup` AS `AccountingGroup`,`v`.`ShopType` AS `ShopType` from `view_Transactions` `v` where (`v`.`ShopType` = 'Volunteer Run Shop') group by `v`.`YearWeek`,`v`.`Week`,`v`.`TransactionType` order by `v`.`YearWeek`,`v`.`Week`,`v`.`TransactionType`;

-- --------------------------------------------------------

--
-- Structure for view `view_Transactions_VolRunShop_byWeek_pvTbl`
--
DROP TABLE IF EXISTS `view_Transactions_VolRunShop_byWeek_pvTbl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%.dyn.grandenetworks.net` SQL SECURITY DEFINER VIEW `view_Transactions_VolRunShop_byWeek_pvTbl` AS select `v`.`Year` AS `Year`,`v`.`Week` AS `Week`,round(max(if((`v2`.`TransactionType` = 'Sale - New Parts'),(`v2`.`Total` / 2),0)),2) AS `NetSalesNewParts`,max(if((`v2`.`TransactionType` = 'Sale - Used Parts'),`v2`.`Total`,0)) AS `SalesUsedParts`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Total`,0)) AS `SalesBikes`,max(if((`v2`.`TransactionType` = 'Sale - Complete Bike'),`v2`.`Count`,0)) AS `TotalBikesSold` from (`view_Transactions_VolRunShop_byWeek` `v` left join `view_Transactions_VolRunShop_byWeek` `v2` on(((`v`.`Year` = `v2`.`Year`) and (`v`.`Week` = `v2`.`Week`)))) group by `v`.`Year`,`v`.`Week`;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `location_type` FOREIGN KEY (`location_type`) REFERENCES `transaction_types` (`transaction_type_id`) ON UPDATE CASCADE;

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shop_location` FOREIGN KEY (`shop_location`) REFERENCES `shop_locations` (`shop_location_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `shop_type` FOREIGN KEY (`shop_type`) REFERENCES `shop_types` (`shop_type_id`) ON UPDATE CASCADE;

--
-- Constraints for table `shop_hours`
--
ALTER TABLE `shop_hours`
  ADD CONSTRAINT `contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `project_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `shop_user_role` FOREIGN KEY (`shop_user_role`) REFERENCES `shop_user_roles` (`shop_user_role_id`) ON UPDATE CASCADE;

--
-- Constraints for table `transaction_log`
--
ALTER TABLE `transaction_log`
  ADD CONSTRAINT `sold_by` FOREIGN KEY (`sold_by`) REFERENCES `contacts` (`contact_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sold_to` FOREIGN KEY (`sold_to`) REFERENCES `contacts` (`contact_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_type` FOREIGN KEY (`transaction_type`) REFERENCES `transaction_types` (`transaction_type_id`) ON UPDATE CASCADE;
