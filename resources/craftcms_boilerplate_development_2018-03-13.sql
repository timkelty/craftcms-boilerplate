# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: craftcms_boilerplate_development
# Generation Time: 2018-03-14 00:44:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_htmlForHead` text,
  `field_htmlForBody` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_htmlForHead`, `field_htmlForBody`)
VALUES
	(1,1,1,NULL,'2018-03-07 14:30:39','2018-03-07 18:43:03','9314058b-d418-4d9f-b4e8-f2de18b478b6',NULL,NULL),
	(2,2,1,NULL,'2018-03-07 16:08:11','2018-03-07 17:38:29','cc150e09-1855-4d80-9631-1127015dd931',NULL,NULL),
	(3,3,1,NULL,'2018-03-07 16:13:45','2018-03-08 19:20:53','e265dbf9-8b27-4a45-9e0d-f095c17973e6',NULL,NULL),
	(4,4,1,NULL,'2018-03-07 16:28:03','2018-03-07 18:43:30','4c9ec103-3582-476a-a864-7c0173ef415f',NULL,NULL),
	(5,5,1,NULL,'2018-03-07 16:28:28','2018-03-07 18:43:32','cc142e49-e548-4c33-a860-d894421cf4d9',NULL,NULL),
	(6,6,1,NULL,'2018-03-07 16:28:49','2018-03-07 18:43:36','65d5ec4e-1c24-451c-8f1c-95d5006900a5',NULL,NULL),
	(7,7,1,NULL,'2018-03-07 16:29:12','2018-03-07 18:43:25','b9404956-4384-48fd-aef1-1f95e340d48f',NULL,NULL),
	(8,8,1,NULL,'2018-03-07 16:29:49','2018-03-07 18:43:27','fb8d69a1-f1c7-4a47-8b3f-90542f1481bf',NULL,NULL),
	(9,9,1,NULL,'2018-03-07 16:30:04','2018-03-07 18:43:34','378df1bc-b38e-419a-ae2b-deef02920854',NULL,NULL),
	(10,10,1,NULL,'2018-03-07 16:30:27','2018-03-07 18:43:23','88a10486-42d9-47ba-93ba-ae2d61da4acb',NULL,NULL),
	(11,11,1,'Homepage','2018-03-07 16:37:34','2018-03-09 15:31:37','aa949c0b-b216-4a87-93e7-863f6fd85800',NULL,NULL),
	(12,12,1,'Page Not Found','2018-03-07 16:41:34','2018-03-08 19:34:26','05dfe31e-7716-4669-9f4e-9787322e0dc9',NULL,NULL);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2018-03-07 14:30:39','2018-03-07 18:43:03','ab6ef361-949b-4956-8d85-9dddb9c60ecd'),
	(2,2,'craft\\elements\\GlobalSet',1,0,'2018-03-07 16:08:11','2018-03-07 17:38:29','0c53295c-a22c-4e12-8992-25a0474b570c'),
	(3,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:13:45','2018-03-08 19:20:53','ca741dc5-c383-4a71-b57c-b54958a50171'),
	(4,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:28:03','2018-03-07 18:43:30','546298be-bf2f-4416-8498-f10345c3f1d8'),
	(5,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:28:28','2018-03-07 18:43:32','cc4ed0c4-a301-4dd6-9478-f6d9d8a7f9d6'),
	(6,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:28:49','2018-03-07 18:43:36','2af5e125-2f69-4f1c-9cff-98c8c9191d0b'),
	(7,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:29:12','2018-03-07 18:43:25','86ba7fb5-b181-4897-8460-805b2aa8c57a'),
	(8,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:29:49','2018-03-07 18:43:27','89a63c73-5d47-4c9c-a651-05809d5fb28a'),
	(9,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:30:04','2018-03-07 18:43:34','5f92e2f3-b669-458e-bbb4-3ceb0585777b'),
	(10,NULL,'craft\\elements\\User',1,0,'2018-03-07 16:30:27','2018-03-07 18:43:23','d9d2d3ba-1900-487b-98c1-f241d581f9b1'),
	(11,3,'craft\\elements\\Entry',1,0,'2018-03-07 16:37:34','2018-03-09 15:31:37','81ac3704-8f38-44d1-a434-f414f5a238aa'),
	(12,4,'craft\\elements\\Entry',1,0,'2018-03-07 16:41:34','2018-03-08 19:34:26','2a84659a-ed54-4b9f-90e2-7744ebce215e'),
	(13,1,'craft\\elements\\MatrixBlock',1,0,'2018-03-07 17:53:30','2018-03-09 15:31:37','dec83b1d-c87e-4d76-ba72-370b3eb7be59'),
	(14,1,'craft\\elements\\MatrixBlock',1,0,'2018-03-08 19:34:26','2018-03-08 19:34:26','bba23d63-be4b-4947-97a5-a585106abaa5');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  UNIQUE KEY `elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2018-03-07 14:30:39','2018-03-07 18:43:03','5af926aa-06fb-473e-ae7a-8896eff63bbc'),
	(2,2,1,NULL,NULL,1,'2018-03-07 16:08:11','2018-03-07 17:38:29','4abbdd02-b21b-4baf-b9a4-7a7b9a26722a'),
	(3,3,1,NULL,NULL,1,'2018-03-07 16:13:45','2018-03-08 19:20:53','57491130-5592-4cd0-95bd-e92a27c08252'),
	(4,4,1,NULL,NULL,1,'2018-03-07 16:28:03','2018-03-07 18:43:30','6afe5d73-4534-4a17-b026-75b2bdaefa99'),
	(5,5,1,NULL,NULL,1,'2018-03-07 16:28:28','2018-03-07 18:43:32','448dacf0-7ab9-49ee-9b4f-04a3325902e4'),
	(6,6,1,NULL,NULL,1,'2018-03-07 16:28:49','2018-03-07 18:43:36','b9a8134c-9d16-4e95-b581-ac3faeba7b36'),
	(7,7,1,NULL,NULL,1,'2018-03-07 16:29:12','2018-03-07 18:43:25','6d6220ef-6175-481f-9c97-7e8623d7f498'),
	(8,8,1,NULL,NULL,1,'2018-03-07 16:29:49','2018-03-07 18:43:27','0f88a99c-80e8-4285-a2ba-a80c30f169a8'),
	(9,9,1,NULL,NULL,1,'2018-03-07 16:30:04','2018-03-07 18:43:34','6756b512-31b5-4b91-b282-af394e4fb69e'),
	(10,10,1,NULL,NULL,1,'2018-03-07 16:30:27','2018-03-07 18:43:23','179bc9c5-f9f6-4b17-aa05-e3380cb29e32'),
	(11,11,1,'__home__','__home__',1,'2018-03-07 16:37:34','2018-03-09 15:31:37','2c44425e-0e47-486a-bcb8-d3cd0841e82b'),
	(12,12,1,'404','404',1,'2018-03-07 16:41:34','2018-03-08 19:34:26','4f08d348-4a14-45a3-b282-cdbba3ab62ba'),
	(13,13,1,NULL,NULL,1,'2018-03-07 17:53:30','2018-03-09 15:31:37','244d6c0a-99e3-4a59-a6f1-d40309614295'),
	(14,14,1,NULL,NULL,1,'2018-03-08 19:34:26','2018-03-08 19:34:26','c81f69d0-4d34-4157-9cb6-7f63f06081d5');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(11,1,1,NULL,'2018-03-07 16:37:00',NULL,'2018-03-07 16:37:34','2018-03-09 15:31:37','4f0667cb-09fe-42a7-95f5-e22e7a99e6b8'),
	(12,2,2,NULL,'2018-03-07 16:41:34',NULL,'2018-03-07 16:41:34','2018-03-08 19:34:26','f1e04d30-ffe6-47e3-90be-67806284d5ee');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,3,'Homepage','homepage',0,NULL,'{section.name|raw}',1,'2018-03-07 16:37:33','2018-03-09 15:31:36','38b80560-5feb-4c0d-873a-ac150d6ca207'),
	(2,2,4,'404','four04',1,'Title',NULL,1,'2018-03-07 16:41:34','2018-03-07 16:42:17','af9249c6-8b70-47f1-abd5-f47bd2a3bde9');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,12,2,3,1,1,'Revision from Mar 7, 2018, 9:46:49 AM','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"404\",\"slug\":\"404\",\"postDate\":1520440894,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"1\":[]}}','2018-03-07 17:53:14','2018-03-07 17:53:14','53420982-164d-41e2-9131-f5d35058fc21'),
	(2,12,2,3,1,2,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Page Not Found\",\"slug\":\"404\",\"postDate\":1520440894,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[]}}','2018-03-07 17:53:14','2018-03-07 17:53:14','c2d376a4-154d-4c9b-95bc-1c03f5e161c5'),
	(3,11,1,3,1,1,'Revision from Mar 7, 2018, 9:46:49 AM','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1520440653,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"1\":[]}}','2018-03-07 17:53:30','2018-03-07 17:53:30','98326ab7-d2c1-4a01-bb20-032cb779d623'),
	(4,11,1,3,1,2,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1520440653,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":{\"13\":{\"type\":\"richText\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"richText\":\"<p>Sample content…</p>\"}}}}}','2018-03-07 17:53:31','2018-03-07 17:53:31','3660d14a-20cf-46e4-8103-1ef6412c9908'),
	(5,11,1,3,1,3,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1520440653,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":{\"13\":{\"type\":\"richText\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"richText\":\"<p>Sample content…</p>\"}},\"14\":{\"type\":\"code\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"code\":\"# One tow\\r\\nasdfasdfas\\r\\ndfasfd\"}}}}}','2018-03-07 18:25:20','2018-03-07 18:25:20','38b3e928-1b08-45df-b48d-921f1331e3d5'),
	(6,11,1,3,1,4,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1520440653,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":{\"13\":{\"type\":\"richText\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"richText\":\"<p>Homepage content…</p>\"}}}}}','2018-03-08 19:34:12','2018-03-08 19:34:12','9cdb466d-c7fc-43e9-bfb2-104b78b413eb'),
	(7,12,2,3,1,3,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Page Not Found\",\"slug\":\"404\",\"postDate\":1520440894,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":{\"14\":{\"type\":\"richText\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"richText\":\"<p>404 Content…</p>\"}}}}}','2018-03-08 19:34:26','2018-03-08 19:34:26','c31ff627-3e20-463e-9b5e-159e238527bd'),
	(8,11,1,3,1,5,'','{\"typeId\":\"1\",\"authorId\":\"3\",\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1520440620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"13\":{\"type\":\"richText\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"richText\":\"<p>Homepage content…</p>\"}}}}}','2018-03-09 15:30:59','2018-03-09 15:30:59','00971436-28b6-416f-b0af-4dc912c54097'),
	(9,11,1,3,1,6,'','{\"typeId\":\"1\",\"authorId\":\"3\",\"title\":\"Homepage\",\"slug\":\"__home__\",\"postDate\":1520440620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"13\":{\"type\":\"richText\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"richText\":\"<p>Homepage content…</p>\"}}}}}','2018-03-09 15:31:05','2018-03-09 15:31:05','37b8aabd-817b-4ab9-876d-9c4288350d44');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2018-03-07 14:30:39','2018-03-07 14:30:39','0ce5cdda-d79a-4f2b-b8e2-4ac8889d7970'),
	(2,'Globals','2018-03-07 16:08:32','2018-03-07 16:08:32','7be39035-bef1-46bb-b560-998405f20e3d');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,4,2,1,0,1,'2018-03-07 16:42:17','2018-03-07 16:42:17','63f4a79a-fe66-4ea6-a13b-fd52ffbedda9'),
	(13,2,9,3,0,1,'2018-03-07 17:38:29','2018-03-07 17:38:29','9bd09d5e-169a-4973-840c-1465b759e843'),
	(14,2,9,4,0,2,'2018-03-07 17:38:29','2018-03-07 17:38:29','56676bd4-c867-4609-bc65-b4b2f8a535bb'),
	(19,1,14,2,1,1,'2018-03-07 18:28:13','2018-03-07 18:28:13','20c9dc2d-1f3d-4f21-9171-f040a9637889'),
	(20,3,15,1,0,1,'2018-03-09 15:31:36','2018-03-09 15:31:36','730214cf-d080-4b21-8f78-3ceef2e1a6c0');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\MatrixBlock','2018-03-07 15:52:38','2018-03-07 18:28:12','30dae3de-453a-4073-99d4-f76d46d26c98'),
	(2,'craft\\elements\\GlobalSet','2018-03-07 16:08:11','2018-03-07 17:38:29','d44f6ac9-16fc-44ee-a15a-94411b1de1db'),
	(3,'craft\\elements\\Entry','2018-03-07 16:37:33','2018-03-09 15:31:36','13e6bdcb-d76a-46bd-a3bb-71d63a10442d'),
	(4,'craft\\elements\\Entry','2018-03-07 16:41:34','2018-03-07 16:42:17','cb75c709-4b46-48d9-9a3c-f2c2ce0a4e51');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,4,'General',1,'2018-03-07 16:42:17','2018-03-07 16:42:17','22978dea-2029-4ac4-a74c-36c7aa04f63c'),
	(9,2,'HTML',1,'2018-03-07 17:38:29','2018-03-07 17:38:29','eab26158-ff31-448b-9078-ea7633adf5c8'),
	(14,1,'Content',1,'2018-03-07 18:28:13','2018-03-07 18:28:13','b6420551-0aae-4403-a0a7-8e9199f46181'),
	(15,3,'General',1,'2018-03-09 15:31:36','2018-03-09 15:31:36','05499535-559d-48cc-90b3-6dac98bc1b9c');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Content Matrix','contentMatrix','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-03-07 15:52:37','2018-03-07 18:28:12','8941e9a1-4bf1-4ad2-812f-782619ae4623'),
	(2,NULL,'Rich Text','richText','matrixBlockType:1','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Fusionary Default.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-03-07 15:52:37','2018-03-07 18:28:12','c00b3031-80f7-44a7-8737-7bfb01824f82'),
	(3,2,'HTML for <head>','htmlForHead','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"1\",\"initialRows\":\"10\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-03-07 16:16:51','2018-03-07 16:17:37','276ab887-31f8-4125-8ffe-93ed99bc49d8'),
	(4,2,'HTML for <body>','htmlForBody','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"1\",\"initialRows\":\"10\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-03-07 16:17:22','2018-03-07 16:17:22','7551c4e5-048c-44ca-b03c-0cdbe91dcf30');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;

INSERT INTO `globalsets` (`id`, `name`, `handle`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,'General','general',2,'2018-03-07 16:08:15','2018-03-07 17:38:29','863184f6-db1d-43c4-8c20-ab10dd983cc5');

/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.0-RC14','3.0.83',2,'America/Los_Angeles','Craft CMS Boilerplate',1,0,'g1x0dM5h2q8Q','2018-03-07 14:30:39','2018-03-07 18:28:13','1361372d-d2f8-4205-ac28-a55c4113adca');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;

INSERT INTO `matrixblocks` (`id`, `ownerId`, `ownerSiteId`, `fieldId`, `typeId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(13,11,NULL,1,1,1,'2018-03-07 17:53:31','2018-03-09 15:31:37','b9a6435e-d7cb-4479-a3ef-e658b91493de'),
	(14,12,NULL,1,1,1,'2018-03-08 19:34:26','2018-03-08 19:34:26','e259a92a-1023-4c0e-b3cc-2311df9624d7');

/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;

INSERT INTO `matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Rich Text','richText',1,'2018-03-07 15:52:37','2018-03-07 18:28:13','efe994f8-065d-493f-8e6e-9eb05bc8bbe4');

/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixcontent_contentmatrix
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixcontent_contentmatrix`;

CREATE TABLE `matrixcontent_contentmatrix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_richText_richText` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_contentmatrix_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_contentmatrix_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_contentmatrix_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_contentmatrix_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixcontent_contentmatrix` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentmatrix` DISABLE KEYS */;

INSERT INTO `matrixcontent_contentmatrix` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_richText_richText`)
VALUES
	(1,13,1,'2018-03-07 17:53:30','2018-03-09 15:31:37','550795d7-5f26-4010-996c-2dfd239af454','<p>Homepage content…</p>'),
	(2,14,1,'2018-03-08 19:34:26','2018-03-08 19:34:26','3b681154-52e8-49cd-af6d-c8f2f067b12f','<p>404 Content…</p>');

/*!40000 ALTER TABLE `matrixcontent_contentmatrix` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','af0ca3a4-8295-4c5a-ba0c-bca9f7eed418'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','01df50a4-0b20-4baa-b2bd-607fcc13bb3a'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a868018a-e9c6-47d9-bc34-cd2061dbd609'),
	(4,NULL,'app','m150403_184533_field_version','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','8331056c-7997-4688-9f7f-52f5a010c846'),
	(5,NULL,'app','m150403_184729_type_columns','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','dc4d9eb9-4eaf-442c-af36-cfcb8fa011ae'),
	(6,NULL,'app','m150403_185142_volumes','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','cd92c46f-95b8-4d84-ab76-d9ad67c25f57'),
	(7,NULL,'app','m150428_231346_userpreferences','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','545e270c-f76a-478e-8832-76d50ebe1704'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','fdee69bf-63b9-4758-b20c-9012b03e66b8'),
	(9,NULL,'app','m150617_213829_update_email_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','ffd2656f-1820-4dbb-93a4-5c1b73b33807'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','4cee7e41-f927-404d-818e-b3884a57cc2c'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','5346dbe5-2f0b-4b25-8c5e-0e296c431cb5'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','30ddd993-7255-4f9a-8169-a04a0eb34773'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','11bd4d37-cf93-4a89-8262-061e8ba62ddc'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','ff10acc9-d6bd-4a3b-b19f-7304b2a648cd'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','515f1608-b2e6-49b3-a830-bd1fed0d1f5f'),
	(16,NULL,'app','m151209_000000_move_logo','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','b6522de4-f57b-4cc2-8134-ac408ae5624c'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','919f2df6-4fa3-4a0f-a395-f2e50890e3d0'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','2c8f717f-d5ac-4055-90b8-f48b728112f9'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a0c40eb4-b882-4952-96e0-d37117823ed6'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','2a4e8ef6-051f-4ebf-b156-21a581ac939e'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','81d64ca1-267a-4e52-8d54-8faefe6c2943'),
	(22,NULL,'app','m160727_194637_column_cleanup','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','1680fd22-a022-4785-af55-9ae2b90831f9'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','4b7362ed-1738-4ea5-a2cc-384f4bedcd51'),
	(24,NULL,'app','m160807_144858_sites','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','ab68921b-16af-45cd-8634-b199d7abb062'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','679c772b-9a52-48f2-849a-c8cc65e95c5a'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','e8bb2af7-bd3a-4f73-9f87-58b5cadf899e'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','0ee1898e-69b1-403e-a2d5-d200cd707cf7'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','59c7e05c-aa41-4468-9df9-d0c811c75737'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','20c4f260-3a38-49c9-bbed-3851b0f017cb'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','26716e61-656b-4eff-a566-9056f40ea730'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','92a39da5-31fc-48ce-98ea-fb1d3fa76820'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','67a9b090-fd39-45e4-b5ef-a56d8ac2cca8'),
	(33,NULL,'app','m161007_130653_update_email_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','40c84c9d-0028-452d-97b8-93a60ae1de33'),
	(34,NULL,'app','m161013_175052_newParentId','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','e95237a9-88e1-4056-9c26-8c77bd20fab3'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','59bc95d8-687e-4697-a40f-304fc4a8c5c8'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','331485c1-99e8-4a13-aafe-5f0dfddca078'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','181b6e0c-5dec-40b3-b411-ab4d72d921f6'),
	(38,NULL,'app','m161029_124145_email_message_languages','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','70db3d35-f296-44f9-a4ae-8f25cbd19add'),
	(39,NULL,'app','m161108_000000_new_version_format','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','d8338792-d5b1-41b5-85a5-0dda0190db40'),
	(40,NULL,'app','m161109_000000_index_shuffle','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','292ec626-f8f6-4f42-aa78-a7843d9773e3'),
	(41,NULL,'app','m161122_185500_no_craft_app','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','fccf5730-1c72-4ac8-951a-d09cf518d3bd'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','6532aaaf-b834-4a01-8ac8-3bdae08b8406'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a278ba26-53b0-4a57-8d42-b9023be8f834'),
	(44,NULL,'app','m170114_161144_udates_permission','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','78cb51bf-b11b-43d8-abb8-df15e09be68a'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a63e2eae-cc75-461a-ab43-f16cb497ed28'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','c66ddcfe-f890-4dd3-803c-225353a0c2f5'),
	(47,NULL,'app','m170206_142126_system_name','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','fd74061b-5d57-43a8-957d-6ff73bfcc8b9'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','8f4210f0-e324-4358-a858-c1473447459c'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','6473acc3-bfad-4bf6-87b1-3bd3445234f2'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','67c53ec8-5e19-4ba9-8068-f60683812f20'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','4443f32b-b80c-49a1-aa35-e1f99a51520f'),
	(52,NULL,'app','m170228_171113_system_messages','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','83350eb9-bbf4-4838-ad1e-f4b767995fb0'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','e1f2de61-2ed1-4a35-a6fe-6b6a1d6b46d6'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','92e6860a-4784-4fb3-82f4-a90d81a23591'),
	(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a0f40603-adf9-4ed2-b06b-6d862c3c020d'),
	(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','f2f8f42f-6fac-4f8c-8d2a-396472b51f0e'),
	(57,NULL,'app','m170612_000000_route_index_shuffle','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a765d423-7416-4e5f-b794-47ad827ac2e5'),
	(58,NULL,'app','m170621_195237_format_plugin_handles','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','8c486f7a-57a2-41aa-9a2b-a3297d9d7f3f'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','0fef0976-5a0a-4fec-a054-d61262a3cae9'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','c1b7fe7a-c4a0-4297-bc85-1ad065f0ec74'),
	(61,NULL,'app','m170704_134916_sites_tables','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','8778a2ce-ebb3-4aa0-aca4-9b687a1cdbb6'),
	(62,NULL,'app','m170706_183216_rename_sequences','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','baa28969-6c1e-47cd-b10d-9a570eeb81ce'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','d2e7ceb6-6533-4875-9888-8da1eca1a8a8'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','8dd06e15-94e4-4e44-b419-baaa2be1d7f9'),
	(65,NULL,'app','m170810_201318_create_queue_table','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','408bf68d-6cf6-48f9-b060-1a4171ef0872'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','f6649d98-ca55-4490-93b6-bba8754ccabc'),
	(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','26d1e4b2-2977-47b5-b0b1-28e3bc8608ce'),
	(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','5ce1c49e-80e7-4a22-8d4e-a79daf414daa'),
	(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','0ead165c-d2d2-4edc-b760-85930fb0f327'),
	(70,NULL,'app','m171011_214115_site_groups','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','0cf86b5a-667f-4760-ad38-5adaec1e3312'),
	(71,NULL,'app','m171012_151440_primary_site','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','542c4603-7bb7-4081-ad10-867ae7476691'),
	(72,NULL,'app','m171013_142500_transform_interlace','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','0f211d68-c82c-4125-94bd-c83a417b5157'),
	(73,NULL,'app','m171016_092553_drop_position_select','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','51a5559d-746c-4580-b322-c4cad813176b'),
	(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','c536db49-187e-439a-973c-9d85d86f7ae4'),
	(75,NULL,'app','m171107_000000_assign_group_permissions','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','d95661e9-ec7f-42b3-ae54-9f2911f44dc9'),
	(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','4bf87756-b469-440d-b187-ad28e0d18e93'),
	(77,NULL,'app','m171126_105927_disabled_plugins','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a97ebf6d-3bf9-40b4-bb15-4f0fa4ad9cbb'),
	(78,NULL,'app','m171130_214407_craftidtokens_table','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','403a1c83-ff0e-4eb7-b971-22b8ce452e71'),
	(79,NULL,'app','m171202_004225_update_email_settings','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','c5672aa0-9fe5-43bd-a59b-3a7a22f65693'),
	(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','cb695ab3-8e1e-4aa9-8735-df8c8a9eda93'),
	(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','ffa6f204-bcdc-452e-9768-3ced2522c48b'),
	(82,NULL,'app','m171210_142046_fix_db_routes','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','8169748c-5680-421e-81c7-53eba66a5ecf'),
	(83,NULL,'app','m171218_143135_longtext_query_column','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','342ed6b2-b643-4061-8449-3ef7199b3921'),
	(84,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','d9198726-0c93-46f1-a462-0ee22b150256'),
	(85,NULL,'app','m180113_153740_drop_users_archived_column','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','a0dd94cf-61f4-4967-a9eb-7b1ebabfeb6e'),
	(86,NULL,'app','m180122_213433_propagate_entries_setting','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','c98aba2d-10ee-4214-806c-15320836365f'),
	(87,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','f4271133-f559-4859-b11c-5e09cd503949'),
	(88,NULL,'app','m180128_235202_set_tag_slugs','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','037f5722-e60e-40f0-acda-9978ceda8d55'),
	(89,NULL,'app','m180202_185551_fix_focal_points','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','67e5c616-ed48-4440-9260-0687637a774e'),
	(90,NULL,'app','m180217_172123_tiny_ints','2018-03-07 14:30:51','2018-03-07 14:30:51','2018-03-07 14:30:51','5a5426df-6828-4775-8f80-5c4d4ad23cc1'),
	(91,3,'plugin','Install','2018-03-07 15:44:54','2018-03-07 15:44:54','2018-03-07 15:44:54','dcbd5243-7d9f-4d6c-aa63-506ee99df31f');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `enabled`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'assetrev','6.0.0','1.0.0',NULL,'unknown',1,NULL,'2018-03-07 15:44:49','2018-03-07 15:44:49','2018-03-14 00:21:38','31b85648-3f6a-4ac6-b3c0-eaccf5a87676'),
	(2,'element-map','1.0.2','1.0.0',NULL,'unknown',1,NULL,'2018-03-07 15:44:52','2018-03-07 15:44:52','2018-03-14 00:21:38','31f2e911-0a6d-4e55-a23d-7328be2c02d2'),
	(3,'redactor','1.0.1','1.0.0',NULL,'unknown',1,NULL,'2018-03-07 15:44:54','2018-03-07 15:44:54','2018-03-14 00:21:38','f559a6b5-98fa-498e-9f45-7e56d3c46a51'),
	(5,'cp-field-inspect','1.0.2','1.0.0',NULL,'unknown',1,NULL,'2018-03-07 17:06:47','2018-03-07 17:06:47','2018-03-14 00:21:38','d23cc7a4-28c3-4a62-a636-9c5de3165b99'),
	(7,'mailgun','1.2.0','1.0.0',NULL,'unknown',1,NULL,'2018-03-07 17:11:25','2018-03-07 17:11:25','2018-03-14 00:21:38','aee53230-013c-4808-8192-b8c62b3b6d3a');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' admins fusionary com '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,''),
	(3,'username',0,1,' tkelty '),
	(3,'firstname',0,1,' tim '),
	(3,'lastname',0,1,' kelty '),
	(3,'fullname',0,1,' tim kelty '),
	(3,'email',0,1,' tim fusionary com '),
	(3,'slug',0,1,''),
	(4,'username',0,1,' kswedberg '),
	(4,'firstname',0,1,' karl '),
	(4,'lastname',0,1,' swedberg '),
	(4,'fullname',0,1,' karl swedberg '),
	(4,'email',0,1,' karl fusionary com '),
	(4,'slug',0,1,''),
	(5,'username',0,1,' rmcfadden '),
	(5,'firstname',0,1,' rob '),
	(5,'lastname',0,1,' mcfadden '),
	(5,'fullname',0,1,' rob mcfadden '),
	(5,'email',0,1,' rob fusionary com '),
	(5,'slug',0,1,''),
	(6,'username',0,1,' ssocie '),
	(6,'firstname',0,1,' stephanie '),
	(6,'lastname',0,1,' socie '),
	(6,'fullname',0,1,' stephanie socie '),
	(6,'email',0,1,' stephanie fusionary com '),
	(6,'slug',0,1,''),
	(7,'username',0,1,' ckloostra '),
	(7,'firstname',0,1,' casey '),
	(7,'lastname',0,1,' kloostra '),
	(7,'fullname',0,1,' casey kloostra '),
	(7,'email',0,1,' casey fusionary com '),
	(7,'slug',0,1,''),
	(8,'username',0,1,' jbaty '),
	(8,'firstname',0,1,' jack '),
	(8,'lastname',0,1,' baty '),
	(8,'fullname',0,1,' jack baty '),
	(8,'email',0,1,' jbaty fusionary com '),
	(8,'slug',0,1,''),
	(9,'username',0,1,' slewis '),
	(9,'firstname',0,1,' steve '),
	(9,'lastname',0,1,' lewis '),
	(9,'fullname',0,1,' steve lewis '),
	(9,'email',0,1,' steve fusionary com '),
	(9,'slug',0,1,''),
	(10,'username',0,1,' blewis '),
	(10,'firstname',0,1,' bryan '),
	(10,'lastname',0,1,' lewis '),
	(10,'fullname',0,1,' bryan lewis '),
	(10,'email',0,1,' bryan fusionary com '),
	(10,'slug',0,1,''),
	(11,'slug',0,1,' __home__ '),
	(11,'title',0,1,' homepage '),
	(12,'slug',0,1,' 404 '),
	(12,'title',0,1,' page not found '),
	(2,'field',3,1,''),
	(2,'field',4,1,''),
	(12,'field',1,1,' 404 content '),
	(11,'field',1,1,' homepage content '),
	(13,'field',2,1,' homepage content '),
	(13,'slug',0,1,''),
	(14,'field',2,1,' 404 content '),
	(14,'slug',0,1,'');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'Homepage','homepage','single',1,1,'2018-03-07 16:37:33','2018-03-09 15:31:36','e3ecef05-5a78-427b-a764-1953bef72514'),
	(2,NULL,'404','four04','single',1,1,'2018-03-07 16:41:34','2018-03-07 16:41:34','f1461f0a-af0c-48b6-acd1-9c6ace5f5f31');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'__home__','index',1,'2018-03-07 16:37:33','2018-03-09 15:31:36','bcc8e0f3-1cc1-4a98-a8a1-a9ee1429a0a2'),
	(2,2,1,1,'404','404',1,'2018-03-07 16:41:34','2018-03-07 16:41:34','deaf1aa9-8380-4e60-ab5b-1937691ff201');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,3,'m66v71x_X5Qmi3aogPt5K-InMW3mTfbyvE3n8wGgr9Cx6si2VAQhKfsQj65E_PQL16QAETDeBJD_qf9P_T_xWxhK6uSGZPVX52er','2018-03-07 16:27:02','2018-03-07 16:31:10','9702fbe7-ce75-4b7d-b121-6574a0da780e'),
	(3,3,'VhL_nZOuuHjcYSRa1McQngha6r70uUFuppbv9iBPoqKDoi6Shi4q96Fgv7IdQNLk5lw8XYjCr77x6YqqDzHLVJrn9LvDlHUtFcGv','2018-03-07 16:32:54','2018-03-07 18:54:31','733b06aa-fe06-4082-a57d-9d67ae0448dc'),
	(4,3,'QOMtv8uCtMvl7kKYz2NsM9dtodIbtgaNAF7jjSbJYThhCA6gH-3Pwu8ZM2TojH7lsQjM6g8llPnVeTM8lzxvanJtkdkBUCyttHhn','2018-03-08 19:21:20','2018-03-08 21:10:42','824152ab-5707-43a5-bec9-cc39172f5866'),
	(5,3,'NVubj9sGyw7OAVa7Bogz9XeCYzzisELNhXWDtQRnl8H2JfRDEy1Bbukn_qQGQR7bzUocPSTvOBzOXMA5I8M24wgMI-kTtH2f7rhp','2018-03-14 00:21:31','2018-03-14 00:21:42','88ccce25-7c6a-41a1-8a2e-d9de75e67201');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Craft CMS Boilerplate','2018-03-07 14:30:39','2018-03-07 14:30:39','7a3f6611-b706-4a72-8091-58fe15c25627');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Craft CMS Boilerplate','default','en-US',1,'',1,'2018-03-07 14:30:39','2018-03-07 14:32:02','93bfd514-01c8-465f-806c-2de043b7a5a2');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemsettings`;

CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;

INSERT INTO `systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"admins@fusionary.com\",\"fromName\":\"Craft CMS Boilerplate\",\"template\":\"\",\"transportType\":\"craft\\\\mailgun\\\\MailgunAdapter\",\"transportSettings\":{\"domain\":\"mg.fusionarydev.com\",\"apiKey\":\"key-23em94fbvw5o1ls82n31nfdrrd6nl4r7\"}}','2018-03-07 14:30:51','2018-03-09 15:33:07','298bf806-2c92-4a1e-b667-da45634923d0');

/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\",\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),
	(3,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),
	(4,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true}'),
	(5,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true}'),
	(6,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),
	(7,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),
	(8,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),
	(9,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),
	(10,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `client` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unq_idx` (`username`),
  UNIQUE KEY `users_email_unq_idx` (`email`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `client`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'admin',NULL,'','','admins@fusionary.com','$2y$13$x6fTMhe6Lrnf4AP4yq8M/OG/.kMUlLfpJMjh.Pjq9M9SHJqZb6Jq6',1,0,0,0,0,'2018-03-07 15:36:07','::1',NULL,NULL,'2018-03-07 15:35:21',NULL,NULL,NULL,NULL,1,'2018-03-07 14:30:42','2018-03-07 14:30:42','2018-03-07 18:43:03','086663f1-6db4-464f-8f21-ebcd16b9bed3'),
	(3,'tkelty',NULL,'Tim','Kelty','tim@fusionary.com','$2y$13$4Kwv/f9.JRqNupJ6TfXP5Ogg0VhJNZgt.2B8drqdVvJn40sFKJeRa',1,0,0,0,0,'2018-03-14 00:21:31','172.19.0.1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2018-03-08 19:20:56','2018-03-07 16:13:45','2018-03-14 00:21:31','1a3bd1d5-4dbd-4c90-b3f8-f841435c6832'),
	(4,'kswedberg',NULL,'Karl','Swedberg','karl@fusionary.com',NULL,1,0,0,0,0,'2018-03-07 16:31:54','::1',NULL,NULL,NULL,NULL,'$2y$13$e0l3jzm09/..TBsozBNlIuyDLmvFXyUeRSLSwVcnz6xeCKg5aEUY2','2018-03-08 20:10:53',NULL,1,NULL,'2018-03-07 16:28:03','2018-03-08 20:10:53','abcf8cd2-b19f-448b-a0db-fbfca8fb6c0a'),
	(5,'rmcfadden',NULL,'Rob','McFadden','rob@fusionary.com',NULL,1,0,0,0,0,'2018-03-07 16:31:10','::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2018-03-07 16:28:28','2018-03-07 18:43:32','14562530-621f-4d8a-bfcc-7ae835361647'),
	(6,'ssocie',NULL,'Stephanie','Socie','stephanie@fusionary.com',NULL,1,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'$2y$13$0ElOl6KcpWJwPZcpf8jgJO.7mVyjOkkJ/XXNgwPX74l1.4.IolAGq','2018-03-09 14:08:16',NULL,1,NULL,'2018-03-07 16:28:49','2018-03-09 14:08:16','59847505-9131-448c-9e03-3a6dd97bfaba'),
	(7,'ckloostra',NULL,'Casey','Kloostra','casey@fusionary.com',NULL,1,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2018-03-07 16:29:12','2018-03-07 18:43:25','085b3152-8b2f-4965-9e11-c979029a7343'),
	(8,'jbaty',NULL,'Jack','Baty','jbaty@fusionary.com',NULL,1,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2018-03-07 16:29:49','2018-03-07 18:43:27','eb184f4b-c77a-436a-8630-81a5af0380c9'),
	(9,'slewis',NULL,'Steve','Lewis','steve@fusionary.com',NULL,1,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2018-03-07 16:30:04','2018-03-07 18:43:34','ff5b8a88-b159-466a-9ad3-e9cd3f85980e'),
	(10,'blewis',NULL,'Bryan','Lewis','bryan@fusionary.com',NULL,1,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2018-03-07 16:30:27','2018-03-08 20:09:48','af3140d9-fda8-4a0a-a159-b1752d1767b6');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,NULL,'Temporary source',NULL,'2018-03-07 17:14:54','2018-03-07 17:14:54','bc535d64-a94a-4080-a294-c995d570695d'),
	(2,1,NULL,'user_3','user_3/','2018-03-07 17:14:54','2018-03-07 17:14:54','792477db-827a-45a0-b288-b74b0640129e');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-03-07 14:30:52','2018-03-07 14:30:52','b431c6ca-fe64-4db9-a163-7932ae85c41e'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-03-07 14:30:52','2018-03-07 14:30:52','9ce90de2-6701-433f-853c-ecb7cb8c68c7'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-03-07 14:30:52','2018-03-07 14:30:52','f1a2b499-9551-4298-baf0-85639e12a4bb'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-03-07 14:30:52','2018-03-07 14:30:52','9ea9b4ed-547f-41a1-aab5-d3326c514c9a'),
	(5,3,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-03-07 16:27:02','2018-03-07 16:27:02','797cace5-bd44-4869-82cd-7a30673a0502'),
	(6,3,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-03-07 16:27:02','2018-03-07 16:27:02','9e0e4527-84fc-43c6-bcff-5fcf722af3c6'),
	(7,3,'craft\\widgets\\Updates',3,0,'[]',1,'2018-03-07 16:27:02','2018-03-07 16:27:02','f91717a6-b5ef-48ae-b518-f3e228912e31'),
	(8,3,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-03-07 16:27:02','2018-03-07 16:27:02','dd69330f-e55c-4aaa-807e-69aa2b02d98e'),
	(9,5,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-03-07 16:31:11','2018-03-07 16:31:11','507c7363-dbaa-4424-a280-bce06a41940a'),
	(10,5,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-03-07 16:31:11','2018-03-07 16:31:11','cce27ef2-808a-4ae8-b012-e4b97d9d658f'),
	(11,5,'craft\\widgets\\Updates',3,0,'[]',1,'2018-03-07 16:31:11','2018-03-07 16:31:11','14e330b2-35c9-4285-90f5-d498e6fc91d8'),
	(12,5,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-03-07 16:31:11','2018-03-07 16:31:11','780cb49f-7c7f-46eb-abd6-431d244caa4c'),
	(13,4,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-03-07 16:31:54','2018-03-07 16:31:54','32500ccf-3c62-4664-bf67-3da80e989714'),
	(14,4,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-03-07 16:31:54','2018-03-07 16:31:54','1261945a-9d20-4554-94ce-b1e2fb3e500c'),
	(15,4,'craft\\widgets\\Updates',3,0,'[]',1,'2018-03-07 16:31:54','2018-03-07 16:31:54','a5bb5f83-be1f-456e-b255-3314fe6d0910'),
	(16,4,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-03-07 16:31:54','2018-03-07 16:31:54','54bbdac0-5175-41a5-8769-4df4b0266ed9');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
