-- ( 27/11/2020 )
-- CARGASSQL.dbo.
-- SIC.dbo.
-- CREATE [ OR ALTER ] VIEW
USE [SIC]
GO

ALTER VIEW OCORRENCIAS_VW
AS
SELECT
    OUN.%%physloc%%               as ID,
	OUN.CHAVE                     as DOCUMENTO,
	CNH.CHAVECTE                  as CHAVE,
	CNH.CHAVECTEORIGEM            as CHAVEORIGINAL,
	CNH.CLI_CGCCPF_PAG            as CNPJ,
    OUN.DATA                      as DT_ATUAL,
	OUN.DATAOCO                   as DT_OCORRENCIA,
	OUN.DATAHORASOLUCAO           as DT_SOLUCAO,
	ORR.DT_ENVIO                  as DT_ENVIO,
	ISNULL(ORR.REPLICAR,'S')      as REPLICAR,  
	ORR.LATITUDE                  as LATITUDE,
    ORR.LONGITUDE                 as LONGITUDE,
    OUN.DESCRICAO                 as OBSERVACAO,  -- VERIFICAR
    DPA.CASUAL_ID                 as OCORR301,
    DPA.TRANSPORTE_ID             as OCORR302,
    DPA.CASUAL_ID                 as OCORRCASUAL,
    DPA.TRANSPORTE_ID             as OCORRTRANSPORTE,
    DPA.TRANSPORTE_ID             as OCORRSIMPLIFICADA,
	CLI.URL_OCORRENCIA            as URL_ENDPOINT,
	ORR.TIPOIMAGEM                as TIPOIMAGEM,
    ORR.RET_MENSAGEM              as RET_MENSAGEM,
    ORR.RET_PROTOCOLO             as RET_PROTOCOLO,
    ISNULL(ORR.RET_SUCESSO,0)     as RET_SUCESSO, 
	OUN.TABELA                    as OUN_TABELA,
	OUN.CHAVE                     as OUN_CHAVE,
	OUN.DATA                      as OUN_DATE,
	OUN.OCO_CODIGO                as OUN_CODIGO
FROM SIC.dbo.CONHECIMENTO CON
    JOIN  CARGASSQL.dbo.OUN              ON OUN.TABELA = 'CNH' AND 
	                                        OUN.CHAVE  = CON.DOCUMENTO
	JOIN CARGASSQL.dbo.CNH               ON CNH.EMP_CODIGO     = SUBSTRING(OUN.CHAVE,1,3)          AND 
											CNH.SERIE          = SUBSTRING(OUN.CHAVE,4,1)          AND 
											CNH.CTRC           = SUBSTRING(OUN.CHAVE,5,10)
    JOIN CARGASSQL.dbo.CTE               ON CTE.EMP_CODIGO_CNH = CNH.EMP_CODIGO	AND 
	                                        CTE.CNH_SERIE      = CNH.SERIE	AND 
											CTE.CNH_CTRC       = CNH.CTRC											
	JOIN SIC.dbo.CLIENTES CLI            ON CLI.CNPJ_CLI       = SUBSTRING(CNH.CLI_CGCCPF_PAG,1,8)  OR 
											CLI.CNPJ_CLI       = SUBSTRING(CNH.CLI_CGCCPF_DEST,1,8) OR
											CLI.CNPJ_CLI       = SUBSTRING(CNH.CLI_CGCCPF_REMET,1,8)
	LEFT JOIN SIC.dbo.OCORRENCIAS ORR    ON ORR.OUN_TABELA     = OUN.TABELA AND
	                                        ORR.OUN_CHAVE      = OUN.CHAVE  AND
											ORR.OUN_DATE       = OUN.DATA
    JOIN SIC.dbo.DE_PARA_OCORRENCIAS DPA ON DPA.CNPJ          = CLI.CNPJ_CLI AND DPA.CARGAS_ID = OUN.OCO_CODIGO
WHERE 
    -- OUN.DATA BETWEEN (CURRENT_TIMESTAMP-7) AND (CURRENT_TIMESTAMP+0) AND
	ORR.OUN_CODIGO IS NULL AND 
	CTE.PROTOCOLOCTE IS NOT NULL
;
GO
