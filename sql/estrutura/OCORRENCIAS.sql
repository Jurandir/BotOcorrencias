USE [SIC]
GO

CREATE TABLE OCORRENCIAS (
  ID                INT           NOT NULL    IDENTITY    PRIMARY KEY,
  CNPJ              VARCHAR(14)   NOT NULL,
  DOCUMENTO         VARCHAR(20),
  CHAVE             VARCHAR(44),
  CHAVEORIGINAL     VARCHAR(44),
  DT_ATUAL          DATETIME DEFAULT CURRENT_TIMESTAMP,
  DT_OCORRENCIA     DATETIME,
  DT_SOLUCAO        DATETIME,
  DT_ENVIO          DATETIME,
  REPLICAR          VARCHAR(1)  DEFAULT 'S',
  LATITUDE          VARCHAR(20) DEFAULT '',
  LONGITUDE         VARCHAR(20) DEFAULT '',
  OBSERVACAO        VARCHAR(250),
  OCORR301          INT,
  OCORR302          INT,
  OCORRCASUAL       INT,
  OCORRTRANSPORTE   INT,
  OCORRSIMPLIFICADA INT,
  URL_ENDPOINT      VARCHAR(80),
  TIPOIMAGEM        VARCHAR(2)     DEFAULT '1',
  FILE_IMAGEM       VARCHAR(200),
  RET_MENSAGEM      VARCHAR(80),
  RET_PROTOCOLO     VARCHAR(80),
  RET_SUCESSO       INT            DEFAULT 0,
  OUN_TABELA        VARCHAR(20)    NOT NULL,
  OUN_CHAVE         VARCHAR(20)    NOT NULL,
  OUN_DATE          DATETIME       NOT NULL,
  OUN_CODIGO        INT            NOT NULL,
  QTD_REENVIO       INT            DEFAULT 0
);

---- 10/11/2020 -- Controle de reenvios
ALTER TABLE SIC.dbo.OCORRENCIAS 
ADD QTD_REENVIO INT DEFAULT 0;

----- 03/12/2020
ALTER TABLE OCORRENCIAS ADD DEFAULT '1' FOR TIPOIMAGEM;