# Treinar verbos do dplyr

# Ex 1: Volte no exercício 4, onde interpretamos alguns códigos de
# manipulação de dados feitos com dplyr.
# Revise o exercício, e note se a sua interpretação inicial estava
# correta!

# Ex 2: Leia o capítulo 7.2 do livro "Ciência de Dados em R"
# sobre o pacote dplyr
# https://livro.curso-r.com/7-2-dplyr.html


# Carregando dados
library(abjData)
library(tidyverse)
dados_pnud <- pnud_min
dados_pnud_uf <- pnud_uf




# Ex 3: Usando a tabela `dados_pnud`, vamos criar uma tabela com as seguintes informações:
#  Soma da população em milhões, no ano de 2010, agrupado por região do Brasil.
# A tabela deve estar ordenada de forma decrescente segundo a população em milhões.
# Exemplo do que queremos gerar:

# |Região	         |População em milhões (2010)|
# |----------------|---------|
# |Sudeste	       |  79.48  |
# |Nordeste	       |  52.01  |
# |Sul	           |  27.14  |
# |Norte	         |  15.18  |
# |Centro-Oeste	   |  13.84  |

# Escreva o código para gerar essa tabela a seguir:


# Ex 4: Usando as tabelas dados_pnud_uf e dados_pnud, responda as perguntas:


dados_pnud_uf |>
  glimpse()

dados_pnud |>
  glimpse()



# a) Qual a média de IDHM em 2010 para cada região do Brasil?

# b) Qual a média de IDHM em 2010 para cada estado do Brasil?

# c) A tabela abaixo (esp_vida_uf) apresenta a esperança de vida para cada estado do Brasil,
# nos diferentes anos do censo. Usando essa tabela e as funções do dplyr vistas
# no curso, busque responder: qual é o estado onde a esperança de vida mais cresceu entre
# 1991 e 2010? Qual é o estado onde a esperança de vida menos cresceu entre 1991 e 2010?

esp_vida_uf <- dados_pnud_uf |>
  select(ano, ufn, espvida) |>
  # alterando o formato da tabela: cada ano vira uma coluna, e os valores
  # de espvida são colocados em cada coluna.
  # essa função NÃO foi vista no curso, é conteúdo do R para Ciência de Dados II!
  pivot_wider(names_from = ano, values_from = espvida, names_prefix = "espvida_")






# Ex 4: Caso se sinta confortável lendo em inglês,
# leia este capítulo do livro R for Data Science sobre o pacote dplyr:
# https://r4ds.hadley.nz/data-transform

# Ex 5: Caso se sinta confortável lendo em inglês,
# leia este capítulo do livro R for Data Science sobre joins:
# https://r4ds.hadley.nz/joins
