### Preparação para o dplyr/Manipulação


library(abjData)
library(tidyverse)
dados_pnud <- pnud_min


# Esse tópico será abordado na aula seguinte, mas o objetivo deste exercício
# é já ir se acostumando com o conteúdo!
# A ideia é que vocês interpretem os códigos a seguir
# (olhando o código e o resultado), e tentem explicar o que acham que aconteceu.
#
# Para ajudar, segue um resumo de algumas funções útes:
#
# - `select()`: seleciona colunas da base de dados
# - `filter()`: filtra linhas da base de dados
# - `arrange()`: reordena as linhas da base de dados
# - `mutate()`: cria novas colunas da base de dados (ou atualiza as colunas existentes)
# - `group_by()` + `summarise()`: agrupa e sumariza da base de dados
# - `count()`: faz uma contagem por grupos
#
# Já vimos que podemos filtar os dados da seguinte forma: no exemplo a seguir
# buscamos as linhas onde o ano seja igual à 2010.
#

filter(dados_pnud, ano == 2010)

#
# Podemos reescrever esse código desta forma, usando o pipe, que é usado para
# criar sequências de códigos:
#

dados_pnud |>
  filter(ano == 2010)

# Vamos ver o pipe em outro exemplo! O que você acha que a função abaixo fez?
# Execute e veja o resultado. Pode escrever com as suas palavras :)
#
# SUA INTERPRETAÇÃO: ...

dados_pnud_2010 |>
  count(uf_sigla)

#
#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  count(regiao_nm)

#
#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  count(regiao_nm) |>
  arrange(n)

# SUA INTERPRETAÇÃO: ...
#
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop)

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000)

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000) |>
  arrange(desc(pop))

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000) |>
  arrange(desc(pop)) |>
  mutate(pop_milhoes = pop / 1000000)

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000) |>
  arrange(desc(pop)) |>
  mutate(pop_milhoes = round(pop / 1000000, 2))
