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

# Objetivo: ler a base IMDB separada por ano

library(readr)

# Lendo uma base
imdb <- read_rds("dados/por_ano/imdb_1916.rds")

# Lendo várias bases
arquivos <- list.files("dados/por_ano/", full.names = TRUE)

purrr::map(arquivos, read_rds)

imdb <- purrr::map_dfr(arquivos, read_rds)

# -------------------------------------------------------------------------

# Objetivo: ler base imdb_nao_estruturada.xlsx (sem dplyr)

library(readxl)

imdb <- read_excel("dados/imdb_nao_estruturada.xlsx")

# Pulando linhas
read_excel(
  "dados/imdb_nao_estruturada.xlsx", 
  skip = 3
)

# Tirando cabeçalho
read_excel(
  "dados/imdb_nao_estruturada.xlsx", 
  skip = 3,
  col_names = FALSE
)

# Tirando últila linha
imdb <- read_excel(
  "dados/imdb_nao_estruturada.xlsx", 
  skip = 3,
  col_names = FALSE,
  n_max = 3713
)

# Colocando nome das colunas
colunas <- read_excel(
  "dados/imdb_nao_estruturada.xlsx",
  sheet = 2
)

names(imdb) <- colunas$nome

imdb <- read_excel(
  "dados/imdb_nao_estruturada.xlsx", 
  skip = 3,
  col_names = colunas$nome,
  n_max = 3713
)
