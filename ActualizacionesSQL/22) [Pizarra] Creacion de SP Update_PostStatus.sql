USE [SistemaDispensario]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Update_PostStatus]( @Id bigint, @Estado varchar(20) )
AS
BEGIN
UPDATE PizarraPosts SET Estado = @Estado
WHERE Id=@Id
END