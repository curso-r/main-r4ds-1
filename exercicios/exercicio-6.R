# Treinar verbos do dplyr
# count()
# filter()
# mutate()


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



# Exercício 1) Crie uma tabela chamada dados_pnud_2010, com apenas os dados de 2010.
# Vamos usar esse objeto daqui em diante!


# Exercicio 2) Crie uma tabela com o número de municípios por estado.



# Exercício 3) Crie uma tabela com o número de municípios por região.




# Exercício 4) Crie uma tabela com municípios que tinham uma população maior que 1 milhão
# de habitantes em 2010, ordenada por população, em ordem decrescente.



# Exercício 5) Usando a tabela acima, crie uma coluna de população em milhões de habitantes,
# chamada pop_milhoes, para facilitar a visualização dos dados. Exemplo:

# # A tibble: 14 × 4
#    muni_nm        uf_sigla      pop pop_milhoes
#    <chr>          <chr>       <int>       <dbl>
#  1 SÃO PAULO      SP       11166543       11.2
#  2 RIO DE JANEIRO RJ        6262802        6.26
#  3 SALVADOR       BA        2647972        2.65
#  4 BRASÍLIA       DF        2541714        2.54
#  5 FORTALEZA      CE        2424565        2.42
#  6 Belo Horizonte MG        2356178        2.36
#  7 MANAUS         AM        1787596        1.79
#  8 CURITIBA       PR        1740627        1.74
#  9 RECIFE         PE        1522583        1.52
# 10 PORTO ALEGRE   RS        1393799        1.39
# 11 BELÉM          PA        1381212        1.38
# 12 GOIÂNIA        GO        1297017        1.30
# 13 GUARULHOS      SP        1212934        1.21
# 14 CAMPINAS       SP        1071443        1.07
