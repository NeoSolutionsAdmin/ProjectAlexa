USE [SistemaDispensario]
GO
/****** Object:  StoredProcedure [dbo].[Select_TagById]    Script Date: 20/01/2019 21:25:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_TagById](@Id bigint)
as
begin
select * from TagsPacientes where Id=@Id
end


SET ANSI_NULLS ON
