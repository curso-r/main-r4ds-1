# Objetivo: ler a base IMDB e gerar uma tabela 
# com apenas as colunas filme e ano, ordenada por ano

library(readxl)
library(dplyr)

imdb <- read_excel("dados/imdb.xlsx")

imdb
glimpse(imdb)

# crescente
tab_solicitada <- imdb %>% 
  select(titulo, ano) %>% 
  arrange(ano)

writexl::write_xlsx(tab_solicitada, "tab_filmes_ord.xlsx")

# decrescente
tab_solicitada <- imdb %>% 
  select(titulo, ano) %>% 
  arrange(desc(ano))

writexl::write_xlsx(tab_solicitada, "tab_filmes_ord_desc.xlsx")


# -------------------------------------------------------------------------

# Objetivo: descobrir qual o filme mais caro, 
# mais lucrativo e com melhor nota dos anos 2000

library(readxl)
library(dplyr)

imdb <- read_excel("dados/imdb.xlsx")

## Filme mais caro ##

# Vai retornar uma tabela de 0 linhas
imdb %>% 
  filter(ano %in% 2000:2009, orcamento == max(orcamento))

# Usar na.rm = TRUE
imdb %>% 
  filter(
    ano %in% 2000:2009, 
    orcamento == max(orcamento, na.rm = TRUE)
  ) %>% 
  select(titulo, orcamento) %>% 
  mutate(orcamento = orcamento / 1e6)

# Por sorte dá certo, mas o certo seria
imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  filter(
    orcamento == max(orcamento, na.rm = TRUE)
  ) %>% 
  select(titulo, orcamento) %>% 
  mutate(orcamento = orcamento / 1e6)

# Como vamos usar várias vezes a base filtrada, 
# vamos criar a imdb_anos_2000

imdb_anos_2000 <- imdb %>% 
  filter(ano %in% 2000:2009)

## Filme mais lucrativo ##
imdb_anos_2000 %>% 
  mutate(lucro = receita - orcamento) %>% 
  filter(
    lucro == max(lucro, na.rm = TRUE)
  ) %>% 
  select(titulo, lucro) %>% 
  mutate(lucro = lucro / 1e6)

# Melhor nota ##
imdb_anos_2000 %>% 
  filter(
    nota_imdb == max(nota_imdb, na.rm = TRUE)
  ) %>% 
  select(titulo, nota_imdb)

## Fazendo para todas as décadas ##

imdb %>% 
  dplyr::filter(!is.na(ano)) %>% 
  mutate(
    decada = floor(ano / 10) * 10
  ) %>% 
  group_by(decada) %>% 
  filter(
    nota_imdb == max(nota_imdb, na.rm = TRUE)
  ) %>% 
  select(titulo, nota_imdb) %>% 
  arrange(decada)


# -------------------------------------------------------------------------

# Objetivo: descobrir qual o peso médio dos 
# personagens do Star Wars

library(dplyr)

View(starwars)

# Vai retornar NA
starwars %>% 
  summarise(peso_medio = mean(mass))

# colocar na.rm = TRUE
starwars %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

# Peso em quilos ou libras?
help(starwars)

# Peso por sexo
starwars %>% 
  group_by(sex) %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

# Tirando linhas com NA na coluna sexo
starwars %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex) %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

# Categorizando o NA
starwars %>% 
  mutate(sex = ifelse(is.na(sex), "sem informação", sex)) %>% 
  group_by(sex) %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

#tidyr::replace_na
starwars %>% 
  mutate(sex = tidyr::replace_na(sex, "sem informação")) %>% 
  group_by(sex) %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

# Peso por espécie
starwars %>% 
  group_by(species) %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

# Tirando linhas com NA antes
starwars %>% 
  filter(!is.na(mass)) %>% 
  group_by(species) %>% 
  summarise(peso_medio = mean(mass))

# Pegando as espécies mais pesadas
starwars %>% 
  filter(!is.na(mass)) %>% 
  group_by(species) %>% 
  summarise(peso_medio = mean(mass)) %>% 
  top_n(10, peso_medio) %>% 
  arrange(desc(peso_medio))

# Comparando com a altura
starwars %>% 
  filter(!is.na(mass), !is.na(height)) %>% 
  group_by(species) %>% 
  summarise(
    peso_medio = mean(mass),
    altura_media = mean(height)
  ) %>% 
  top_n(10, peso_medio) %>% 
  arrange(desc(peso_medio))

