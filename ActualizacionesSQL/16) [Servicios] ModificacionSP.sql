USE [SistemaDispensario]
GO
/****** Object:  StoredProcedure [dbo].[Select_IdProfesionalesByIdServicios]    Script Date: 1/24/2019 7:31:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Select_IdProfesionalesByIdServicios](@IdServicio bigint)
as
begin
Select * from ProfesionalesServicios where IdServicio=@IdServicio
end
