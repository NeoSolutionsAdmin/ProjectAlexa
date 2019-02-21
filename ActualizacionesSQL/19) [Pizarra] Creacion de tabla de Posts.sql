/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PizarraPosts
	(
	Id bigint NOT NULL IDENTITY (1, 1),
	TituloPost varchar(60) NOT NULL,
	IdProfesional bigint NOT NULL,
	FechaCreacion datetime NOT NULL,
	IdPaciente bigint NOT NULL,
	Estado varchar(20) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PizarraPosts ADD CONSTRAINT
	PK_PizarraPosts PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PizarraPosts SET (LOCK_ESCALATION = TABLE)
GO
COMMIT