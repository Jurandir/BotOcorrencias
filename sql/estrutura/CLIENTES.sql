/*
   quarta-feira, 4 de novembro de 202015:57:51
   Usuário: sa
   Servidor: 192.168.0.8
   Banco de Dados: SIC
   Aplicativo: 
*/

/* Para impedir possíveis problemas de perda de dados, analise este script detalhadamente antes de executá-lo fora do contexto do designer de banco de dados.*/
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
CREATE TABLE dbo.CLIENTES
	(
	CNPJ_CLI varchar(14) NOT NULL,
	SERVIDOR varchar(200) NULL,
	LOGIN varchar(50) NULL,
	SENHA varchar(250) NULL,
	URL_OCORRENCIA varchar(50) NULL,
	URL_OCORRENCIA_SIMPLIFICADA varchar(50) NULL,
	URL_OCORRENCIA_CLIENTE varchar(50) NULL,
	URL_EVIDENCIAR_OCORRENCIA varchar(50) NULL,
	CHAVE_PUBLICA varchar(250) NULL
	)  ON [PRIMARY]
GO
DECLARE @v sql_variant 
SET @v = N'Clientes monitorados'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'CLIENTES', NULL, NULL
GO
ALTER TABLE dbo.CLIENTES ADD CONSTRAINT
	PK_CLIENTES PRIMARY KEY CLUSTERED 
	(
	CNPJ_CLI
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.CLIENTES SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---- 05/11/2020 -- TESTE PROVISORIO
ALTER TABLE SIC.dbo.CLIENTES 
ADD DIAS_SQL INT DEFAULT 7 NOT NULL;

---- 18/11/2020
ALTER TABLE SIC.dbo.CLIENTES 
DROP COLUMN DIAS_SQL
;

ALTER TABLE SIC.dbo.CLIENTES 
ADD REF_LAYOUT INT DEFAULT 1 NOT NULL
;

UPDATE SIC.dbo.CLIENTES 
SET REF_LAYOUT = 2
WHERE CNPJ_CLI='62136304'
;
