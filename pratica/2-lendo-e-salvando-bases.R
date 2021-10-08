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


# Exemplo! Importar dados do google sheets -------------------------------------

# Instalar pacotes necessários:
# install.packages("googlesheets4")
# install.packages("cli")

# Carregar pacote googlesheets4
library(googlesheets4)


# copiar a url/link da planilha que queremos acessar
url_planilha <- "https://docs.google.com/spreadsheets/d/1U6Cf_qEOhiR9AZqTqS3mbMF3zt2db48ZP5v3rkrAEJY/edit#gid=780868077"

# ler a planilha
planilha_gapminder <- read_sheet(url_planilha)

# ver as propriedades da planilha (conseguimos descobrir quais sheets 
# estão disponíveis)
sheet_properties(url_planilha)

# abrir uma sheet específica: pela posição
planilha_asia <- read_sheet(url_planilha, sheet = 3)

# abrir uma sheet específica: pelo nome
planilha_asia <- read_sheet(url_planilha, sheet = "Asia")

# Exemplo: importar dados com o Import Dataset ------

# Passo 1: ir até onde queremos buscar o link da tabela 
# http://orcamento.sf.prefeitura.sp.gov.br/orcamento/execucao.php

# Passo 2: encontrar o link do arquivo .xlsx

# Passo 3: No painel Environment -> Import dataset -> From excel..

# Passo 4: Colar o link, e depois de verificar que está correto
# a simulação da importação, copiar o código para o script:


library(readxl)
url <- "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/2021/basedadosexecucao2021.xlsx"
destfile <- "basedadosexecucao2021.xlsx"
curl::curl_download(url, destfile)
basedadosexecucao2021 <- read_excel(destfile)
View(basedadosexecucao2021)