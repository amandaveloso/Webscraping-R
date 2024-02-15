gpt_extrair <- function(texto,
                        modelo = "gpt-3.5-turbo",
                        api_key = NULL,
                        temperatura = 0,
                        perguntas = NULL,
                        colunas = NULL
){
  
  url1 <- "https://api.openai.com/v1/chat/completions"
  
  
  
  headers <- c(`Content-Type` = "application/json",
               `Authorization` = glue::glue("Bearer {api_key}")
  )
  
  
  body <- list(model = modelo,
               messages = list(
                 list(role = "system",
                      content = glue::glue("Considere a decisão judicial a seguir, demarcada por três apóstrofes ```{texto}```"))
                 
                 
               ),
               temperature = temperatura)
  
  
  for (i in 1:length(perguntas)){
    
    body$messages <- append(body$messages, list(list(role = "user", content = perguntas[i])))
    
    
  }
  
  chaves <- paste(colunas, collapse = ", ")
  
  body$messages <- append(body$messages, list(list(role= "system",
                                                   content = paste0("Retorne as respostas em formato json com as seguintes chaves: ",chaves ) )))
  
  
  url1 |> 
    httr2::request() |> 
    httr2::req_headers(!!!headers) |> 
    httr2::req_body_json(body) |> 
    httr2::req_perform() |> 
    httr2::resp_body_json() |> 
    purrr::pluck("choices",1,"message","content") |> 
    jsonlite::fromJSON() |> 
    as.data.frame()
  
}
