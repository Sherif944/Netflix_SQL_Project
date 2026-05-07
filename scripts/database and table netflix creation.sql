/*
=========================
Create Database And Table 
=========================
Script Purpose:
This script creates a new database named 'NETFLIX' after checking if it already exists. 
If the database exists, it is dropped and recreated.

WARNING: 
Running this script will drop the entire 'NETFLIX' database if it exists. 
All data in the database will be permanently deleted. Proceed with caution 
and ensure you have proper backups before running this script.
*/

-- Create Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE NAME = 'NETFLIX')
BEGIN
	ALTER DATABASE NETFLIX SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE NETFLIX;
	END;
GO
CREATE DATABASE NETFLIX;

-- Creating table netflix_titles
USE DATABASE NETFLIX;
GO
DROP TABLE IF EXISTS netflix_titles;
GO
CREATE TABLE [dbo].[netflix_titles](
	[show_id] [nvarchar](6) NULL,
	[type] [nvarchar](10) NULL,
	[title] [nvarchar](200) NULL,
	[director] [nvarchar](210) NULL,
	[casts] [nvarchar](1000) NULL,
	[country] [nvarchar](200) NULL,
	[date_added] [nvarchar](50) NULL,
	[release_year] [nvarchar](50) NULL,
	[rating] [nvarchar](100) NULL,
	[duration] [nvarchar](100) NULL,
	[listed_in] [nvarchar](50) NULL,
	[description] [nvarchar](1000) NULL
) ON [PRIMARY]
GO


