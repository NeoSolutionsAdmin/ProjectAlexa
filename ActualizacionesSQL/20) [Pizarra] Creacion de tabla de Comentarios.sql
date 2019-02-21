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
CREATE TABLE dbo.PizarraComentarios
	(
	Id bigint NOT NULL IDENTITY (1, 1),
	IdPost bigint NOT NULL,
	Comentario varchar(280) NOT NULL,
	IdUser bigint NOT NULL,
	FechaCreacion datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PizarraComentarios ADD CONSTRAINT
	PK_PizarraComentarios PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PizarraComentarios SET (LOCK_ESCALATION = TABLE)
GO
COMMIT