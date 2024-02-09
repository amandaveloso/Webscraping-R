library(httr2)
curl https://api.openai.com/v1/chat/completions \ # nolint
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
     "model": "gpt-3.5-turbo",
     "messages": [{"role": "user", "content": "Say this is a test!"}],
     "temperature": 0.7
   }'



url1 <- "https://api.openai.com/v1/chat/completions"

headers <- c(`Content-Type` = "application/json",
             `Authorization` = "Bearer CHAVE")



decisao <- readLines("decisao.txt")

body <- list(model = "gpt-3.5-turbo",
             messages = list(
             list(`role` = "user", 
             content = glue::glue("Faça um breve resumo da decisão judicial a seguir, delimitada por três apóstrofes 
                 ```{decisao}```")),
             list(`role` = 'user',
                  content = "A decisão foi procedente, improcedente, ou parcialmente procedente? responda apenas procedente, improcedente ou parcial."),
             list(role = "user",
                  content = "Quais os artigos de lei citados? separe-os por ponto e vírgula."),
             list(role = "user",
                  content = "Se a decisão foi procedente. Houve condenação por danos morais? responda apenas sim ou não."),
             list(role = "user",
                  content = "Se houve condenação por danos morais, qual foi o valor em reais? coloque apenas o valor."),
             list(role = "system",
                  content = "Retorne respostas em formato json com as seguintes chaves: resumo, merito,artigos, dano_moral, valor")   
             ),
                             temperature = 0)

library(httr2)

resposta <- url1 |> 
            request() |> 
            req_headers(!!!headers) |> 
            req_body_json(body) |> 
            req_perform()


r1 <- resposta |> 
  resp_body_json() |> 
  purrr::pluck("choices",1,"message","content")


df <- jsonlite::fromJSON(r1) |> as.data.frame()
