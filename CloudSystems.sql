USE [master]
GO
/****** Object:  Database [CloudSystems]    Script Date: 8/17/2017 7:54:31 AM ******/
CREATE DATABASE [CloudSystems] ON  PRIMARY 
( NAME = N'CloudSystems', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CloudSystems.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'CloudSystems_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CloudSystems_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CloudSystems] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CloudSystems].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CloudSystems] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CloudSystems] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CloudSystems] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CloudSystems] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CloudSystems] SET ARITHABORT OFF 
GO
ALTER DATABASE [CloudSystems] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CloudSystems] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CloudSystems] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CloudSystems] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CloudSystems] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CloudSystems] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CloudSystems] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CloudSystems] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CloudSystems] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CloudSystems] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CloudSystems] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CloudSystems] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CloudSystems] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CloudSystems] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CloudSystems] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CloudSystems] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CloudSystems] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CloudSystems] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CloudSystems] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CloudSystems] SET  MULTI_USER 
GO
ALTER DATABASE [CloudSystems] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CloudSystems] SET DB_CHAINING OFF 
GO
USE [CloudSystems]
GO
/****** Object:  Table [dbo].[AndroidDevice]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AndroidDevice](
	[deviceid] [varchar](50) NOT NULL,
	[imei1] [varchar](50) NULL,
	[imei2] [varchar](50) NULL,
	[status] [varchar](50) NULL,
	[seqno] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AndroidDevice] PRIMARY KEY CLUSTERED 
(
	[deviceid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FileIcons]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FileIcons](
	[iconid] [int] NOT NULL,
	[fileType] [varchar](50) NULL,
	[location] [varchar](max) NULL,
 CONSTRAINT [PK_FileIcons] PRIMARY KEY CLUSTERED 
(
	[iconid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Files]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Files](
	[fileid] [varchar](50) NOT NULL,
	[filename] [varchar](max) NULL,
	[owner] [varchar](50) NULL,
	[displayname] [varchar](max) NULL,
	[url] [varchar](max) NULL,
	[protection] [varchar](max) NULL,
	[password] [varchar](50) NULL,
	[extension] [varchar](50) NULL,
	[size] [varchar](50) NULL,
	[description] [varchar](max) NULL,
	[alerts] [varchar](50) NULL,
	[ontime] [datetime] NULL,
	[uploadtime] [varchar](50) NULL,
	[status] [int] NULL,
	[seq] [int] NULL,
	[parentid] [varchar](50) NULL,
 CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED 
(
	[fileid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FileTrack]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FileTrack](
	[ftid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NULL,
	[recid] [varchar](50) NULL,
	[fileid] [varchar](50) NULL,
	[encrykey] [varchar](max) NULL,
	[pass] [varchar](max) NULL,
	[ontime] [datetime] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_FileTrack] PRIMARY KEY CLUSTERED 
(
	[ftid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Messages](
	[msid] [int] IDENTITY(1,1) NOT NULL,
	[sender] [varchar](50) NULL,
	[receiver] [varchar](50) NULL,
	[message] [varchar](max) NULL,
	[ontime] [datetime] NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[msid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notifications](
	[notid] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NULL,
	[fromUser] [varchar](50) NULL,
	[recUser] [varchar](50) NULL,
	[fileid] [varchar](50) NULL,
	[ontime] [datetime] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[notid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Plans]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Plans](
	[planid] [int] IDENTITY(1,1) NOT NULL,
	[planname] [varchar](50) NULL,
	[price] [varchar](50) NULL,
	[features] [varchar](50) NULL,
	[special] [varchar](50) NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED 
(
	[planid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subscription](
	[subid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NULL,
	[planid] [int] NULL,
	[ontime] [datetime] NULL,
	[status] [nchar](10) NULL,
 CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED 
(
	[subid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDevice]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserDevice](
	[udid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NULL,
	[deviceid] [varchar](50) NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_UserDevice] PRIMARY KEY CLUSTERED 
(
	[udid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/17/2017 7:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[userid] [varchar](50) NOT NULL,
	[username] [varchar](max) NULL,
	[email] [varchar](50) NULL,
	[contact] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[seq] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (1, N'apk', N'img/icons/android.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (2, N'dll', N'img/icons/config.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (3, N'cpp', N'img/icons/cpp.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (4, N'doc', N'img/icons/doc.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (5, N'docx', N'img/icons/doc.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (6, N'exe', N'img/icons/exe.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (7, N'folder', N'img/icons/folder.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (8, N'html', N'img/icons/html.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (9, N'java', N'img/icons/java.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (10, N'jpg', N'img/icons/jpg.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (11, N'mp3', N'img/icons/mp3.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (12, N'pdf', N'img/icons/pdf.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (13, N'png', N'img/icons/png.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (14, N'ppt', N'img/icons/powerpoint.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (15, N'pptx', N'img/icons/powerpoint.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (16, N'rar', N'img/icons/rar.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (17, N'csv', N'img/icons/sheets.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (18, N'xlsx', N'img/icons/sheets.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (19, N'sql', N'img/icons/sql.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (20, N'txt', N'img/icons/txt.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (21, N'zip', N'img/icons/zip.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (22, N'php', N'img/icons/PHP.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (23, N'rar', N'img/icons/rar.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (24, N'bin', N'img/icons/zip.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (25, N'xml', N'img/icons/xml.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (26, N'xhtml', N'img/icons/xhtml.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (27, N'tmp', N'img/icons/tmp.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (28, N'3gp', N'img/icons/3gp.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (29, N'mkv', N'img/icons/mkv.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (30, N'mp4', N'img/icons/mpeg.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (31, N'mpeg', N'img/icons/mpeg.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (32, N'css', N'img/icons/css.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (33, N'bak', N'img/icons/backup.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (34, N'torrent', N'img/icons/torrent.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (35, N'm4v', N'img/icons/m4v.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (36, N'asf', N'img/icons/asf.png')
INSERT [dbo].[FileIcons] ([iconid], [fileType], [location]) VALUES (37, N'bmp', N'img/icons/bitmap.png')
USE [master]
GO
ALTER DATABASE [CloudSystems] SET  READ_WRITE 
GO
