body <- "conversationId=&dados.buscaInteiroTeor=%22homic%C3%ADdio+simples%22&dados.pesquisarComSinonimos=S&dados.pesquisarComSinonimos=S&dados.buscaEmenta=&dados.nuProcOrigem=&dados.nuRegistro=&agenteSelectedEntitiesList=&contadoragente=0&contadorMaioragente=0&codigoCr=&codigoTr=&nmAgente=&juizProlatorSelectedEntitiesList=&contadorjuizProlator=0&contadorMaiorjuizProlator=0&codigoJuizCr=&codigoJuizTr=&nmJuiz=&classesTreeSelection.values=&classesTreeSelection.text=&assuntosTreeSelection.values=&assuntosTreeSelection.text=&comarcaSelectedEntitiesList=&contadorcomarca=0&contadorMaiorcomarca=0&cdComarca=&nmComarca=&secoesTreeSelection.values=&secoesTreeSelection.text=&dados.dtJulgamentoInicio=&dados.dtJulgamentoFim=&dados.dtPublicacaoInicio=&dados.dtPublicacaoFim=&dados.origensSelecionadas=T&tipoDecisaoSelecionados=A&dados.ordenarPor=dtPublicacao"
httr2:::query_parse(body)|> dput()

baixar_tjsp <- function

body <- list(
  conversationId = "",
  dados.buscaInteiroTeor = busca,
  dados.pesquisarComSinonimos = "S",
  dados.pesquisarComSinonimos = "S",
  dados.buscaEmenta = "",
  dados.nuProcOrigem = "",
  dados.nuRegistro = "",
  agenteSelectedEntitiesList = "",
  contadoragente = "0",
  contadorMaioragente = "0",
  codigoCr = "",
  codigoTr = "",
  nmAgente = "",
  juizProlatorSelectedEntitiesList = "",
  contadorjuizProlator = "0",
  contadorMaiorjuizProlator = "0",
  codigoJuizCr = "",
  codigoJuizTr = "",
  nmJuiz = "",
  classesTreeSelection.values = "",
  classesTreeSelection.text = "",
  assuntosTreeSelection.values = "",
  assuntosTreeSelection.text = "",
  comarcaSelectedEntitiesList = "",
  contadorcomarca = "0",
  contadorMaiorcomarca = "0",
  cdComarca = "",
  nmComarca = "",
  secoesTreeSelection.values = "",
  secoesTreeSelection.text = "",
  dados.dtJulgamentoInicio = "",
  dados.dtJulgamentoFim = "",
  dados.dtPublicacaoInicio = "",
  dados.dtPublicacaoFim = "",
  dados.origensSelecionadas = "T",
  tipoDecisaoSelecionados = "A",
  dados.ordenarPor = "dtPublicacao"
)

url <- "https://esaj.tjsp.jus.br/cjsg/resultadoCompleta.do"

r1 <- url |> 
  httr2::request() |> 
  httr2::req_body_json(!!!body) |> 
  httr2::req_perform(path = "Webscraping/cjsg.html")

