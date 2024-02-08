#3a etapa: Extrair dados e colocar numa tabela

library(tidyverse)

x  <- '<html>
     <head>
         <meta charset="utf-8">
     </head>
     <body>
         <div class="julgado">
             <a href="https://link_para_documento"></a>
            <div class="processo">1234567-23.2022.8.26.0000</div>
            <div class="assunto">Dano moral</div>
            <div class="colegiado">
                  Relator: fulano de tal
                  <br>
                  Revisor: Sicrano
                  <br>
                  Presidente: Beltrano
            </div>
            <div class="classe processual">Procedimento Comum Cível</div>
         </div>
      </body>
  </html>'


library(xml2)

x |>
  read_html()|>
  xml_find_all("//div[@class='processo']")|>
  xml_text()


x |>
  read_html()|>
  xml_find_all("//div[@class='assunto']")|>
  xml_text()

x |>
  read_html()|>
  xml_find_all("//div[@class='colegiado']")|>
  xml_text()

x |>
  read_html()|>
  xml_find_all("//div[@class='colegiado']/text()[3]")|>
  xml_text()

x <- read_html("danomaterial.html")
processo <- x |>
  xml_find_all("//span[@class='fonteNegrito']")|>
  xml_text(trim = TRUE)

classe <- x |>
  xml_find_all("//tr/td/strong[contains(.,'Classe:')]/..")|>
  xml_text(trim = TRUE)

x |>
  xml_find_all("//tr/td/strong[contains(.,'Classe:')]/parent::td")|>
  xml_text(trim = TRUE)

assunto <- x |>
  xml_find_all("//tr/td/strong[contains(.,'Assunto:')]/parent::td")|>
  xml_text(trim = TRUE)

magistrado <- x |>
  xml_find_all("//tr/td/strong[contains(.,'Magistrado:')]/parent::td")|>
  xml_text(trim = TRUE)

comarca <- x |>
  xml_find_all("//tr/td/strong[contains(.,'Comarca:')]/parent::td")|>
  xml_text(trim = TRUE)

vara <- x |>
  xml_find_all("//tr/td/strong[contains(.,'Vara:')]/parent::td")|>
  xml_text(trim = TRUE)

data_disponib <- x |>
  xml_find_all("//tr/td/strong[contains(.,'Data de Disponibiliza')]/parent::td")|>
  xml_text(trim = TRUE)

decisao <- x |>
  xml_find_all("//div[@align='justify'][@style='display: none;']")|>
  xml_text(trim = TRUE)

df <- tibble(processo, classe, assunto, magistrado, comarca, vara, data_disponib, decisao)

