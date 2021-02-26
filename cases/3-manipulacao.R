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
  



