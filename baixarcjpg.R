#' Esta funcao para baixar consulta de julgados de primeiro grau do tjsp
#'
#' @param busca texto da busca livre
#' @param classe codigo da classe processual conforme tpu cnj
#' @param assunto codigo do assunto conforme tpu cnj 
#' @param dtInicio data inicial no formato dd/mm/aaaa
#' @param dtFim data final no formato dd/mm/aaaa
#' @param magistrado codigo do magistrado conforme tribunal
#' @param diretorio diretorio onde armazenar os htmls
#'
#' @return retorna arquivo em html
#' @export
#'
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
        `dadosConsulta.agentes[0].cdAgente` = magistrado,
        dadosConsulta.dtInicio = dtInicio,
        dadosConsulta.dtFim = dtFim,
        varasTreeSelection.values = "",
        varasTreeSelection.text = "",
        dadosConsulta.ordenacao = "DESC"
        
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