CREATE TABLE [dbo].[CronogramaLaboral](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[EntradaJornada] [datetime] NOT NULL,
	[SalidaJornada] [datetime],
	[Horas] [decimal](4, 2),
 CONSTRAINT [PK_CronogramaLaboral] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE PROCEDURE InsertarPeriodo_Cronograma_Entrada
(
@UserId bigint,
@EntradaJornada varchar(50)
) 
as 
begin 
insert into CronogramaLaboral(UserId,EntradaJornada) values (@UserId,Convert(datetime,@EntradaJornada,120))
end
GO
CREATE PROCEDURE InsertarPeriodo_Cronograma_Salida
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
CREATE PROCEDURE SeleccionarPeriodo_Cronograma_Ultimo (@UserId bigint)
as
begin
select top 1 * from CronogramaLaboral where UserId=@UserId
end
GO
CREATE PROCEDURE SeleccionarPeriodo_Cronograma_Periodo 
(
@UserId bigint, 
@PeriodoStart varchar(50), 
@PeriodoEnd varchar(50)
)
as
begin
select * from CronogramaLaboral where UserId=@UserId and EntradaJornada between Convert(Datetime,@PeriodoStart,120) and Convert(Datetime,@PeriodoEnd,120)
end