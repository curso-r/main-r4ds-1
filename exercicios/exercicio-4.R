# Treinando as funções:

# dplyr::select()
# dplyr::arrange()
# dplyr::filter()
# dplyr::count()
# dplyr::distinct()

# Carregando dados
library(abjData)
library(tidyverse)
dados_pnud <- pnud_min
dados_pnud |> names()
# "ano"       "muni_id"   "muni_nm"   "uf_sigla"  "regiao_nm" "idhm"
# "idhm_e"    "idhm_l"    "idhm_r"    "espvida"   "rdpc"      "gini"
# "pop"  "lat"       "lon"

# Dica: para alguns exercícios, é importante filtrar os dados de 2010, pois
# a base apresenta dados de 3 anos diferentes, o que triplica os municípios na base.
distinct(dados_pnud, ano)

# Exercicio 1) Crie uma tabela com o número de municípios por estado.

# Exercício 2) Crie uma tabela com o número de municípios por região.

# Exercício 3) Crie uma tabela com o número de municípios por região,
# ordenada por número de municípios.

# Exercício 4) Crie uma tabela com o número de municípios por região,
# ordenada por número de municípios, em ordem decrescente.


# Exercício 5) Crie uma tabela, com dados de 2010, que apresente o nome dos municípios,
# a sigla do estado e a população do município, ordenada de forma decrescente pela
# população.

# DICAS DO PASSO A PASSO:
# a) Usando os dados dados_pnud, selecione as colunas ano, muni_nm,
# uf_sigla e pop, nesta ordem.
# b) Filtre apenas os dados de 2010.
# c) Ordene os dados por população, em ordem decrescente.


# Exercício 6) Crie uma tabela, com dados de 2010, que apresente o nome do
#  município, a sigla do estado e a população, para municípios com mais de 1 milhão
#  de habitantes, ordenada por população, em ordem decrescente.


# Exercício 7) Crie uma tabela, com dados de 2010, que apresente o nome do município,
# a sigla do estado e o IDH municipal (idhm), ordenando para apresentar
# primeiro os municípios com maior IDH municipal.
