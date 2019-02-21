USE [SistemaDispensario]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insertar_ComentarioPizarra] @IdPost bigint,
													@Comentario varchar(280),
													@IdProfesional bigint,
													@FechaCreacion varchar(50)
AS
BEGIN

INSERT INTO PizarraComentarios 
VALUES (@IdPost, @Comentario, @IdProfesional, CONVERT(date, @FechaCreacion, 120) )
SELECT Max(Id) from PizarraComentarios

END