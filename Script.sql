USE [master]
GO
/****** Object:  Database [MachineTestDB]    Script Date: 07/20/2021 16:39:26 ******/
CREATE DATABASE [MachineTestDB] ON  PRIMARY 
( NAME = N'MachineTestDB', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\MachineTestDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MachineTestDB_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\MachineTestDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MachineTestDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MachineTestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MachineTestDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [MachineTestDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [MachineTestDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [MachineTestDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [MachineTestDB] SET ARITHABORT OFF
GO
ALTER DATABASE [MachineTestDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [MachineTestDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [MachineTestDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [MachineTestDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [MachineTestDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [MachineTestDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [MachineTestDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [MachineTestDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [MachineTestDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [MachineTestDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [MachineTestDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [MachineTestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [MachineTestDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [MachineTestDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [MachineTestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [MachineTestDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [MachineTestDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [MachineTestDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [MachineTestDB] SET  READ_WRITE
GO
ALTER DATABASE [MachineTestDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [MachineTestDB] SET  MULTI_USER
GO
ALTER DATABASE [MachineTestDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [MachineTestDB] SET DB_CHAINING OFF
GO
USE [MachineTestDB]
GO
/****** Object:  Table [dbo].[FileMaster]    Script Date: 07/20/2021 16:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FileMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](1000) NULL,
	[CompanyID] [int] NULL,
 CONSTRAINT [PK_FileMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[FileMaster] ON
INSERT [dbo].[FileMaster] ([ID], [FileName], [CompanyID]) VALUES (1, N'ABSTRACT_06Oct2020.xls', 1)
SET IDENTITY_INSERT [dbo].[FileMaster] OFF
/****** Object:  Table [dbo].[CompanyMaster]    Script Date: 07/20/2021 16:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CompanyMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Status] [smallint] NULL,
 CONSTRAINT [PK_CompanyMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CompanyMaster] ON
INSERT [dbo].[CompanyMaster] ([ID], [Name], [Status]) VALUES (1, N'test', NULL)
INSERT [dbo].[CompanyMaster] ([ID], [Name], [Status]) VALUES (2, N'', NULL)
INSERT [dbo].[CompanyMaster] ([ID], [Name], [Status]) VALUES (3, N'', NULL)
INSERT [dbo].[CompanyMaster] ([ID], [Name], [Status]) VALUES (4, N'', NULL)
SET IDENTITY_INSERT [dbo].[CompanyMaster] OFF
/****** Object:  StoredProcedure [dbo].[usp_CompanyDetails]    Script Date: 07/20/2021 16:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[usp_CompanyDetails]
	 (
	 @flg int=0,
	 @compid int=0,
	 @compname varchar(50)='',
	 @filnm varchar(1000)='',
	 @sts int=0
	 )
AS
BEGIN
	 if @flg=1
	 BEGIn
	 declare @mxid as integer=0
		Insert into CompanyMaster(Name)
		values(@compname)
		
		select @mxid=MAX(ID) from CompanyMaster
		
		select @mxid
	 END
	 else if @flg=2
	 Begin
		
		
		Insert into FileMaster
		values(@filnm,@compid)
		
		
		
	 End
	 else if @flg=3
	 Begin
		select compmster.ID as cID,compmster.Name as compname,compmster.Status as compStatus,
		FileMaster.ID as fileId,FileMaster.FileName as Filenm from CompanyMaster as compmster JOIn FileMaster on compmster.ID=CompanyID
		
	 End
END
GO
