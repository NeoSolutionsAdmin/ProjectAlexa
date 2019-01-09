USE [SistemaDispensario]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Tag](
@Nombre varchar(50),
@Icono varchar(5)
) as
BEGIN 
INSERT INTO Tags(Nombre, Icono) VALUES (@Nombre, @Icono)
END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Tag] (@Id bigint)
AS
BEGIN
DELETE Tags where Id=@Id
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_PacientesByTag](@IdTag bigint)
as
begin
select * from TagsPacientes where IdTag=@IdTag
end


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_TagsByPacientes](@IdPaciente bigint)
as
begin
select * from TagsPacientes where IdPaciente=@IdPaciente
end


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_TagToPaciente](
@IdPaciente bigint,
@IdTag bigint
) as
BEGIN 
INSERT INTO TagsPacientes(IdPaciente, IdTag) VALUES (@IdPaciente, @IdTag)
END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_TagDePaciente] (@IdPaciente bigint, @IdTag bigint)
AS
BEGIN
DELETE TagsPacientes where IdPaciente=@IdPaciente and IdTag=@IdTag
END
