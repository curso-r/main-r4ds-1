# Objetivo: ler a base IMDB e gerar uma tabela 
# com apenas as colunas filme e ano, ordenada por ano

# carregando as bibliotecas que vamos usar
library(readxl)
library(dplyr)

# lendo os dados
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
  filter(ano %in% 2000:2009, num_avaliacoes > 1000)

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
  dplyr::filter(!is.na(ano), num_avaliacoes > 1000) %>% 
  mutate(
    decada = floor(ano / 10) * 10
  ) %>% 
  group_by(decada) %>% 
  filter(
    nota_imdb == max(nota_imdb, na.rm = TRUE)
  ) %>% 
  select(titulo, nota_imdb) %>% 
  arrange(decada)

# Objetivo : mostrar relocate e rename ------

# quero mudar a coluna "producao" para "estudio"

imdb_renomeado <- imdb %>% 
  rename(estudio = producao)

# quero criar uma coluna nova "lucro"
# e quero que ela fique depois da coluna "receita"
imdb_lucro <- imdb %>% 
  mutate(lucro = receita - orcamento) %>% 
  relocate(lucro, .after = receita)

imdb_lucrou <- imdb %>% 
  mutate(lucro = receita - orcamento,
         lucrou = lucro > 0,
         .after = receita)

# -------------------------------------------------------------------------

# Objetivo: descobrir qual o peso médio dos 
# personagens do Star Wars

# instalando pacote dados
install.packages("dados")

library(dados)

starwars <- dados::dados_starwars

# Vai retornar NA
starwars %>% 
  summarise(peso_medio = mean(massa))

# colocar na.rm = TRUE
starwars %>% 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Peso em quilos ou libras?
help(dados_starwars)

# Peso por sexo
starwars %>% 
  group_by(sexo_biologico) %>% 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Tirando linhas com NA na coluna sexo
starwars %>% 
  filter(!is.na(sexo_biologico)) %>% 
  group_by(sexo_biologico) %>% 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Categorizando o NA
starwars %>% 
  mutate(sexo_biologico = ifelse(is.na(sexo_biologico), "sem informação", sexo_biologico)) %>% 
  group_by(sexo_biologico) %>% 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

#tidyr::replace_na
starwars %>% 
  mutate(sexo_biologico = tidyr::replace_na(sexo_biologico, "sem informação")) %>% 
  group_by(sexo_biologico) %>% 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Peso por espécie
starwars %>% 
  group_by(especie) %>% 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Tirando linhas com NA antes
starwars %>% 
  filter(!is.na(massa)) %>% 
  group_by(especie) %>% 
  summarise(peso_medio = mean(massa))

# Pegando as espécies mais pesadas
starwars %>% 
  filter(!is.na(massa)) %>% 
  group_by(especie) %>% 
  summarise(peso_medio = mean(massa)) %>% 
  slice_max(order_by = peso_medio, n = 10) %>% 
  arrange(desc(peso_medio))

# Comparando com a altura
starwars %>% 
  filter(!is.na(massa), !is.na(altura)) %>% 
  group_by(especie) %>% 
  summarise(
    peso_medio = mean(massa),
    altura_media = mean(altura)
  ) %>% 
  slice_max(order_by = peso_medio, n = 10) %>% 
  arrange(desc(peso_medio))



## ------------------
# IMDB: Objetivo: criar uma tabela sumarizando as produtoras, ordenadas por lucro.
imdb_produtoras <- imdb %>% 
  drop_na(orcamento, receita) %>% 
  mutate(lucro = receita - orcamento) %>% 
  group_by(producao) %>% 
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    media_lucro = mean(lucro, na.rm = TRUE),
    qtd = n(),
    qtd_direcao = n_distinct(direcao),
    filmes = knitr::combine_words(titulo, sep = ", ", and = " e ", oxford_comma = FALSE)
  ) %>%
  arrange(desc(media_lucro)) 

imdb_produtoras %>% 
  write_csv2("dados_output/imdb_produtoras.csv")


imdb_produtoras
