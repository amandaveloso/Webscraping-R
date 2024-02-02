# BAIXANDO os pacotes remotos
remotes::install_github("jjesusfilho/trts", 
                        auth_token="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")

#Importando a biblioteca
library(trts)

trt_dados_basicos(trt = 2, processos = "1000626-42.2021.5.02.0080", diretorio = "Webscraping")

#Saida em JSON - Arquivo 

trt_baixar_por_id(trt=2,ids = "3979241", diretorio = "Webscraping")

# Saída em JSON com todos os dados do processo. 
