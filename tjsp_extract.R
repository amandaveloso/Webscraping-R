install.packages("remotes")
remotes::install_github("jjesusfilho/tjsp")
dir.create("diretorio_novo")

#########
# livre - inserir termo das pesquisas - diretorio criado
tjsp_baixar_cjpg(livre="dano moral E dano material NAO cancelamento", diretorio="diretorio_novo")

tabela <- tjsp_ler_cjpg(diretorio = "tjsp_procedentes") 

# salvando em CSV

write.csv(tabela, "julgados.csv", row.names = FALSE)      