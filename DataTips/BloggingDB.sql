USE [Blogging]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 1/20/2016 9:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Url] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_dbo.Blogs] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BlogPost]    Script Date: 1/20/2016 9:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPost](
	[BlogPostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](75) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[BlogId] [int] NOT NULL,
	[DateSubmitted] [datetime] NOT NULL CONSTRAINT [DF_BlogPost_DateSubmitted]  DEFAULT (getdate()),
 CONSTRAINT [PK_dbo.Posts] PRIMARY KEY CLUSTERED 
(
	[BlogPostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 1/20/2016 9:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](2000) NULL,
	[BlogPostId] [int] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Blog] ON 

GO
INSERT [dbo].[Blog] ([BlogId], [Name], [Url]) VALUES (1, N'The Visual Studio Blog', N'http://blogs.msdn.com/visualstudio/')
GO
INSERT [dbo].[Blog] ([BlogId], [Name], [Url]) VALUES (2, N'.NET Framework Blog', N'http://blogs.msdn.com/dotnet/')
GO
INSERT [dbo].[Blog] ([BlogId], [Name], [Url]) VALUES (3, N'My New Blog', N'http://www.softwaremasons.com/')
GO
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
SET IDENTITY_INSERT [dbo].[BlogPost] ON 

GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (1, N'Improving your build times with IncrediBuild and Visual Studio 2015', N'Lorem ipsum dolor sit amet, consectetur adipisicing
elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla pariatur.

', 1, CAST(N'2015-11-30 22:55:31.110' AS DateTime))
GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (2, N'Connect(“demos”); // 2015: HealthClinic.biz', N'Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor
sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 1, CAST(N'2015-12-08 22:55:31.110' AS DateTime))
GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (3, N'Support Ending for the .NET Framework 4, 4.5 and 4.5.1', N'Lorem ipsum dolor sit amet, consectetur adipisicing
elit, sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua.

Ut enim ad minim veniam, quis nostrud exercitation
ullamco laboris nisi ut aliquip ex ea commodo consequat.
', 2, CAST(N'2015-12-09 22:55:31.110' AS DateTime))
GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (4, N'Lists in Application Settings', N'Curabitur sit amet mauris. Morbi in dui quis est pulvinar ullamcorper. Nulla facilisi. Integer lacinia sollicitudin massa. Cras metus. Sed aliquet risus a tortor. Integer id quam. Morbi mi. Quisque nisl felis, venenatis tristique, dignissim in, ultrices sit amet, augue. Proin sodales libero eget ante. Nulla quam. ', 3, CAST(N'2015-12-13 22:55:31.110' AS DateTime))
GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (5, N'The .NET Journey: Recapping the last year', N'Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit.', 1, CAST(N'2015-12-10 22:55:31.110' AS DateTime))
GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (6, N'Installing the Unreal Engine in Visual Studio', N'Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh.', 1, CAST(N'2015-12-15 22:55:31.110' AS DateTime))
GO
INSERT [dbo].[BlogPost] ([BlogPostId], [Title], [Content], [BlogId], [DateSubmitted]) VALUES (7, N'The week in .NET - 12/15/2015', N'Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit.', 2, CAST(N'2015-12-15 22:55:31.110' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[BlogPost] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

GO
INSERT [dbo].[Comment] ([CommentId], [Content], [BlogPostId]) VALUES (1, N'Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit.', 1)
GO
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
ALTER TABLE [dbo].[BlogPost]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Posts_dbo.Blogs_BlogId] FOREIGN KEY([BlogId])
REFERENCES [dbo].[Blog] ([BlogId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogPost] CHECK CONSTRAINT [FK_dbo.Posts_dbo.Blogs_BlogId]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_BlogPost] FOREIGN KEY([BlogPostId])
REFERENCES [dbo].[BlogPost] ([BlogPostId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_BlogPost]
GO
