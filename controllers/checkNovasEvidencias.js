const getEvidencias           = require('./getEvidencias')
const gravaRegistroEvidencias = require('./gravaRegistroEvidencias')
const sendLog                 = require('../utils/sendLog')
const easydocs                = require('../controllers/checkImagemEasyDocs')
const enviaEvidencias         = require('../controllers/enviaEvidencias')

async function checkNovasEvidencias() {  
    let ret   = { rowsAffected: 0, qtdeSucesso: 0,msg: '', isErr: false  }   
    let dados = await getEvidencias()
    let ultimo_doc

    function gravaEvidenciasLoad_OK(documento){
        let params = {
            documento: documento,
            enviado: 0,
            origem: 'EASYDOCS',
            load: 1,
            send: 0,
            protocolo: '',
        }
        gravaRegistroEvidencias(params)
    }
    function gravaEvidenciasSend_OK( documento, protocolo ){
        let params = {
            documento: documento,
            enviado: 1,
            origem: 'EASYDOCS',
            load: 0,
            send: 1,
            protocolo: protocolo,
        }
        gravaRegistroEvidencias(params)
    }
    
    if (dados.erro) {
        ret.isErr = true
        ret.msg   = JSON.stringify(dados.erro)
        sendLog('ERRO', ret.msg )
        return ret
    } 
    ret.rowsAffected = dados.length

    dados.forEach( async (element) => {
        evidencia = await easydocs(element.DOCUMENTO)
        if (evidencia.ok==true){
            ret.qtdeSucesso++
            let resultado    = {Mensagem:'Sem resposta',Protocolo:'[IMAGEM]',Sucesso:false}
            let isErr        = true
            let isAxiosError = true
            let resposta     = await enviaEvidencias( element, evidencia.imagem )

            try {
                isErr        = resposta.isErr
                isAxiosError = resposta.isAxiosError || false
                resultado    = resposta.dados.EvidenciaOcorrenciaResult
                gravaEvidenciasLoad_OK(element.DOCUMENTO)
            } catch (err) {
                isErr = true
                sendLog('WARNING',`Envio p/API-DOC:${element.DOCUMENTO} - (Sem Resposta)` )
            }

            if (isAxiosError==true) { 
                sendLog('ERRO',`Envio p/API-DOC:${element.DOCUMENTO} - (Axios ERRO)` ) 
            } else if ( resultado.Sucesso == false ) { 
                sendLog('WARNING',`Envio p/API-DOC: ${element.DOCUMENTO} - Ret API: ${resultado.Mensagem} - Prot: ${resultado.Protocolo}`)
            } else if ( resultado.Sucesso == true ) { 
                gravaEvidenciasSend_OK(element.DOCUMENTO, resultado.Protocolo)
                sendLog('SUCESSO',`Envio p/API-DOC: ${element.DOCUMENTO} - Ret API: ${resultado.Mensagem} - Prot: ${resultado.Protocolo}`)
            } else {
                sendLog('ALERTA',`Envio p/API-DOC: ${element.DOCUMENTO} - (Sem retorno)`)
            }

        } 
    })

    return ret   

}

module.exports = checkNovasEvidencias