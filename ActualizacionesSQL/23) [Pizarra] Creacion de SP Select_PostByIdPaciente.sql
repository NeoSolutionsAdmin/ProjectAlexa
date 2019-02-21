USE [SistemaDispensario]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_PostByIdPaciente] @IdPaciente bigint
AS
BEGIN

SELECT * FROM PizarraPosts WHERE IdPaciente = @IdPaciente

END
