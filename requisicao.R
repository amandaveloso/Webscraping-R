#script sobre como realizar requisicao
library(httr2)
url <- "https://esaj.tjsp.jus.br/cjpg/pesquisar.do?conversationId=&dadosConsulta.pesquisaLivre=dano+moral&tipoNumero=UNIFICADO&numeroDigitoAnoUnificado=&foroNumeroUnificado=&dadosConsulta.nuProcesso=&dadosConsulta.nuProcessoAntigo=&classeTreeSelection.values=&classeTreeSelection.text=&assuntoTreeSelection.values=&assuntoTreeSelection.text=&agenteSelectedEntitiesList=&contadoragente=0&contadorMaioragente=0&cdAgente=&nmAgente=&dadosConsulta.dtInicio=&dadosConsulta.dtFim=18%2F01%2F2024&varasTreeSelection.values=&varasTreeSelection.text=&dadosConsulta.ordenacao=DESC"
r1 <- url |> 
  request() |> 
  req_perform(path = "r1.html")
r1
url1 <- "https://www.tjsp.jus.br/cac/scp/aprcdocumentoblobopen.aspx?100"
r2 <- url1 |> 
  request() |> 
  req_perform(path = "r2.pdf")
r2$body
url3 <- "https://www.tjsp.jus.br/cac/scp/aprcdocumentoblobopen.aspx?101"
  url3 |> 
  request() |> 
  req_perform(path = "r3.pdf")
  
urlparseada <- url_parse(url)

dput(urlparseada$query)


query <-
  list(
    conversationId = "",
    dadosConsulta.pesquisaLivre = "dano+material",
    tipoNumero = "UNIFICADO",
    numeroDigitoAnoUnificado = "",
    foroNumeroUnificado = "",
    dadosConsulta.nuProcesso = "",
    dadosConsulta.nuProcessoAntigo = "",
    classeTreeSelection.values = "",
    classeTreeSelection.text = "",
    assuntoTreeSelection.values = "",
    assuntoTreeSelection.text = "",
    agenteSelectedEntitiesList = "",
    contadoragente = "0",
    contadorMaioragente = "0",
    cdAgente = "",
    nmAgente = "",
    dadosConsulta.dtInicio = "18/01/2024",
    dadosConsulta.dtFim = "25/01/2024",
    varasTreeSelection.values = "",
    varasTreeSelection.text = "",
    dadosConsulta.ordenacao = "DESC"
  )

urlparseada$query <- query
urlparseada

url4 <- url_build(urlparseada)
  url4 |> 
  request() |> 
  req_perform(path = "danomaterial.html")
  
  
busca <- r"("dano material" E SERASA)"
urlparseada$query$dadosConsulta.pesquisaLivre <- busca

url5 <- url_build(urlparseada)
url5 |> 
  request() |> 
  req_perform(path = "danomaterial.html")

urlparseada$query$classeTreeSelection.values <- ""
urlparseada$query$assuntoTreeSelection.values <- ""
urlparseada$query$dadosConsulta.dtInicio <- "01/01/2023"
urlparseada$query$dadosConsulta.dtFim <- "31/12/2023"
urlparseada$query$dadosConsulta.pesquisaLivre <- r"("perda de uma chance")"
urlparseada$query$classeTreeSelection.values <- "8501"
urlparseada$query$assuntoTreeSelection.values <- "10431,10439,15046,15048,10440,10441,10442,10443,10433,15047,15049,10434,10435,10436,10437,14694,50466,10438,50950"

url6 <- url_build(urlparseada)
url6 |> 
  request() |> 
  req_perform(path = "perdachance.html")

baixar_cjpg <- function(busca = "", classe = "", 
                        assunto = "", dtInicio = "",
                        dtFim = "", magistrado = "",
                        diretorio = "."){
  
  
urlparseada <- structure(
    list(
      scheme = "https",
      hostname = "esaj.tjsp.jus.br",
      username = NULL,
      password = NULL,
      port = NULL,
      path = "/cjpg/pesquisar.do",
      query = list(
        conversationId = "",
        dadosConsulta.pesquisaLivre = busca,
        tipoNumero = "UNIFICADO",
        numeroDigitoAnoUnificado = "",
        foroNumeroUnificado = "",
        dadosConsulta.nuProcesso = "",
        dadosConsulta.nuProcessoAntigo = "",
        classeTreeSelection.values = classe,
        classeTreeSelection.text = "",
        assuntoTreeSelection.values = assunto,
        assuntoTreeSelection.text = "",
        agenteSelectedEntitiesList = "",
        contadoragente = "0",
        contadorMaioragente = "0",
        cdAgente = "",
        nmAgente = "",
        dadosConsulta.dtInicio = dtInicio,
        dadosConsulta.dtFim = dtFim,
        varasTreeSelection.values = "",
        varasTreeSelection.text = "",
        dadosConsulta.ordenacao = "DESC",
        `dadosConsulta.agentes[0].cdAgente` = magistrado
      ),
      fragment = NULL
    ),
    class = "httr2_url"
  )

uri <- httr2::url_build(urlparseada)

arquivo <- file.path(diretorio, "cjpg.html")

uri |> 
  httr2::request() |> 
  httr2::req_perform(path = arquivo)

}


baixar_cjpg(busca = "crime", dtInicio = "01/01/2023", dtFim = "31/12/2023", magistrado = "7753", diretorio = "data-raw")



