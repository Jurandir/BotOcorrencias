
let casual     = [['01','01'],['28','15'],['58','15'],['50','15'],['26','15'],['27','15'],['79','03'],['78','09'],['81','08'],['80','15'],['44','15'],['05','15'],['21','15'],['43','15'],['06','15'],['19','11'],['39','15'],['95','15'],['46','15'],['60','15'],['35','15'],['04','15'],['77','15'],['07','15'],['10','15'],['12','15'],['13','15'],['16','15'],['25','15'],['09','15'],['30','15'],['51','15'],['29','18'],['84','15'],['11','10'],['19','15'],['88','13'],
                  ['02','16'],['03','17'],['33','01'],['98','15'],['16','15'],['18','15'],['92','15']]
let transporte = [['01','01'],['28','03'],['58','04'],['50','06'],['26','08'],['27','09'],['79','11'],['78','12'],['81','13'],['80','14'],['44','15'],['05','16'],['21','17'],['43','18'],['06','19'],['19','20'],['39','22'],['95','23'],['46','26'],['60','27'],['35','30'],['04','33'],['77','35'],['07','36'],['10','37'],['12','38'],['13','39'],['16','40'],['25','47'],['09','77'],['30','78'],['51','79'],['29','90'],['84','91'],['11','01'],['19','01'],['88','01'],
                  ['81','01'],['02','01'],['03','01'],['33','01'],['98','88'],['16','01'],['18','01'],['92','01']]
let tabela = []                  

function seek( value, array ) {
    let len = array
    let ret = ''
    array.forEach((item)=>{
      if( (item[0]==value) && (!ret)) { 
          ret = item[1] 
      }
    })
    return ret
}

transporte.forEach((item,index)=>{
    let i = item    
    i[2] = seek(i[0],casual)
    let a = [i[0],i[2],i[1]]
    tabela.push(a)
})

tabela.sort()

tabela.forEach((i)=>{
    s = `INSERT INTO DE_PARA_OCORRENCIAS(CNPJ,CARGAS_ID,CASUAL_ID,TRANSPORTE_ID) VALUES ('43854116006727','${i[0]}','${i[1]}','${i[2]}');`
    console.log(s)
})
