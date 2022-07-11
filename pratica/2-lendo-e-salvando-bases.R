# Exemplo 1: leitura da base da dados imdb_nao_estruturada.xlsx ----------

# carregando o pacote readxl
library(readxl)

# lendo a base de dados
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx")

# ler a base pulando as linhas do começo
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4)

# tirar o cabeçalho da base
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4,
                   col_names = FALSE)

# lendo a tabela com o nome das colunas
colunas <- read_excel("dados/imdb_nao_estruturada.xlsx",
                      sheet = "Sheet1")

# funcao que da o nome das colunas da base de dados
names(imdb)

# vetor com os nomes das colunas
colunas$nome

# colocando o nome das colunas
names(imdb) <- colunas$nome

# mostra as primeiras 6 linhas da base de dados
head(imdb)

# mostra as ultimas 6 linhas da base de dados
tail(imdb)

# lendo a base de dados sem a as ultimas linhas
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4,
                   col_names = FALSE,
                   n_max = 3713)

# veja que agora as duas linhas "erradas" foram retiradas
tail(imdb)

# fazendo a leitura "bonitinha" da base de dados, direto
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4,
                   col_names = colunas$nome,
                   n_max = 3713)


# Exemplo 2: importar dados com o Import Dataset --------------------------

# Passo 1: ir até onde queremos buscar o link da tabela 
# http://orcamento.sf.prefeitura.sp.gov.br/orcamento/execucao.php

# Passo 2: encontrar o link do arquivo .xlsx

# Passo 3: No painel Environment -> Import dataset -> From excel..

# Passo 4: Colar o link, e depois de verificar que está correto
# a simulação da importação, copiar o código para o script:


library(readxl)
url <- "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/2022/basedadosexecucao2022.xlsx"
destfile <- "basedadosexecucao2022.xlsx"
curl::curl_download(url, destfile)
basedadosexecucao2022 <- read_excel(destfile)
View(basedadosexecucao2022)


# EXPLICAÇÃO PASSO A PASSO DO SCRIPT
# carregando o pacote readxl
library(readxl)

# criando objeto com a url da base de dados que queremos ler
url <- "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/2022/basedadosexecucao2022_0622.xlsx"

# nome que queremos salvar a base de dados no nosso computador
destfile <- "basedadosexecucao2022_0622.xlsx"

# baixando a base de dados para o seu computador
curl::curl_download(url, destfile)

# fazendo a leitura da base de dados
basedadosexecucao2022_0622 <- read_excel(destfile)

# visualizando a base de dados
View(basedadosexecucao2022_0622)

# install.packages("janitor")

library(janitor)

# a funcao clean_names do pacote janitor
# padroniza os nomes das colunas e deixa "bonitinho"

dados_nomes_arrumados <- clean_names(basedadosexecucao2022_0622)


# Exemplo 3: Importar dados do google sheets -------------------------------------

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




# Exemplo 4: ler a base IMDB separada por ano -------------------------------------------------------------------------


library(readr)

# Lendo uma base
imdb <- read_rds("dados/por_ano/imdb_1916.rds")

# Lendo várias bases
arquivos <- list.files("dados/por_ano/", full.names = TRUE)

purrr::map(arquivos, read_rds)

imdb_varios_anos <- purrr::map_dfr(arquivos, read_rds)
