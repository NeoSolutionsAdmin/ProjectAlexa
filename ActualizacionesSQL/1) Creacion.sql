CREATE DATABASE SistemaDispensario
GO
USE [SistemaDispensario]
GO
/****** Object:  StoredProcedure [dbo].[Borrar_Medicacion]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Borrar_Medicacion](@Id bigint)
as
begin
delete MedicacionHabitual where Id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[Buscar_Paciente_By_Apellido]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Buscar_Paciente_By_Apellido](@CadenaBusqueda varchar(100))
as
begin
select *  from Pacientes where Apellido like '%' + @CadenaBusqueda + '%'
end

GO
/****** Object:  StoredProcedure [dbo].[CancelarConsulta]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[CancelarConsulta](@IdConsulta bigint)
as
begin
update Turnos set Estado='Cancelado' where Id=@IdConsulta
end

GO
/****** Object:  StoredProcedure [dbo].[ComenzarConsulta]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ComenzarConsulta](@IdConsulta bigint, @Hora varchar(50))
as
begin
update Turnos set HoraComienzoConsulta=Convert(datetime,@Hora,120), Estado='Progreso' where Id=@IdConsulta
end

GO
/****** Object:  StoredProcedure [dbo].[Delete_Toxicologia]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Toxicologia] (@Id bigint)
AS
BEGIN
DELETE AntecedentesToxicologicos where Id=@Id
END


GO
/****** Object:  StoredProcedure [dbo].[DerivarConsulta]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[DerivarConsulta](@IdConsulta bigint, @IdDerivado bigint, @Indicaciones text)
as
begin
update Turnos set IdDerivado=@IdDerivado, Estado='Derivado', Indicaciones=@Indicaciones where Id=@IdConsulta
end

GO
/****** Object:  StoredProcedure [dbo].[FinalizarConsulta]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[FinalizarConsulta](@IdConsulta bigint, @Hora varchar(50))
as
begin
update Turnos set HoraFinalConsulta=convert(datetime,@Hora,120),Estado='Finalizado' where Id=@IdConsulta
end

GO
/****** Object:  StoredProcedure [dbo].[Get_CIE10_by_Id]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_CIE10_by_Id](@Id bigint)
as
begin
select * from CIE10 where Id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[Insert_Alergia]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Alergia](@IdPaciente bigint, @Alergia varchar(255))
as
begin
insert into AntecedentesAlergias(IdPaciente,Alergia) values (@IdPaciente,@Alergia)
end

GO
/****** Object:  StoredProcedure [dbo].[Insert_APF]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Insert_APF](@IdPaciente bigint, @Patologia varchar(255))
as
begin
insert into AntecedentesPatologicosFamiliares(IdPaciente,Patologia) values (@IdPaciente,@Patologia)
end

GO
/****** Object:  StoredProcedure [dbo].[Insert_APP]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Insert_APP](@IdPaciente bigint, @Patologia varchar(255))
as
begin
insert into AntecedentesPatologicosPersonales(IdPaciente,Patologia) values (@IdPaciente,@Patologia)
end

GO
/****** Object:  StoredProcedure [dbo].[INSERT_DIAGNOSTICO]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_DIAGNOSTICO] (
@idPaciente bigint, 
@IdUser bigint,
@Fecha varchar(15),
@Diagnostico text)
as
begin
insert into Diagnosticos(IdPaciente,IdUser,Fecha,Diagnostico) values (@idPaciente,@IdUser,convert(datetime,@Fecha,120),@Diagnostico)
select  top 1 * from  Diagnosticos  order by Id DESC
end

GO
/****** Object:  StoredProcedure [dbo].[Insert_Diente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Diente](
@OdontogramaID varchar(100),
@DienteID bigint,
@Estado varchar(20)
) as 
begin
insert into Dientes(OdontogramaID, DienteID, Estado) values (@OdontogramaID, @DienteID, @Estado)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Paciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insert_Paciente](
@Apellido varchar(50),
@Nombre varchar(50),
@FechaNacimiento varchar(50),
@NroDocumento varchar(9),
@Domicilio varchar(255),
@Localidad varchar(255),
@Telefono varchar(15),
@IdObraSocial bigint,
@NroObraSocial varchar(255),
@Sexo varchar(50))
as
BEGIN
INSERT INTO [Pacientes]
           (
           [Apellido]
           ,[Nombre]
           ,[FechaNacimiento]
           ,[NroDocumento]
           ,Domicilio
           ,Localidad
           ,[Telefono]
           ,[IdObraSocial]
           ,NroObraSocial
           ,Sexo
           )
     VALUES
           (
           @Apellido,
           @Nombre,
           convert(date,@FechaNacimiento,120),
           @NroDocumento,
           @Domicilio,
           @Localidad,
           @Telefono,
           @IdObraSocial,
           @NroObraSocial,
           @Sexo
           
           )
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_SomatometriaByIdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_SomatometriaByIdPaciente](
@IdPaciente bigint

)
as
begin
insert into Somatometria(IdPaciente) values (@IdPaciente)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Toxicologia]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Toxicologia] (@IdPaciente bigint, @Toxicologia varchar(255))
AS
BEGIN
INSERT INTO AntecedentesToxicologicos(IdPaciente,Toxicologia) values (@IdPaciente, @Toxicologia)
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_Turno]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Turno](
@IdUser bigint, 
@PacienteID bigint, 
@HoraRecepcion varchar(50),
@HoraComienzoConsulta varchar(50),
@HoraFinalConsulta varchar(50))
as
begin
	Insert into Turnos(
	UserId,
	PacienteId,
	HoraRecepcion,
	HoraComienzoConsulta,
	HoraFinalConsulta,
	Estado,
	IdDerivado,
	Indicaciones
	) values (
	@IdUser,
	@PacienteID,
	convert(datetime,@HoraRecepcion,120),
	convert(datetime,@HoraComienzoConsulta,120),
	convert(datetime,@HoraFinalConsulta,120),
	'Espera',
	0,'Sin Indicaciones')
end

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Cirugia]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Insertar_Cirugia](@IdPaciente bigint, @Cirugia varchar(255))
as
begin
insert into AntecedentesCirugias(IdPaciente,Cirugia) values (@IdPaciente,@Cirugia)
end

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Medicacion]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Insertar_Medicacion](@IdPaciente bigint, @Medicacion varchar(255))
as
begin
insert into MedicacionHabitual(IdPaciente,Medicacion) values (@IdPaciente,@Medicacion)
end

GO
/****** Object:  StoredProcedure [dbo].[InsertarPeriodo_Cronograma_Entrada]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarPeriodo_Cronograma_Entrada]
(
@UserId bigint,
@EntradaJornada varchar(50)
) 
as 
begin 
insert into CronogramaLaboral(UserId,EntradaJornada) values (@UserId,Convert(datetime,@EntradaJornada,120))
end

GO
/****** Object:  StoredProcedure [dbo].[InsertarPeriodo_Cronograma_Salida]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarPeriodo_Cronograma_Salida]
(
@IdPeriodo bigint,
@SalidaJornada varchar(50),
@Horas decimal
) 
as 
begin 
Update CronogramaLaboral set SalidaJornada=Convert(Datetime,@SalidaJornada,120), Horas=@Horas where Id=@IdPeriodo
end

GO
/****** Object:  StoredProcedure [dbo].[InsertOdontograma]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertOdontograma](
@UserId bigint, 
@PacienteId bigint,
@UID varchar(50),
@Fecha varchar(50))
as
begin
insert into Odontogramas(UserId, PacienteId, UID, Fecha) values (@UserId,@PacienteId,@UID,convert(datetime,@Fecha,120))
select Top(1) * From Odontogramas order by Id Desc
end
GO
/****** Object:  StoredProcedure [dbo].[InsertRegistroC1]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertRegistroC1](@UserId bigint, @CantidadHoras bigint, @fechac1 varchar(50))
as
begin
insert into RegistroC1(UserId,CantidadHoras,fechaC1) values (@UserId,@CantidadHoras,convert(datetime,@fechac1,120))
end


GO
/****** Object:  StoredProcedure [dbo].[Search_ObrasSocial]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Search_ObrasSocial](@stringSearch varchar(255))
as
begin
select *  from ObrasSociales where Nombre like '%' + @stringSearch + '%' order by Nombre ASC
end

GO
/****** Object:  StoredProcedure [dbo].[SeleccionarPeriodo_Cronograma_Periodo]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeleccionarPeriodo_Cronograma_Periodo] 
(
@UserId bigint, 
@PeriodoStart varchar(50), 
@PeriodoEnd varchar(50)
)
as
begin
select * from CronogramaLaboral where UserId=@UserId and EntradaJornada between Convert(Datetime,@PeriodoStart,120) and Convert(Datetime,@PeriodoEnd,120)
end
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarPeriodo_Cronograma_Ultimo]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeleccionarPeriodo_Cronograma_Ultimo] (@UserId bigint)
as
begin
select top 1 * from CronogramaLaboral where UserId=@UserId order By Id Desc
end

GO
/****** Object:  StoredProcedure [dbo].[Select_AlergiasByIdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_AlergiasByIdPaciente](@idPaciente bigint)
as
begin
select * from AntecedentesAlergias where IdPaciente=@idPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_AllTurnosByIdUser]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_AllTurnosByIdUser](@IdUser bigint)
as
begin
select * from Turnos where UserId=@Iduser
end

GO
/****** Object:  StoredProcedure [dbo].[Select_APF]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_APF](@IdPaciente bigint)
as
begin
Select * from AntecedentesPatologicosFamiliares where IdPaciente=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_APP]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_APP](@IdPaciente bigint)
as
begin
Select * from AntecedentesPatologicosPersonales where IdPaciente=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_CirugiasByIdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Select_CirugiasByIdPaciente](@IdPaciente bigint)
as
begin
select * from AntecedentesCirugias where IdPaciente=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_Diagnostico_By_Id]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Diagnostico_By_Id](@id bigint)
as
begin
select * from Diagnosticos where Id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[Select_Diagnosticos_By_IdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Diagnosticos_By_IdPaciente](@IdPaciente bigint)
as
begin
select * from Diagnosticos where IdPaciente=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_DientesByKeyOdontograma]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_DientesByKeyOdontograma](@Key varchar(100))
as
begin
select * from Dientes where OdontogramaID = @Key
end
GO
/****** Object:  StoredProcedure [dbo].[Select_MedicacionHabitual]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_MedicacionHabitual](@IdPaciente bigint)
as
begin
Select * from MedicacionHabitual where IdPaciente=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_ObraSocial_By_ID]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_ObraSocial_By_ID](@IdObraSocial bigint)
as
begin
select * from ObrasSociales where Id=@IdObraSocial
end

GO
/****** Object:  StoredProcedure [dbo].[Select_OdontogramasByIdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_OdontogramasByIdPaciente](@IdPaciente bigint)
as
begin
select * from Odontogramas where PacienteId = @IdPaciente
end
GO
/****** Object:  StoredProcedure [dbo].[SELECT_PACIENTE_BY_DNI]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_PACIENTE_BY_DNI] (@DNI varchar(255))
as
begin
select * from Pacientes where NroDocumento=@DNI
end

GO
/****** Object:  StoredProcedure [dbo].[Select_Paciente_By_GUI]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Paciente_By_GUI](@GUI varchar(255))
as
begin
select * from Pacientes where [GUID]=@GUI
end

GO
/****** Object:  StoredProcedure [dbo].[Select_PacienteByID]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_PacienteByID](@IdPaciente bigint)
as
begin
select * from Pacientes where Id=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_Riesgo]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Riesgo](@Diabetes bit, @Sexo varchar(2),@Edad bigint, @Tabaquismo bit)
as
begin 
	select * from RiesgoCardiovascular where Diabetes=@Diabetes and Sexo=@Sexo and Edad=@Edad and Tabaquismo=@Tabaquismo
end

GO
/****** Object:  StoredProcedure [dbo].[Select_SomatometriaByIdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_SomatometriaByIdPaciente](@IdPaciente bigint)
as
begin
select * from Somatometria where IdPaciente=@IdPaciente
end
GO
/****** Object:  StoredProcedure [dbo].[Select_Toxicologia]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Toxicologia] (@IdPaciente bigint)
AS
begin
SELECT * FROM AntecedentesToxicologicos WHERE IdPaciente=@IdPaciente
end

GO
/****** Object:  StoredProcedure [dbo].[Select_TurnoById]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_TurnoById](@IdTurno bigint)
as
begin
select * from Turnos where Id=@IdTurno
end

GO
/****** Object:  StoredProcedure [dbo].[Select_Turnos_By_Period]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_Turnos_By_Period](@IdUser bigint, @Start varchar(50), @End varchar(50), @Estado varchar(50))
as
begin
select * from Turnos where UserId=@IdUser and Estado = @Estado and HoraFinalConsulta between convert(datetime,@Start,120) and convert(datetime,@End,120)
end

GO
/****** Object:  StoredProcedure [dbo].[SelectC1FromUserId]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectC1FromUserId](@UserId bigint)
as
begin
	select * from RegistroC1 where UserId=@UserId
end


GO
/****** Object:  StoredProcedure [dbo].[Update_Diagnostico_In_Turno]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Update_Diagnostico_In_Turno](@IdTurno bigint, @Diagnostico text,@CIE10 bigint, @ControlEmbarazo bit)
as
begin
update Turnos set DiagnosticoFinal=@Diagnostico, CIE10=@CIE10, ControlEmbarazo=@ControlEmbarazo where Id=@IdTurno
end

GO
/****** Object:  StoredProcedure [dbo].[Update_Paciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Paciente](
@Id bigint,
@Apellido varchar(50),
@Nombre varchar(50),
@FechaNacimiento varchar(50),
@NroDocumento varchar(9),
@Domicilio varchar(255),
@Localidad varchar(255),
@Telefono varchar(15),
@IdObraSocial bigint,
@NroObraSocial varchar(255),
@Sexo varchar(50)

) 
as
begin
Update Pacientes set 
Apellido=@Apellido, 
Nombre=@Nombre,
FechaNacimiento=convert(date,@FechaNacimiento,120),
NroDocumento = @NroDocumento,
Domicilio = @Domicilio,
Localidad = @Localidad,
Telefono = @Telefono,
IdObraSocial = @IdObraSocial,
NroObraSocial = @NroObraSocial,
Sexo = @Sexo
where
Id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[Update_SomatometriaByIdPaciente]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_SomatometriaByIdPaciente](
@IdPaciente bigint,
@IdUsuario bigint=NULL,
@Fecha varchar(50)=NULL,
@Peso decimal(18,2)=NULL,
@Talla decimal(18,2)=NULL,
@PASistolica bigint=NULL,
@PADiastolica bigint=NULL,
@IMC decimal(18,2)=NULL,
@Colesterol decimal(18,2)=NULL
)
as
begin
update Somatometria set 
IdUsuario=@IdUsuario,
FechaHora=@Fecha,
Peso=@Peso,
Talla=@Talla,
PASistolica=@PASistolica,
PADiastolica=@PADiastolica,
IMC=@IMC,
Colesterol=@Colesterol
 where IdPaciente=@IdPaciente
end
GO
/****** Object:  Table [dbo].[AntecedentesAlergias]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AntecedentesAlergias](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[Alergia] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AntecedentesAlergias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AntecedentesCirugias]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AntecedentesCirugias](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[Cirugia] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AntecedentesCirugias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AntecedentesPatologicosFamiliares]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AntecedentesPatologicosFamiliares](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[Patologia] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AntecedentesPatologicosFamiliares] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AntecedentesPatologicosPersonales]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AntecedentesPatologicosPersonales](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[Patologia] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AntecedentesPatologicosPersonales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AntecedentesToxicologicos]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AntecedentesToxicologicos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[Toxicologia] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AntecedentesToxicologicos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CIE10]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIE10](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [text] NOT NULL,
	[Etiqueta] [text] NOT NULL,
	[Counter] [bigint] NOT NULL,
 CONSTRAINT [PK_CIE10] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CronogramaLaboral]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CronogramaLaboral](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[EntradaJornada] [datetime] NOT NULL,
	[SalidaJornada] [datetime] NULL,
	[Horas] [decimal](4, 2) NULL,
 CONSTRAINT [PK_CronogramaLaboral] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Diagnosticos]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Diagnosticos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[HUID] [varchar](200) NOT NULL,
	[Diagnostico] [text] NOT NULL,
 CONSTRAINT [PK_Diagnosticos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dientes]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dientes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OdontogramaID] [varchar](100) NOT NULL,
	[DienteID] [bigint] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Dientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MedicacionHabitual]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MedicacionHabitual](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NOT NULL,
	[Medicacion] [varchar](255) NOT NULL,
 CONSTRAINT [PK_MedicacionHabitual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ObrasSociales]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ObrasSociales](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ObrasSociales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Odontogramas]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Odontogramas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PacienteId] [bigint] NOT NULL,
	[UID] [varchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Odontogramas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pacientes]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pacientes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GUID] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[NroDocumento] [varchar](9) NOT NULL,
	[Domicilio] [varchar](255) NOT NULL,
	[Localidad] [varchar](255) NOT NULL,
	[Telefono] [varchar](15) NOT NULL,
	[IdObraSocial] [bigint] NOT NULL,
	[NroObraSocial] [varchar](255) NOT NULL,
	[Sexo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Pacientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegistroC1]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistroC1](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[fechaC1] [datetime] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[CantidadHoras] [bigint] NOT NULL,
 CONSTRAINT [PK_RegistroC1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RiesgoCardiovascular]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiesgoCardiovascular](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Diabetes] [bit] NOT NULL,
	[Sexo] [varchar](2) NOT NULL,
	[Edad] [bigint] NOT NULL,
	[Tabaquismo] [bit] NOT NULL,
	[PAS] [bigint] NOT NULL,
	[Colesterol] [bigint] NOT NULL,
	[Riesgo] [varchar](2) NOT NULL,
 CONSTRAINT [PK_RiesgoCardiovascular] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Somatometria]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Somatometria](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [bigint] NULL,
	[IdUsuario] [nchar](10) NULL,
	[FechaHora] [datetime] NULL,
	[Peso] [decimal](18, 2) NULL,
	[Talla] [decimal](18, 2) NULL,
	[PASistolica] [bigint] NULL,
	[PADiastolica] [bigint] NULL,
	[IMC] [decimal](18, 2) NULL,
	[Colesterol] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Somatometria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Turnos]    Script Date: 1/7/2019 11:05:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Turnos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PacienteId] [bigint] NOT NULL,
	[HoraRecepcion] [datetime] NOT NULL,
	[HoraComienzoConsulta] [datetime] NOT NULL,
	[HoraFinalConsulta] [datetime] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
	[IdDerivado] [bigint] NOT NULL,
	[Indicaciones] [text] NOT NULL,
	[DiagnosticoFinal] [text] NULL,
	[CIE10] [bigint] NULL,
	[ControlEmbarazo] [bit] NULL,
 CONSTRAINT [PK_Turnos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AntecedentesAlergias] ON 

GO
INSERT [dbo].[AntecedentesAlergias] ([Id], [IdPaciente], [Alergia]) VALUES (1, 2, N'Antecedente Al. de prueba')
GO
SET IDENTITY_INSERT [dbo].[AntecedentesAlergias] OFF
GO
SET IDENTITY_INSERT [dbo].[AntecedentesCirugias] ON 

GO
INSERT [dbo].[AntecedentesCirugias] ([Id], [IdPaciente], [Cirugia]) VALUES (1, 2, N'AQ de prueba')
GO
INSERT [dbo].[AntecedentesCirugias] ([Id], [IdPaciente], [Cirugia]) VALUES (2, 1, N'hola')
GO
INSERT [dbo].[AntecedentesCirugias] ([Id], [IdPaciente], [Cirugia]) VALUES (10002, 1, N'asd')
GO
INSERT [dbo].[AntecedentesCirugias] ([Id], [IdPaciente], [Cirugia]) VALUES (10003, 1, N'asd3')
GO
SET IDENTITY_INSERT [dbo].[AntecedentesCirugias] OFF
GO
SET IDENTITY_INSERT [dbo].[AntecedentesPatologicosFamiliares] ON 

GO
INSERT [dbo].[AntecedentesPatologicosFamiliares] ([Id], [IdPaciente], [Patologia]) VALUES (1, 2, N'APF de prueba')
GO
SET IDENTITY_INSERT [dbo].[AntecedentesPatologicosFamiliares] OFF
GO
SET IDENTITY_INSERT [dbo].[AntecedentesPatologicosPersonales] ON 

GO
INSERT [dbo].[AntecedentesPatologicosPersonales] ([Id], [IdPaciente], [Patologia]) VALUES (1, 2, N'APP de prueba')
GO
INSERT [dbo].[AntecedentesPatologicosPersonales] ([Id], [IdPaciente], [Patologia]) VALUES (2, 1, N'Diabetes')
GO
INSERT [dbo].[AntecedentesPatologicosPersonales] ([Id], [IdPaciente], [Patologia]) VALUES (3, 2, N'diabetes mellitus tipo 2')
GO
SET IDENTITY_INSERT [dbo].[AntecedentesPatologicosPersonales] OFF
GO
SET IDENTITY_INSERT [dbo].[AntecedentesToxicologicos] ON 

GO
INSERT [dbo].[AntecedentesToxicologicos] ([Id], [IdPaciente], [Toxicologia]) VALUES (4, 1, N'hola')
GO
INSERT [dbo].[AntecedentesToxicologicos] ([Id], [IdPaciente], [Toxicologia]) VALUES (6, 1, N'cocaina')
GO
INSERT [dbo].[AntecedentesToxicologicos] ([Id], [IdPaciente], [Toxicologia]) VALUES (7, 1, N'tabaquismo')
GO
SET IDENTITY_INSERT [dbo].[AntecedentesToxicologicos] OFF
GO
SET IDENTITY_INSERT [dbo].[CronogramaLaboral] ON 

GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30002, 2, CAST(0x0000A9B200196B6C AS DateTime), CAST(0x0000A9B20019701C AS DateTime), CAST(0.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30003, 3, CAST(0x0000A9B200196DC4 AS DateTime), CAST(0x0000A9B200197274 AS DateTime), CAST(0.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30004, 2, CAST(0x0000A9B2004426E0 AS DateTime), CAST(0x0000A9B200442938 AS DateTime), CAST(0.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30005, 3, CAST(0x0000A9B200442B90 AS DateTime), CAST(0x0000A9B200442DE8 AS DateTime), CAST(0.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30006, 3, CAST(0x0000A9B2004464FC AS DateTime), CAST(0x0000A9B200594BC4 AS DateTime), CAST(-1.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30007, 3, CAST(0x0000A9B200594F48 AS DateTime), CAST(0x0000A9B200595074 AS DateTime), CAST(0.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[CronogramaLaboral] ([Id], [UserId], [EntradaJornada], [SalidaJornada], [Horas]) VALUES (30008, 2, CAST(0x0000A9B2005A963C AS DateTime), CAST(0x0000A9B2005AAC80 AS DateTime), CAST(0.00 AS Decimal(4, 2)))
GO
SET IDENTITY_INSERT [dbo].[CronogramaLaboral] OFF
GO
SET IDENTITY_INSERT [dbo].[Diagnosticos] ON 

GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (1, 1, 1, CAST(0x0000A84800000000 AS DateTime), N'924BD8A3-FD09-4D04-BAC0-FDBC5B201B69', N'asdasdasd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (2, 1, 2, CAST(0x0000A84800000000 AS DateTime), N'2829F1D1-D8B6-42A4-B553-A1ADBD68B026', N'Hola que tal')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (3, 1, 1, CAST(0x0000A84800000000 AS DateTime), N'1337B3E5-4ED9-4F28-B976-121C7601ED40', N'asd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (4, 1, 3, CAST(0x0000A84800000000 AS DateTime), N'EF93C6FE-6210-4F81-ADBB-1293B33AA9FD', N'asdasdasd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (5, 1, 3, CAST(0x0000A84800000000 AS DateTime), N'C884AE2A-0A0A-4968-8D35-596AE944EF23', N'hola papucho querido')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10002, 1, 2, CAST(0x0000A85D00000000 AS DateTime), N'168AC9AA-9D02-4354-85C2-D79F38C89CE1', N'asdasd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10003, 1, 2, CAST(0x0000A85D00000000 AS DateTime), N'6A735B9C-1B81-4ABA-9DBF-4E1AACE5ED21', N'asdasdasd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10004, 1, 1, CAST(0x0000A86500000000 AS DateTime), N'1FCF3EA9-2835-4D9B-A2AD-0D923C32BB37', N'*hola que tal*')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10005, 1, 1, CAST(0x0000A86500000000 AS DateTime), N'B1399D25-3A50-4804-95D4-033C77AD1559', N'hhhh *hh cool hh*')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10006, 1, 2, CAST(0x0000A86500000000 AS DateTime), N'59078129-0065-46D5-AF21-636C6C173646', N'mi mama *me mima* y asi esta bien')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10007, 1, 2, CAST(0x0000A86500000000 AS DateTime), N'E39F2BB8-4835-4B5A-BE01-C40DC5646A92', N'*para bien*')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10008, 1, 2, CAST(0x0000A86500000000 AS DateTime), N'1637CE0E-E8E7-4947-A966-AD64AFF07C15', N'hola que tal como estas...[LineJump]*y asi finalizamos*')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10009, 1, 2, CAST(0x0000A86500000000 AS DateTime), N'F563E381-45FB-417E-BD07-E1735B1D986E', N'estimulacion temprana[LineJump]*y ademas cosas*[LineJump]y finaliza aca')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10010, 1, 2, CAST(0x0000A86500000000 AS DateTime), N'21280B56-3229-4F18-ADA4-C869F9A8531B', N'Presenta problemas inmunologicos, vomitos mareos se le receta vacaciones...[LineJump]*posible caso de VIH*[LineJump]Tambien tiene las uñas de los pies largos')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10011, 1, 2, CAST(0x0000A86800000000 AS DateTime), N'9B68255E-3F02-4E03-B442-A3E1724DED6F', N'sajdhkjashdasd[LineJump]asdkjaklsjdasd[LineJump]alskdjalskjdlasd[LineJump]asldkjalksjdaklsjdasd[LineJump]laksdjlaksjdklasd[LineJump]asdjkalsjdlkaksdjlaskdjasd[LineJump]a;sklda;skd;alsdkal;sldkasd[LineJump]a;sldkalsjdlkajsldkajsdklasdlkasjdkalskdjasd[LineJump]a.ksdjkaljsdlaksjdklajskldjaksldjkajdkjalkdsajdhkjashdasd[LineJump]asdkjaklsjdasd[LineJump]alskdjalskjdlasd[LineJump]asldkjalksjdaklsjdasd[LineJump]laksdjlaksjdklasd[LineJump]asdjkalsjdlkaksdjlaskdjasd[LineJump]a;sklda;skd;alsdkal;sldkasd[LineJump]a;sldkalsjdlkajsldkajsdklasdlkasjdkalskdjasd[LineJump]a.ksdjkaljsdlaksjdklajskldjaksldjkajdkjalkdsajdhkjashdasd[LineJump]asdkjaklsjdasd[LineJump]alskdjalskjdlasd[LineJump]asldkjalksjdaklsjdasd[LineJump]laksdjlaksjdklasd[LineJump]asdjkalsjdlkaksdjlaskdjasd[LineJump]a;sklda;skd;alsdkal;sldkasd[LineJump]a;sldkalsjdlkajsldkajsdklasdlkasjdkalskdjasd[LineJump]a.ksdjkaljsdlaksjdklajskldjaksldjkajdkjalkdsajdhkjashdasd[LineJump]asdkjaklsjdasd[LineJump]alskdjalskjdlasd[LineJump]asldkjalksjdaklsjdasd[LineJump]laksdjlaksjdklasd[LineJump]asdjkalsjdlkaksdjlaskdjasd[LineJump]a;sklda;skd;alsdkal;sldkasd[LineJump]a;sldkalsjdlkajsldkajsdklasdlkasjdkalskdjasd[LineJump]a.ksdjkaljsdlaksjdklajskldjaksldjkajdkjalkdsajdhkjashdasd[LineJump]asdkjaklsjdasd[LineJump]alskdjalskjdlasd[LineJump]asldkjalksjdaklsjdasd[LineJump]laksdjlaksjdklasd[LineJump]asdjkalsjdlkaksdjlaskdjasd[LineJump]a;sklda;skd;alsdkal;sldkasd[LineJump]a;sldkalsjdlkajsldkajsdklasdlkasjdkalskdjasd[LineJump]a.ksdjkaljsdlaksjdklajskldjaksldjkajdkjalkd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10012, 2, 2, CAST(0x0000A86800000000 AS DateTime), N'2B6DAFE2-FD22-4BA6-BDEA-9497720F5CFE', N'Cool things')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10013, 1, 2, CAST(0x0000A86900000000 AS DateTime), N'070D5BCD-A518-46F3-9635-1203F6C0D293', N'asd')
GO
INSERT [dbo].[Diagnosticos] ([Id], [IdPaciente], [IdUser], [Fecha], [HUID], [Diagnostico]) VALUES (10014, 2, 2, CAST(0x0000A89F00000000 AS DateTime), N'F02D0B18-C647-4E4E-A82B-396807AB88EA', N'Prueba  2')
GO
SET IDENTITY_INSERT [dbo].[Diagnosticos] OFF
GO
SET IDENTITY_INSERT [dbo].[Dientes] ON 

GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (1, N'c5432196-3692-4976-b3b7-4b46725d6b74', 18, N'bbbbrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (2, N'c5432196-3692-4976-b3b7-4b46725d6b74', 17, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (3, N'c5432196-3692-4976-b3b7-4b46725d6b74', 16, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (4, N'c5432196-3692-4976-b3b7-4b46725d6b74', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (5, N'c5432196-3692-4976-b3b7-4b46725d6b74', 14, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (6, N'c5432196-3692-4976-b3b7-4b46725d6b74', 13, N'xxxxxxb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (7, N'c5432196-3692-4976-b3b7-4b46725d6b74', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (8, N'c5432196-3692-4976-b3b7-4b46725d6b74', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (9, N'c5432196-3692-4976-b3b7-4b46725d6b74', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10, N'c5432196-3692-4976-b3b7-4b46725d6b74', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (11, N'c5432196-3692-4976-b3b7-4b46725d6b74', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (12, N'c5432196-3692-4976-b3b7-4b46725d6b74', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (13, N'c5432196-3692-4976-b3b7-4b46725d6b74', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (14, N'c5432196-3692-4976-b3b7-4b46725d6b74', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (15, N'c5432196-3692-4976-b3b7-4b46725d6b74', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (16, N'c5432196-3692-4976-b3b7-4b46725d6b74', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (17, N'c5432196-3692-4976-b3b7-4b46725d6b74', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (18, N'c5432196-3692-4976-b3b7-4b46725d6b74', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (19, N'c5432196-3692-4976-b3b7-4b46725d6b74', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20, N'c5432196-3692-4976-b3b7-4b46725d6b74', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (21, N'c5432196-3692-4976-b3b7-4b46725d6b74', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (22, N'c5432196-3692-4976-b3b7-4b46725d6b74', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (23, N'c5432196-3692-4976-b3b7-4b46725d6b74', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (24, N'c5432196-3692-4976-b3b7-4b46725d6b74', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (25, N'c5432196-3692-4976-b3b7-4b46725d6b74', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (26, N'c5432196-3692-4976-b3b7-4b46725d6b74', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (27, N'c5432196-3692-4976-b3b7-4b46725d6b74', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (28, N'c5432196-3692-4976-b3b7-4b46725d6b74', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (29, N'c5432196-3692-4976-b3b7-4b46725d6b74', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (30, N'c5432196-3692-4976-b3b7-4b46725d6b74', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (31, N'c5432196-3692-4976-b3b7-4b46725d6b74', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (32, N'c5432196-3692-4976-b3b7-4b46725d6b74', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (33, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 18, N'bbbbrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (34, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 17, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (35, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 16, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (36, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (37, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 14, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (38, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 13, N'xxxxxxb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (39, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (40, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (41, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (42, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (43, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (44, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (45, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (46, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (47, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (48, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (49, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (50, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (51, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (52, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (53, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (54, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (55, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (56, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (57, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (58, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (59, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (60, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (61, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (62, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (63, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (64, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (65, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 18, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (66, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 17, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (67, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 16, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (68, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (69, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (70, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (71, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (72, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (73, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (74, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (75, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (76, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (77, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (78, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (79, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (80, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (81, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (82, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (83, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (84, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (85, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (86, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (87, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (88, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (89, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (90, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (91, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (92, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (93, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (94, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (95, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (96, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (97, N'9055141f-e799-4107-a9e9-3162ae76bf58', 18, N'rrrrrrr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (98, N'9055141f-e799-4107-a9e9-3162ae76bf58', 17, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (99, N'9055141f-e799-4107-a9e9-3162ae76bf58', 16, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (100, N'9055141f-e799-4107-a9e9-3162ae76bf58', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (101, N'9055141f-e799-4107-a9e9-3162ae76bf58', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (102, N'9055141f-e799-4107-a9e9-3162ae76bf58', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (103, N'9055141f-e799-4107-a9e9-3162ae76bf58', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (104, N'9055141f-e799-4107-a9e9-3162ae76bf58', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (105, N'9055141f-e799-4107-a9e9-3162ae76bf58', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (106, N'9055141f-e799-4107-a9e9-3162ae76bf58', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (107, N'9055141f-e799-4107-a9e9-3162ae76bf58', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (108, N'9055141f-e799-4107-a9e9-3162ae76bf58', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (109, N'9055141f-e799-4107-a9e9-3162ae76bf58', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (110, N'9055141f-e799-4107-a9e9-3162ae76bf58', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (111, N'9055141f-e799-4107-a9e9-3162ae76bf58', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (112, N'9055141f-e799-4107-a9e9-3162ae76bf58', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (113, N'9055141f-e799-4107-a9e9-3162ae76bf58', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (114, N'9055141f-e799-4107-a9e9-3162ae76bf58', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (115, N'9055141f-e799-4107-a9e9-3162ae76bf58', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (116, N'9055141f-e799-4107-a9e9-3162ae76bf58', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (117, N'9055141f-e799-4107-a9e9-3162ae76bf58', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (118, N'9055141f-e799-4107-a9e9-3162ae76bf58', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (119, N'9055141f-e799-4107-a9e9-3162ae76bf58', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (120, N'9055141f-e799-4107-a9e9-3162ae76bf58', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (121, N'9055141f-e799-4107-a9e9-3162ae76bf58', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (122, N'9055141f-e799-4107-a9e9-3162ae76bf58', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (123, N'9055141f-e799-4107-a9e9-3162ae76bf58', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (124, N'9055141f-e799-4107-a9e9-3162ae76bf58', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (125, N'9055141f-e799-4107-a9e9-3162ae76bf58', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (126, N'9055141f-e799-4107-a9e9-3162ae76bf58', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (127, N'9055141f-e799-4107-a9e9-3162ae76bf58', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (128, N'9055141f-e799-4107-a9e9-3162ae76bf58', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10029, N'e199aa25-d8b3-4034-b974-0f310267bb53', 18, N'rrrbbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10030, N'e199aa25-d8b3-4034-b974-0f310267bb53', 17, N'xxxxxrr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10031, N'e199aa25-d8b3-4034-b974-0f310267bb53', 16, N'xxxxxbb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10032, N'e199aa25-d8b3-4034-b974-0f310267bb53', 15, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10033, N'e199aa25-d8b3-4034-b974-0f310267bb53', 14, N'xxxxxxb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10034, N'e199aa25-d8b3-4034-b974-0f310267bb53', 13, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10035, N'e199aa25-d8b3-4034-b974-0f310267bb53', 12, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10036, N'e199aa25-d8b3-4034-b974-0f310267bb53', 11, N'xxxxxrb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10037, N'e199aa25-d8b3-4034-b974-0f310267bb53', 21, N'xxxxxbr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10038, N'e199aa25-d8b3-4034-b974-0f310267bb53', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10039, N'e199aa25-d8b3-4034-b974-0f310267bb53', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10040, N'e199aa25-d8b3-4034-b974-0f310267bb53', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10041, N'e199aa25-d8b3-4034-b974-0f310267bb53', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10042, N'e199aa25-d8b3-4034-b974-0f310267bb53', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10043, N'e199aa25-d8b3-4034-b974-0f310267bb53', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10044, N'e199aa25-d8b3-4034-b974-0f310267bb53', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10045, N'e199aa25-d8b3-4034-b974-0f310267bb53', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10046, N'e199aa25-d8b3-4034-b974-0f310267bb53', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10047, N'e199aa25-d8b3-4034-b974-0f310267bb53', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10048, N'e199aa25-d8b3-4034-b974-0f310267bb53', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10049, N'e199aa25-d8b3-4034-b974-0f310267bb53', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10050, N'e199aa25-d8b3-4034-b974-0f310267bb53', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10051, N'e199aa25-d8b3-4034-b974-0f310267bb53', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10052, N'e199aa25-d8b3-4034-b974-0f310267bb53', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10053, N'e199aa25-d8b3-4034-b974-0f310267bb53', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10054, N'e199aa25-d8b3-4034-b974-0f310267bb53', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10055, N'e199aa25-d8b3-4034-b974-0f310267bb53', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10056, N'e199aa25-d8b3-4034-b974-0f310267bb53', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10057, N'e199aa25-d8b3-4034-b974-0f310267bb53', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10058, N'e199aa25-d8b3-4034-b974-0f310267bb53', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10059, N'e199aa25-d8b3-4034-b974-0f310267bb53', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10060, N'e199aa25-d8b3-4034-b974-0f310267bb53', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10061, N'c7aad6a3-1155-4217-88fb-323920489a2f', 18, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10062, N'c7aad6a3-1155-4217-88fb-323920489a2f', 17, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10063, N'c7aad6a3-1155-4217-88fb-323920489a2f', 16, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10064, N'c7aad6a3-1155-4217-88fb-323920489a2f', 15, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10065, N'c7aad6a3-1155-4217-88fb-323920489a2f', 14, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10066, N'c7aad6a3-1155-4217-88fb-323920489a2f', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10067, N'c7aad6a3-1155-4217-88fb-323920489a2f', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10068, N'c7aad6a3-1155-4217-88fb-323920489a2f', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10069, N'c7aad6a3-1155-4217-88fb-323920489a2f', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10070, N'c7aad6a3-1155-4217-88fb-323920489a2f', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10071, N'c7aad6a3-1155-4217-88fb-323920489a2f', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10072, N'c7aad6a3-1155-4217-88fb-323920489a2f', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10073, N'c7aad6a3-1155-4217-88fb-323920489a2f', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10074, N'c7aad6a3-1155-4217-88fb-323920489a2f', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10075, N'c7aad6a3-1155-4217-88fb-323920489a2f', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10076, N'c7aad6a3-1155-4217-88fb-323920489a2f', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10077, N'c7aad6a3-1155-4217-88fb-323920489a2f', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10078, N'c7aad6a3-1155-4217-88fb-323920489a2f', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10079, N'c7aad6a3-1155-4217-88fb-323920489a2f', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10080, N'c7aad6a3-1155-4217-88fb-323920489a2f', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10081, N'c7aad6a3-1155-4217-88fb-323920489a2f', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10082, N'c7aad6a3-1155-4217-88fb-323920489a2f', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10083, N'c7aad6a3-1155-4217-88fb-323920489a2f', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10084, N'c7aad6a3-1155-4217-88fb-323920489a2f', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10085, N'c7aad6a3-1155-4217-88fb-323920489a2f', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10086, N'c7aad6a3-1155-4217-88fb-323920489a2f', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10087, N'c7aad6a3-1155-4217-88fb-323920489a2f', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10088, N'c7aad6a3-1155-4217-88fb-323920489a2f', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10089, N'c7aad6a3-1155-4217-88fb-323920489a2f', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10090, N'c7aad6a3-1155-4217-88fb-323920489a2f', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10091, N'c7aad6a3-1155-4217-88fb-323920489a2f', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10092, N'c7aad6a3-1155-4217-88fb-323920489a2f', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10093, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 18, N'xxbxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10094, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 17, N'xxrxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10095, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 16, N'rbxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10096, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10097, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 14, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10098, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 13, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10099, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10100, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10101, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10102, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10103, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10104, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 24, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10105, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10106, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 26, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10107, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10108, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 28, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10109, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10110, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10111, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10112, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10113, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 44, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10114, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10115, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10116, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 41, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10117, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 31, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10118, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 32, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10119, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 33, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10120, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 34, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10121, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 35, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10122, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 36, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10123, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 37, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10124, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', 38, N'xxbxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10125, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 18, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10126, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 17, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10127, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 16, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10128, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10129, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10130, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10131, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10132, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10133, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10134, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10135, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10136, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10137, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10138, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10139, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10140, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10141, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10142, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10143, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10144, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10145, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10146, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10147, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10148, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10149, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10150, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10151, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10152, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10153, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10154, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10155, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10156, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10157, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 18, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10158, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 17, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10159, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 16, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10160, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 15, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10161, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 14, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10162, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 13, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10163, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 12, N'xxxxxbr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10164, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10165, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 21, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10166, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10167, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 23, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10168, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 24, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10169, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10170, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10171, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10172, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10173, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10174, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10175, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10176, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10177, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 44, N'brxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10178, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 43, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10179, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 42, N'xxxbrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10180, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 41, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10181, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 31, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10182, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 32, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10183, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 33, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10184, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 34, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10185, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10186, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10187, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10188, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10189, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 18, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10190, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 17, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10191, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 16, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10192, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 15, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10193, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 14, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10194, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 13, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10195, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10196, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10197, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10198, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10199, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10200, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10201, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10202, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10203, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10204, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10205, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10206, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10207, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10208, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10209, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10210, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10211, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10212, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10213, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10214, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10215, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10216, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10217, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10218, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10219, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10220, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10221, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 18, N'rxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10222, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 17, N'xxxrxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10223, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 16, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10224, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 15, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10225, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 14, N'xxxxxxb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10226, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 13, N'xxxxxrr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10227, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 12, N'xxxxxrr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10228, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10229, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 21, N'xbxxbrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10230, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 22, N'xrxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10231, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10232, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10233, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10234, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10235, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10236, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10237, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10238, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10239, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10240, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10241, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10242, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10243, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10244, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10245, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10246, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10247, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10248, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10249, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10250, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10251, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10252, N'ec649458-6dac-4a12-a617-e1dff5a00e77', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10253, N'76de102e-2070-405e-9503-d32fdf9cce6a', 18, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10254, N'76de102e-2070-405e-9503-d32fdf9cce6a', 17, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10255, N'76de102e-2070-405e-9503-d32fdf9cce6a', 16, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10256, N'76de102e-2070-405e-9503-d32fdf9cce6a', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10257, N'76de102e-2070-405e-9503-d32fdf9cce6a', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10258, N'76de102e-2070-405e-9503-d32fdf9cce6a', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10259, N'76de102e-2070-405e-9503-d32fdf9cce6a', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10260, N'76de102e-2070-405e-9503-d32fdf9cce6a', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10261, N'76de102e-2070-405e-9503-d32fdf9cce6a', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10262, N'76de102e-2070-405e-9503-d32fdf9cce6a', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10263, N'76de102e-2070-405e-9503-d32fdf9cce6a', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10264, N'76de102e-2070-405e-9503-d32fdf9cce6a', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10265, N'76de102e-2070-405e-9503-d32fdf9cce6a', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10266, N'76de102e-2070-405e-9503-d32fdf9cce6a', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10267, N'76de102e-2070-405e-9503-d32fdf9cce6a', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10268, N'76de102e-2070-405e-9503-d32fdf9cce6a', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10269, N'76de102e-2070-405e-9503-d32fdf9cce6a', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10270, N'76de102e-2070-405e-9503-d32fdf9cce6a', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10271, N'76de102e-2070-405e-9503-d32fdf9cce6a', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10272, N'76de102e-2070-405e-9503-d32fdf9cce6a', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10273, N'76de102e-2070-405e-9503-d32fdf9cce6a', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10274, N'76de102e-2070-405e-9503-d32fdf9cce6a', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10275, N'76de102e-2070-405e-9503-d32fdf9cce6a', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10276, N'76de102e-2070-405e-9503-d32fdf9cce6a', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10277, N'76de102e-2070-405e-9503-d32fdf9cce6a', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10278, N'76de102e-2070-405e-9503-d32fdf9cce6a', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10279, N'76de102e-2070-405e-9503-d32fdf9cce6a', 33, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10280, N'76de102e-2070-405e-9503-d32fdf9cce6a', 34, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10281, N'76de102e-2070-405e-9503-d32fdf9cce6a', 35, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10282, N'76de102e-2070-405e-9503-d32fdf9cce6a', 36, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10283, N'76de102e-2070-405e-9503-d32fdf9cce6a', 37, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10284, N'76de102e-2070-405e-9503-d32fdf9cce6a', 38, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10285, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 18, N'xxxxxbx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10286, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 17, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10287, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 16, N'xxxxxxr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10288, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10289, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10290, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10291, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10292, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10293, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10294, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10295, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10296, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10297, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10298, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10299, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10300, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10301, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10302, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10303, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10304, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10305, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10306, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10307, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10308, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10309, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10310, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10311, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10312, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10313, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10314, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10315, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10316, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10317, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 18, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10318, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 17, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10319, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 16, N'bxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10320, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10321, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 14, N'xxxxxxb')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10322, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 13, N'xxxxxrx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10323, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10324, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 11, N'xxxxxrr')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10325, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 21, N'bbxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10326, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10327, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10328, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10329, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10330, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10331, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10332, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10333, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10334, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10335, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10336, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10337, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10338, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10339, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10340, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10341, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10342, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10343, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10344, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10345, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10346, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10347, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10348, N'403855c3-fa2f-41a6-af02-0e0694878f4e', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10349, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 18, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10350, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 17, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10351, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 16, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10352, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10353, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10354, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10355, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10356, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10357, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10358, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10359, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10360, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 24, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10361, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 25, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10362, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 26, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10363, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10364, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10365, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10366, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10367, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10368, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10369, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10370, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10371, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10372, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10373, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 31, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10374, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 32, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10375, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 33, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10376, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 34, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10377, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 35, N'xxrxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10378, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 36, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10379, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (10380, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20317, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 18, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20318, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 17, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20319, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 16, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20320, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 15, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20321, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 14, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20322, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20323, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20324, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20325, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20326, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20327, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20328, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20329, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20330, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20331, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20332, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20333, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 48, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20334, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 47, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20335, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 46, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20336, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20337, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20338, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20339, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20340, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20341, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20342, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20343, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20344, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20345, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20346, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20347, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20348, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20349, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 18, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20350, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 17, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20351, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 16, N'xxxxbxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20352, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 15, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20353, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 14, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20354, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 13, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20355, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 12, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20356, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 11, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20357, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 21, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20358, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 22, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20359, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 23, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20360, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 24, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20361, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 25, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20362, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 26, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20363, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 27, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20364, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 28, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20365, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 48, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20366, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 47, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20367, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 46, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20368, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 45, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20369, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 44, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20370, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 43, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20371, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 42, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20372, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 41, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20373, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 31, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20374, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 32, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20375, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 33, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20376, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 34, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20377, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 35, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20378, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 36, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20379, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 37, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20380, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', 38, N'xxxxxxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20381, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 18, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20382, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 17, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20383, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 16, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20384, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 15, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20385, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 14, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20386, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 13, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20387, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 12, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20388, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 11, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20389, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 21, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20390, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 22, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20391, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 23, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20392, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 24, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20393, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 25, N'xxxrrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20394, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 26, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20395, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 27, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20396, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 28, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20397, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 48, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20398, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 47, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20399, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 46, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20400, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 45, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20401, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 44, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20402, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 43, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20403, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 42, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20404, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 41, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20405, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 31, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20406, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 32, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20407, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 33, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20408, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 34, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20409, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 35, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20410, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 36, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20411, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 37, N'xxxxrxx')
GO
INSERT [dbo].[Dientes] ([Id], [OdontogramaID], [DienteID], [Estado]) VALUES (20412, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', 38, N'xxxxrxx')
GO
SET IDENTITY_INSERT [dbo].[Dientes] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicacionHabitual] ON 

GO
INSERT [dbo].[MedicacionHabitual] ([Id], [IdPaciente], [Medicacion]) VALUES (1, 2, N'Medicacion de prueba')
GO
INSERT [dbo].[MedicacionHabitual] ([Id], [IdPaciente], [Medicacion]) VALUES (2, 2, N'Medicacion de prueba 2')
GO
SET IDENTITY_INSERT [dbo].[MedicacionHabitual] OFF
GO
SET IDENTITY_INSERT [dbo].[ObrasSociales] ON 

GO
INSERT [dbo].[ObrasSociales] ([Id], [Nombre]) VALUES (1, N'OsDePrueba')
GO
SET IDENTITY_INSERT [dbo].[ObrasSociales] OFF
GO
SET IDENTITY_INSERT [dbo].[Odontogramas] ON 

GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (1, 2, 1, N'c5432196-3692-4976-b3b7-4b46725d6b74', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (2, 2, 1, N'abb9a96c-7336-48c7-a97f-ea86be85cb0d', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (3, 2, 1, N'9055141f-e799-4107-a9e9-3162ae76bf58', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10002, 1, 1, N'e199aa25-d8b3-4034-b974-0f310267bb53', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10003, 2, 1, N'c7aad6a3-1155-4217-88fb-323920489a2f', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10004, 2, 1, N'b5d1214c-3559-4457-9daa-e08d07b2e6a1', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10005, 2, 1, N'715bfcea-daf4-466e-baa0-d2e9c9187eb1', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10006, 2, 1, N'dc2f2cc9-3bf2-49d4-9ef5-3f550af7eace', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10007, 2, 1, N'ce98e7eb-bb07-4afd-9c19-25e05d08abc5', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10008, 1, 1, N'ec649458-6dac-4a12-a617-e1dff5a00e77', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10009, 1, 1, N'76de102e-2070-405e-9503-d32fdf9cce6a', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10010, 1, 1, N'079f1728-8517-45c5-bc5e-4c82a9ca2657', CAST(0x0000A85D00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10011, 1, 1, N'403855c3-fa2f-41a6-af02-0e0694878f4e', CAST(0x0000A85F00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (10012, 1, 1, N'085f57a5-d1a3-44c6-b5c8-bab0d0b5a00c', CAST(0x0000A85F00000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (20011, 1, 1, N'4a84bff0-f9cd-480d-852b-ab4b29bbc489', CAST(0x0000A86800000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (20012, 1, 2, N'd7be1b35-1e17-4ae2-b160-7ed8c75e0f1a', CAST(0x0000A86800000000 AS DateTime))
GO
INSERT [dbo].[Odontogramas] ([Id], [UserId], [PacienteId], [UID], [Fecha]) VALUES (20013, 1, 2, N'5430cb9e-a5e2-4a7c-a2db-de570d55c9f3', CAST(0x0000A86800000000 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Odontogramas] OFF
GO
SET IDENTITY_INSERT [dbo].[Pacientes] ON 

GO
INSERT [dbo].[Pacientes] ([Id], [GUID], [Apellido], [Nombre], [FechaNacimiento], [NroDocumento], [Domicilio], [Localidad], [Telefono], [IdObraSocial], [NroObraSocial], [Sexo]) VALUES (1, N'A5E50E6F-D5FB-452C-A3E9-9DBA9352AF7A', N'Chaves', N'David Leonardo', CAST(0x0FEF0A00 AS Date), N'31807935', N'Intendente Boglio 514', N'Arroyo Cabral', N'3534084119', 1, N'6354564564', N'Masculino')
GO
INSERT [dbo].[Pacientes] ([Id], [GUID], [Apellido], [Nombre], [FechaNacimiento], [NroDocumento], [Domicilio], [Localidad], [Telefono], [IdObraSocial], [NroObraSocial], [Sexo]) VALUES (2, N'37CA9322-8286-456D-84FD-4F4FF5CC4F07', N'Maricel', N'Gomez', CAST(0x5E0E0B00 AS Date), N'31217874', N'Intendente Boglio 514', N'Arroyo Cabral', N'3534084119', 1, N'31807935', N'Femenino')
GO
INSERT [dbo].[Pacientes] ([Id], [GUID], [Apellido], [Nombre], [FechaNacimiento], [NroDocumento], [Domicilio], [Localidad], [Telefono], [IdObraSocial], [NroObraSocial], [Sexo]) VALUES (4, N'EC81E9C7-9399-47C7-8C8E-342A5063FDD2', N'Hernan', N'Rodolfi', CAST(0xE00F0B00 AS Date), N'31584123', N'Pje Jose INgenieros 820', N'Arroyo Cabral', N'23978498234', 1, N'3497853054', N'Masculino')
GO
SET IDENTITY_INSERT [dbo].[Pacientes] OFF
GO
SET IDENTITY_INSERT [dbo].[RegistroC1] ON 

GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (1, CAST(0x0000A988003F7F14 AS DateTime), 3, 10)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (3, CAST(0x0000A98800424D70 AS DateTime), 2, 16)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (5, CAST(0x0000A98800428934 AS DateTime), 2, 16)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (15, CAST(0x0000A98800657444 AS DateTime), 3, -10)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (16, CAST(0x0000A98800657444 AS DateTime), 3, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (10002, CAST(0x0000A98C00524040 AS DateTime), 3, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (10003, CAST(0x0000A98C0052623C AS DateTime), 3, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (10004, CAST(0x0000A98C00534B70 AS DateTime), 3, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (10005, CAST(0x0000A98C00539670 AS DateTime), 1, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (10006, CAST(0x0000A98C0054AB00 AS DateTime), 1, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (20002, CAST(0x0000A9AA00C219D8 AS DateTime), 2, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (20003, CAST(0x0000A9AA00C45DEC AS DateTime), 2, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (20004, CAST(0x0000A9AA00C4881C AS DateTime), 2, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (20005, CAST(0x0000A9AA00C4F194 AS DateTime), 2, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (30002, CAST(0x0000A9AD002DD14C AS DateTime), 2, 63)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (40002, CAST(0x0000A9B2005A6630 AS DateTime), 2, 0)
GO
INSERT [dbo].[RegistroC1] ([Id], [fechaC1], [UserId], [CantidadHoras]) VALUES (40003, CAST(0x0000A9B2005A8958 AS DateTime), 2, 0)
GO
SET IDENTITY_INSERT [dbo].[RegistroC1] OFF
GO
SET IDENTITY_INSERT [dbo].[RiesgoCardiovascular] ON 

GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (1, 1, N'H', 70, 0, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (2, 1, N'H', 70, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (3, 1, N'H', 70, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (4, 1, N'H', 70, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (5, 1, N'H', 70, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (6, 1, N'H', 70, 0, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (7, 1, N'H', 70, 0, 160, 193, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (8, 1, N'H', 70, 0, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (9, 1, N'H', 70, 0, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (10, 1, N'H', 70, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (11, 1, N'H', 70, 0, 140, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (12, 1, N'H', 70, 0, 140, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (13, 1, N'H', 70, 0, 140, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (14, 1, N'H', 70, 0, 140, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (15, 1, N'H', 70, 0, 140, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (16, 1, N'H', 70, 0, 120, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (17, 1, N'H', 70, 0, 120, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (18, 1, N'H', 70, 0, 120, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (19, 1, N'H', 70, 0, 120, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (20, 1, N'H', 70, 0, 120, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (21, 1, N'H', 70, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (22, 1, N'H', 70, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (23, 1, N'H', 70, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (24, 1, N'H', 70, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (25, 1, N'H', 70, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (26, 1, N'H', 70, 1, 160, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (27, 1, N'H', 70, 1, 160, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (28, 1, N'H', 70, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (29, 1, N'H', 70, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (30, 1, N'H', 70, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (31, 1, N'H', 70, 1, 140, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (32, 1, N'H', 70, 1, 140, 193, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (33, 1, N'H', 70, 1, 140, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (34, 1, N'H', 70, 1, 140, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (35, 1, N'H', 70, 1, 140, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (36, 1, N'H', 70, 1, 120, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (37, 1, N'H', 70, 1, 120, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (38, 1, N'H', 70, 1, 120, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (39, 1, N'H', 70, 1, 120, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (40, 1, N'H', 70, 1, 120, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (41, 1, N'M', 70, 0, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (42, 1, N'M', 70, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (43, 1, N'M', 70, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (44, 1, N'M', 70, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (45, 1, N'M', 70, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (46, 1, N'M', 70, 0, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (47, 1, N'M', 70, 0, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (48, 1, N'M', 70, 0, 160, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (49, 1, N'M', 70, 0, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (50, 1, N'M', 70, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (51, 1, N'M', 70, 0, 140, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (52, 1, N'M', 70, 0, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (53, 1, N'M', 70, 0, 140, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (54, 1, N'M', 70, 0, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (55, 1, N'M', 70, 0, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (56, 1, N'M', 70, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (57, 1, N'M', 70, 0, 120, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (58, 1, N'M', 70, 0, 120, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (59, 1, N'M', 70, 0, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (60, 1, N'M', 70, 0, 120, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (61, 1, N'M', 70, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (62, 1, N'M', 70, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (63, 1, N'M', 70, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (64, 1, N'M', 70, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (65, 1, N'M', 70, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (66, 1, N'M', 70, 1, 160, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (67, 1, N'M', 70, 1, 160, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (68, 1, N'M', 70, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (69, 1, N'M', 70, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (70, 1, N'M', 70, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (71, 1, N'M', 70, 1, 140, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (72, 1, N'M', 70, 1, 140, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (73, 1, N'M', 70, 1, 140, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (74, 1, N'M', 70, 1, 140, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (75, 1, N'M', 70, 1, 140, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (76, 1, N'M', 70, 1, 120, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (77, 1, N'M', 70, 1, 120, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (78, 1, N'M', 70, 1, 120, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (79, 1, N'M', 70, 1, 120, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (80, 1, N'M', 70, 1, 120, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (81, 1, N'H', 60, 0, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (82, 1, N'H', 60, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (83, 1, N'H', 60, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (84, 1, N'H', 60, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (85, 1, N'H', 60, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (86, 1, N'H', 60, 0, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (87, 1, N'H', 60, 0, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (88, 1, N'H', 60, 0, 160, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (89, 1, N'H', 60, 0, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (90, 1, N'H', 60, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (91, 1, N'H', 60, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (92, 1, N'H', 60, 0, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (93, 1, N'H', 60, 0, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (94, 1, N'H', 60, 0, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (95, 1, N'H', 60, 0, 140, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (96, 1, N'H', 60, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (97, 1, N'H', 60, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (98, 1, N'H', 60, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (99, 1, N'H', 60, 0, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (100, 1, N'H', 60, 0, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (101, 1, N'H', 60, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (102, 1, N'H', 60, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (103, 1, N'H', 60, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (104, 1, N'H', 60, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (105, 1, N'H', 60, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (106, 1, N'H', 60, 1, 160, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (107, 1, N'H', 60, 1, 160, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (108, 1, N'H', 60, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (109, 1, N'H', 60, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (110, 1, N'H', 60, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (111, 1, N'H', 60, 1, 140, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (112, 1, N'H', 60, 1, 140, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (113, 1, N'H', 60, 1, 140, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (114, 1, N'H', 60, 1, 140, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (115, 1, N'H', 60, 1, 140, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (116, 1, N'H', 60, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (117, 1, N'H', 60, 1, 120, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (118, 1, N'H', 60, 1, 120, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (119, 1, N'H', 60, 1, 120, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (120, 1, N'H', 60, 1, 120, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (121, 1, N'M', 60, 0, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (122, 1, N'M', 60, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (123, 1, N'M', 60, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (124, 1, N'M', 60, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (125, 1, N'M', 60, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (126, 1, N'M', 60, 0, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (127, 1, N'M', 60, 0, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (128, 1, N'M', 60, 0, 160, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (129, 1, N'M', 60, 0, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (130, 1, N'M', 60, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (131, 1, N'M', 60, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (132, 1, N'M', 60, 0, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (133, 1, N'M', 60, 0, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (134, 1, N'M', 60, 0, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (135, 1, N'M', 60, 0, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (136, 1, N'M', 60, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (137, 1, N'M', 60, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (138, 1, N'M', 60, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (139, 1, N'M', 60, 0, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (140, 1, N'M', 60, 0, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (141, 1, N'M', 60, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (142, 1, N'M', 60, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (143, 1, N'M', 60, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (144, 1, N'M', 60, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (145, 1, N'M', 60, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (146, 1, N'M', 60, 1, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (147, 1, N'M', 60, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (148, 1, N'M', 60, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (149, 1, N'M', 60, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (150, 1, N'M', 60, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (151, 1, N'M', 60, 1, 140, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (152, 1, N'M', 60, 1, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (153, 1, N'M', 60, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (154, 1, N'M', 60, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (155, 1, N'M', 60, 1, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (156, 1, N'M', 60, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (157, 1, N'M', 60, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (158, 1, N'M', 60, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (159, 1, N'M', 60, 1, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (160, 1, N'M', 60, 1, 120, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (161, 1, N'H', 50, 0, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (162, 1, N'H', 50, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (163, 1, N'H', 50, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (164, 1, N'H', 50, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (165, 1, N'H', 50, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (166, 1, N'H', 50, 0, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (167, 1, N'H', 50, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (168, 1, N'H', 50, 0, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (169, 1, N'H', 50, 0, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (170, 1, N'H', 50, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (171, 1, N'H', 50, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (172, 1, N'H', 50, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (173, 1, N'H', 50, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (174, 1, N'H', 50, 0, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (175, 1, N'H', 50, 0, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (176, 1, N'H', 50, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (177, 1, N'H', 50, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (178, 1, N'H', 50, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (179, 1, N'H', 50, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (180, 1, N'H', 50, 0, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (181, 1, N'H', 50, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (182, 1, N'H', 50, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (183, 1, N'H', 50, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (184, 1, N'H', 50, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (185, 1, N'H', 50, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (186, 1, N'H', 50, 1, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (187, 1, N'H', 50, 1, 160, 193, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (188, 1, N'H', 50, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (189, 1, N'H', 50, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (190, 1, N'H', 50, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (191, 1, N'H', 50, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (192, 1, N'H', 50, 1, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (193, 1, N'H', 50, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (194, 1, N'H', 50, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (195, 1, N'H', 50, 1, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (196, 1, N'H', 50, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (197, 1, N'H', 50, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (198, 1, N'H', 50, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (199, 1, N'H', 50, 1, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (200, 1, N'H', 50, 1, 120, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (201, 1, N'M', 50, 0, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (202, 1, N'M', 50, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (203, 1, N'M', 50, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (204, 1, N'M', 50, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (205, 1, N'M', 50, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (206, 1, N'M', 50, 0, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (207, 1, N'M', 50, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (208, 1, N'M', 50, 0, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (209, 1, N'M', 50, 0, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (210, 1, N'M', 50, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (211, 1, N'M', 50, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (212, 1, N'M', 50, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (213, 1, N'M', 50, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (214, 1, N'M', 50, 0, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (215, 1, N'M', 50, 0, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (216, 1, N'M', 50, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (217, 1, N'M', 50, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (218, 1, N'M', 50, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (219, 1, N'M', 50, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (220, 1, N'M', 50, 0, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (221, 1, N'M', 50, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (222, 1, N'M', 50, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (223, 1, N'M', 50, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (224, 1, N'M', 50, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (225, 1, N'M', 50, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (226, 1, N'M', 50, 1, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (227, 1, N'M', 50, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (228, 1, N'M', 50, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (229, 1, N'M', 50, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (230, 1, N'M', 50, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (231, 1, N'M', 50, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (232, 1, N'M', 50, 1, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (233, 1, N'M', 50, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (234, 1, N'M', 50, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (235, 1, N'M', 50, 1, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (236, 1, N'M', 50, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (237, 1, N'M', 50, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (238, 1, N'M', 50, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (239, 1, N'M', 50, 1, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (240, 1, N'M', 50, 1, 120, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (241, 1, N'H', 40, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (242, 1, N'H', 40, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (243, 1, N'H', 40, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (244, 1, N'H', 40, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (245, 1, N'H', 40, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (246, 1, N'H', 40, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (247, 1, N'H', 40, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (248, 1, N'H', 40, 0, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (249, 1, N'H', 40, 0, 160, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (250, 1, N'H', 40, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (251, 1, N'H', 40, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (252, 1, N'H', 40, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (253, 1, N'H', 40, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (254, 1, N'H', 40, 0, 140, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (255, 1, N'H', 40, 0, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (256, 1, N'H', 40, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (257, 1, N'H', 40, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (258, 1, N'H', 40, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (259, 1, N'H', 40, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (260, 1, N'H', 40, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (261, 1, N'H', 40, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (262, 1, N'H', 40, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (263, 1, N'H', 40, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (264, 1, N'H', 40, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (265, 1, N'H', 40, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (266, 1, N'H', 40, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (267, 1, N'H', 40, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (268, 1, N'H', 40, 1, 160, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (269, 1, N'H', 40, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (270, 1, N'H', 40, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (271, 1, N'H', 40, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (272, 1, N'H', 40, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (273, 1, N'H', 40, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (274, 1, N'H', 40, 1, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (275, 1, N'H', 40, 1, 140, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (276, 1, N'H', 40, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (277, 1, N'H', 40, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (278, 1, N'H', 40, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (279, 1, N'H', 40, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (280, 1, N'H', 40, 1, 120, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (281, 1, N'M', 40, 0, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (282, 1, N'M', 40, 0, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (283, 1, N'M', 40, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (284, 1, N'M', 40, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (285, 1, N'M', 40, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (286, 1, N'M', 40, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (287, 1, N'M', 40, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (288, 1, N'M', 40, 0, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (289, 1, N'M', 40, 0, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (290, 1, N'M', 40, 0, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (291, 1, N'M', 40, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (292, 1, N'M', 40, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (293, 1, N'M', 40, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (294, 1, N'M', 40, 0, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (295, 1, N'M', 40, 0, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (296, 1, N'M', 40, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (297, 1, N'M', 40, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (298, 1, N'M', 40, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (299, 1, N'M', 40, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (300, 1, N'M', 40, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (301, 1, N'M', 40, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (302, 1, N'M', 40, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (303, 1, N'M', 40, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (304, 1, N'M', 40, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (305, 1, N'M', 40, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (306, 1, N'M', 40, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (307, 1, N'M', 40, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (308, 1, N'M', 40, 1, 160, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (309, 1, N'M', 40, 1, 160, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (310, 1, N'M', 40, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (311, 1, N'M', 40, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (312, 1, N'M', 40, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (313, 1, N'M', 40, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (314, 1, N'M', 40, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (315, 1, N'M', 40, 1, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (316, 1, N'M', 40, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (317, 1, N'M', 40, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (318, 1, N'M', 40, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (319, 1, N'M', 40, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (320, 1, N'M', 40, 1, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (321, 0, N'H', 70, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (322, 0, N'H', 70, 0, 180, 193, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (323, 0, N'H', 70, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (324, 0, N'H', 70, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (325, 0, N'H', 70, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (326, 0, N'H', 70, 0, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (327, 0, N'H', 70, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (328, 0, N'H', 70, 0, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (329, 0, N'H', 70, 0, 160, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (330, 0, N'H', 70, 0, 160, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (331, 0, N'H', 70, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (332, 0, N'H', 70, 0, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (333, 0, N'H', 70, 0, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (334, 0, N'H', 70, 0, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (335, 0, N'H', 70, 0, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (336, 0, N'H', 70, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (337, 0, N'H', 70, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (338, 0, N'H', 70, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (339, 0, N'H', 70, 0, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (340, 0, N'H', 70, 0, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (341, 0, N'H', 70, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (342, 0, N'H', 70, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (343, 0, N'H', 70, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (344, 0, N'H', 70, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (345, 0, N'H', 70, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (346, 0, N'H', 70, 1, 160, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (347, 0, N'H', 70, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (348, 0, N'H', 70, 1, 160, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (349, 0, N'H', 70, 1, 160, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (350, 0, N'H', 70, 1, 160, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (351, 0, N'H', 70, 1, 140, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (352, 0, N'H', 70, 1, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (353, 0, N'H', 70, 1, 140, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (354, 0, N'H', 70, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (355, 0, N'H', 70, 1, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (356, 0, N'H', 70, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (357, 0, N'H', 70, 1, 120, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (358, 0, N'H', 70, 1, 120, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (359, 0, N'H', 70, 1, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (360, 0, N'H', 70, 1, 120, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (361, 0, N'M', 70, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (362, 0, N'M', 70, 0, 180, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (363, 0, N'M', 70, 0, 180, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (364, 0, N'M', 70, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (365, 0, N'M', 70, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (366, 0, N'M', 70, 0, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (367, 0, N'M', 70, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (368, 0, N'M', 70, 0, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (369, 0, N'M', 70, 0, 160, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (370, 0, N'M', 70, 0, 160, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (371, 0, N'M', 70, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (372, 0, N'M', 70, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (373, 0, N'M', 70, 0, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (374, 0, N'M', 70, 0, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (375, 0, N'M', 70, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (376, 0, N'M', 70, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (377, 0, N'M', 70, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (378, 0, N'M', 70, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (379, 0, N'M', 70, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (380, 0, N'M', 70, 0, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (381, 0, N'M', 70, 1, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (382, 0, N'M', 70, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (383, 0, N'M', 70, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (384, 0, N'M', 70, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (385, 0, N'M', 70, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (386, 0, N'M', 70, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (387, 0, N'M', 70, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (388, 0, N'M', 70, 1, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (389, 0, N'M', 70, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (390, 0, N'M', 70, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (391, 0, N'M', 70, 1, 140, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (392, 0, N'M', 70, 1, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (393, 0, N'M', 70, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (394, 0, N'M', 70, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (395, 0, N'M', 70, 1, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (396, 0, N'M', 70, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (397, 0, N'M', 70, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (398, 0, N'M', 70, 1, 120, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (399, 0, N'M', 70, 1, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (400, 0, N'M', 70, 1, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (401, 0, N'H', 60, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (402, 0, N'H', 60, 0, 180, 193, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (403, 0, N'H', 60, 0, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (404, 0, N'H', 60, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (405, 0, N'H', 60, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (406, 0, N'H', 60, 0, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (407, 0, N'H', 60, 0, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (408, 0, N'H', 60, 0, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (409, 0, N'H', 60, 0, 160, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (410, 0, N'H', 60, 0, 160, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (411, 0, N'H', 60, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (412, 0, N'H', 60, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (413, 0, N'H', 60, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (414, 0, N'H', 60, 0, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (415, 0, N'H', 60, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (416, 0, N'H', 60, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (417, 0, N'H', 60, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (418, 0, N'H', 60, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (419, 0, N'H', 60, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (420, 0, N'H', 60, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (421, 0, N'H', 60, 1, 180, 155, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (422, 0, N'H', 60, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (423, 0, N'H', 60, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (424, 0, N'H', 60, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (425, 0, N'H', 60, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (426, 0, N'H', 60, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (427, 0, N'H', 60, 1, 160, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (428, 0, N'H', 60, 1, 160, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (429, 0, N'H', 60, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (430, 0, N'H', 60, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (431, 0, N'H', 60, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (432, 0, N'H', 60, 1, 140, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (433, 0, N'H', 60, 1, 140, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (434, 0, N'H', 60, 1, 140, 270, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (435, 0, N'H', 60, 1, 140, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (436, 0, N'H', 60, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (437, 0, N'H', 60, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (438, 0, N'H', 60, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (439, 0, N'H', 60, 1, 120, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (440, 0, N'H', 60, 1, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (441, 0, N'M', 60, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (442, 0, N'M', 60, 0, 180, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (443, 0, N'M', 60, 0, 180, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (444, 0, N'M', 60, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (445, 0, N'M', 60, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (446, 0, N'M', 60, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (447, 0, N'M', 60, 0, 160, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (448, 0, N'M', 60, 0, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (449, 0, N'M', 60, 0, 160, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (450, 0, N'M', 60, 0, 160, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (451, 0, N'M', 60, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (452, 0, N'M', 60, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (453, 0, N'M', 60, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (454, 0, N'M', 60, 0, 140, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (455, 0, N'M', 60, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (456, 0, N'M', 60, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (457, 0, N'M', 60, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (458, 0, N'M', 60, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (459, 0, N'M', 60, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (460, 0, N'M', 60, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (461, 0, N'M', 60, 1, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (462, 0, N'M', 60, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (463, 0, N'M', 60, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (464, 0, N'M', 60, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (465, 0, N'M', 60, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (466, 0, N'M', 60, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (467, 0, N'M', 60, 1, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (468, 0, N'M', 60, 1, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (469, 0, N'M', 60, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (470, 0, N'M', 60, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (471, 0, N'M', 60, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (472, 0, N'M', 60, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (473, 0, N'M', 60, 1, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (474, 0, N'M', 60, 1, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (475, 0, N'M', 60, 1, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (476, 0, N'M', 60, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (477, 0, N'M', 60, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (478, 0, N'M', 60, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (479, 0, N'M', 60, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (480, 0, N'M', 60, 1, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (481, 0, N'H', 50, 0, 180, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (482, 0, N'H', 50, 0, 180, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (483, 0, N'H', 50, 0, 180, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (484, 0, N'H', 50, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (485, 0, N'H', 50, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (486, 0, N'H', 50, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (487, 0, N'H', 50, 0, 160, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (488, 0, N'H', 50, 0, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (489, 0, N'H', 50, 0, 160, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (490, 0, N'H', 50, 0, 160, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (491, 0, N'H', 50, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (492, 0, N'H', 50, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (493, 0, N'H', 50, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (494, 0, N'H', 50, 0, 140, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (495, 0, N'H', 50, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (496, 0, N'H', 50, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (497, 0, N'H', 50, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (498, 0, N'H', 50, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (499, 0, N'H', 50, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (500, 0, N'H', 50, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (501, 0, N'H', 50, 1, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (502, 0, N'H', 50, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (503, 0, N'H', 50, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (504, 0, N'H', 50, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (505, 0, N'H', 50, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (506, 0, N'H', 50, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (507, 0, N'H', 50, 1, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (508, 0, N'H', 50, 1, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (509, 0, N'H', 50, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (510, 0, N'H', 50, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (511, 0, N'H', 50, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (512, 0, N'H', 50, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (513, 0, N'H', 50, 1, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (514, 0, N'H', 50, 1, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (515, 0, N'H', 50, 1, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (516, 0, N'H', 50, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (517, 0, N'H', 50, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (518, 0, N'H', 50, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (519, 0, N'H', 50, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (520, 0, N'H', 50, 1, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (521, 0, N'M', 50, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (522, 0, N'M', 50, 0, 180, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (523, 0, N'M', 50, 0, 180, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (524, 0, N'M', 50, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (525, 0, N'M', 50, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (526, 0, N'M', 50, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (527, 0, N'M', 50, 0, 160, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (528, 0, N'M', 50, 0, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (529, 0, N'M', 50, 0, 160, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (530, 0, N'M', 50, 0, 160, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (531, 0, N'M', 50, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (532, 0, N'M', 50, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (533, 0, N'M', 50, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (534, 0, N'M', 50, 0, 140, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (535, 0, N'M', 50, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (536, 0, N'M', 50, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (537, 0, N'M', 50, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (538, 0, N'M', 50, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (539, 0, N'M', 50, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (540, 0, N'M', 50, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (541, 0, N'M', 50, 1, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (542, 0, N'M', 50, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (543, 0, N'M', 50, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (544, 0, N'M', 50, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (545, 0, N'M', 50, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (546, 0, N'M', 50, 1, 160, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (547, 0, N'M', 50, 1, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (548, 0, N'M', 50, 1, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (549, 0, N'M', 50, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (550, 0, N'M', 50, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (551, 0, N'M', 50, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (552, 0, N'M', 50, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (553, 0, N'M', 50, 1, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (554, 0, N'M', 50, 1, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (555, 0, N'M', 50, 1, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (556, 0, N'M', 50, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (557, 0, N'M', 50, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (558, 0, N'M', 50, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (559, 0, N'M', 50, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (560, 0, N'M', 50, 1, 120, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (561, 0, N'H', 40, 0, 180, 155, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (562, 0, N'H', 40, 0, 180, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (563, 0, N'H', 40, 0, 180, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (564, 0, N'H', 40, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (565, 0, N'H', 40, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (566, 0, N'H', 40, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (567, 0, N'H', 40, 0, 160, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (568, 0, N'H', 40, 0, 160, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (569, 0, N'H', 40, 0, 160, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (570, 0, N'H', 40, 0, 160, 309, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (571, 0, N'H', 40, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (572, 0, N'H', 40, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (573, 0, N'H', 40, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (574, 0, N'H', 40, 0, 140, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (575, 0, N'H', 40, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (576, 0, N'H', 40, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (577, 0, N'H', 40, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (578, 0, N'H', 40, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (579, 0, N'H', 40, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (580, 0, N'H', 40, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (581, 0, N'H', 40, 1, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (582, 0, N'H', 40, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (583, 0, N'H', 40, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (584, 0, N'H', 40, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (585, 0, N'H', 40, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (586, 0, N'H', 40, 1, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (587, 0, N'H', 40, 1, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (588, 0, N'H', 40, 1, 160, 232, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (589, 0, N'H', 40, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (590, 0, N'H', 40, 1, 160, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (591, 0, N'H', 40, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (592, 0, N'H', 40, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (593, 0, N'H', 40, 1, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (594, 0, N'H', 40, 1, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (595, 0, N'H', 40, 1, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (596, 0, N'H', 40, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (597, 0, N'H', 40, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (598, 0, N'H', 40, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (599, 0, N'H', 40, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (600, 0, N'H', 40, 1, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (601, 0, N'M', 40, 0, 180, 155, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (602, 0, N'M', 40, 0, 180, 193, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (603, 0, N'M', 40, 0, 180, 232, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (604, 0, N'M', 40, 0, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (605, 0, N'M', 40, 0, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (606, 0, N'M', 40, 0, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (607, 0, N'M', 40, 0, 160, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (608, 0, N'M', 40, 0, 160, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (609, 0, N'M', 40, 0, 160, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (610, 0, N'M', 40, 0, 160, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (611, 0, N'M', 40, 0, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (612, 0, N'M', 40, 0, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (613, 0, N'M', 40, 0, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (614, 0, N'M', 40, 0, 140, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (615, 0, N'M', 40, 0, 140, 309, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (616, 0, N'M', 40, 0, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (617, 0, N'M', 40, 0, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (618, 0, N'M', 40, 0, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (619, 0, N'M', 40, 0, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (620, 0, N'M', 40, 0, 120, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (621, 0, N'M', 40, 1, 180, 155, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (622, 0, N'M', 40, 1, 180, 193, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (623, 0, N'M', 40, 1, 180, 232, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (624, 0, N'M', 40, 1, 180, 270, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (625, 0, N'M', 40, 1, 180, 309, N'B')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (626, 0, N'M', 40, 1, 160, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (627, 0, N'M', 40, 1, 160, 193, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (628, 0, N'M', 40, 1, 160, 232, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (629, 0, N'M', 40, 1, 160, 270, N'R')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (630, 0, N'M', 40, 1, 160, 309, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (631, 0, N'M', 40, 1, 140, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (632, 0, N'M', 40, 1, 140, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (633, 0, N'M', 40, 1, 140, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (634, 0, N'M', 40, 1, 140, 270, N'A')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (635, 0, N'M', 40, 1, 140, 309, N'N')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (636, 0, N'M', 40, 1, 120, 155, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (637, 0, N'M', 40, 1, 120, 193, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (638, 0, N'M', 40, 1, 120, 232, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (639, 0, N'M', 40, 1, 120, 270, N'V')
GO
INSERT [dbo].[RiesgoCardiovascular] ([Id], [Diabetes], [Sexo], [Edad], [Tabaquismo], [PAS], [Colesterol], [Riesgo]) VALUES (640, 0, N'M', 40, 1, 120, 309, N'V')
GO
SET IDENTITY_INSERT [dbo].[RiesgoCardiovascular] OFF
GO
SET IDENTITY_INSERT [dbo].[Somatometria] ON 

GO
INSERT [dbo].[Somatometria] ([Id], [IdPaciente], [IdUsuario], [FechaHora], [Peso], [Talla], [PASistolica], [PADiastolica], [IMC], [Colesterol]) VALUES (1, 1, N'1         ', CAST(0x0000A93601407AF8 AS DateTime), CAST(54.00 AS Decimal(18, 2)), CAST(1.65 AS Decimal(18, 2)), 160, 200, CAST(19.83 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Somatometria] OFF
GO
SET IDENTITY_INSERT [dbo].[Turnos] ON 

GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (1, 2, 1, CAST(0x0000A848018B382C AS DateTime), CAST(0x0000A86000D384D4 AS DateTime), CAST(0x0000A86000D3A0F4 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'diag 4', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (2, 3, 1, CAST(0x0000A8490006F8C4 AS DateTime), CAST(0x0000A988003E9838 AS DateTime), CAST(0x0000A988003E9E14 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', NULL, 0, NULL)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (10002, 2, 1, CAST(0x0000A86000D095A8 AS DateTime), CAST(0x0000A86000D38150 AS DateTime), CAST(0x0000A86000D399EC AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'diag 3', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (10003, 2, 1, CAST(0x0000A86000D0A868 AS DateTime), CAST(0x0000A86000D37DCC AS DateTime), CAST(0x0000A86000D392E4 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'diag 2', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (10004, 2, 1, CAST(0x0000A86000D0B54C AS DateTime), CAST(0x0000A86000D3746C AS DateTime), CAST(0x0000A86000D38984 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'diag 1', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (20002, 2, 2, CAST(0x0000A86901387254 AS DateTime), CAST(0x0000A869013896A8 AS DateTime), CAST(0x0000A86901389B58 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'asdasdasd', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (20003, 2, 1, CAST(0x0000A86901388064 AS DateTime), CAST(0x0000A869013891F8 AS DateTime), CAST(0x0000A86901389A2C AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'asd', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (20004, 2, 4, CAST(0x0000A89F00E7A20C AS DateTime), CAST(0x0000A89F00E85FE4 AS DateTime), CAST(0x0000A988003E7510 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'y anda a saber', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (20005, 2, 2, CAST(0x0000A89F00E7AEF0 AS DateTime), CAST(0x0000A89F00E86368 AS DateTime), CAST(0x0000A988003E73E4 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'pero', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (20006, 2, 4, CAST(0x0000A89F00E7B97C AS DateTime), CAST(0x0000A89F00E85C60 AS DateTime), CAST(0x0000A988003E72B8 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'Control Embarazo', 0, 1)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (20007, 2, 2, CAST(0x0000A89F00E7C408 AS DateTime), CAST(0x0000A89F00E85684 AS DateTime), CAST(0x0000A89F00E86818 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'Control Embarazo', 0, 1)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (30004, 2, 1, CAST(0x0000A988003E3118 AS DateTime), CAST(0x0000A988003E6BB0 AS DateTime), CAST(0x0000A988003E718C AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'asd', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (30005, 3, 2, CAST(0x0000A988003E3DFC AS DateTime), CAST(0x0000A988003E94B4 AS DateTime), CAST(0x0000A988003E9CE8 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', NULL, 0, NULL)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (40004, 2, 1, CAST(0x0000A9AD001F890C AS DateTime), CAST(0x0000A9AD001F890C AS DateTime), CAST(0x0000A9AD001F890C AS DateTime), N'Cancelado', 0, N'Sin Indicaciones', NULL, 0, NULL)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (40005, 3, 4, CAST(0x0000A9AD001F9F50 AS DateTime), CAST(0x0000A9AD001F9F50 AS DateTime), CAST(0x0000A9AD001F9F50 AS DateTime), N'Espera', 0, N'Sin Indicaciones', NULL, 0, NULL)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (40006, 2, 4, CAST(0x0000A9AD00279B10 AS DateTime), CAST(0x0000A9AD002D9C90 AS DateTime), CAST(0x0000A9AD002DA398 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'Diag 2', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (40007, 2, 2, CAST(0x0000A9AD0027AEFC AS DateTime), CAST(0x0000A9AD002D96B4 AS DateTime), CAST(0x0000A9AD002DA140 AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', N'Diag 1', 0, 0)
GO
INSERT [dbo].[Turnos] ([Id], [UserId], [PacienteId], [HoraRecepcion], [HoraComienzoConsulta], [HoraFinalConsulta], [Estado], [IdDerivado], [Indicaciones], [DiagnosticoFinal], [CIE10], [ControlEmbarazo]) VALUES (40008, 2, 1, CAST(0x0000A9AD002FA60C AS DateTime), CAST(0x0000A9AD002FBC50 AS DateTime), CAST(0x0000A9AD002FC22C AS DateTime), N'Finalizado', 0, N'Sin Indicaciones', NULL, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[Turnos] OFF
GO
ALTER TABLE [dbo].[CIE10] ADD  CONSTRAINT [DF_CIE10_Counter]  DEFAULT ((0)) FOR [Counter]
GO
ALTER TABLE [dbo].[Diagnosticos] ADD  CONSTRAINT [DF_Diagnosticos_HUID]  DEFAULT (newid()) FOR [HUID]
GO
ALTER TABLE [dbo].[Pacientes] ADD  CONSTRAINT [DF_Table_1_]  DEFAULT (newid()) FOR [GUID]
GO
ALTER TABLE [dbo].[Turnos] ADD  CONSTRAINT [DF_Turnos_CIE10]  DEFAULT ((0)) FOR [CIE10]
GO
