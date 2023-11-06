library(tidyverse)

# Caminhos até o arquivo --------------------------------------------------

# diretório de trabalho - onde o R vai buscar ou salvar arquivos.
getwd()
# com projetos, o diretorio de trabalho é a pasta do projeto!


# Caminhos absolutos - Não é uma boa prática
"/home/william/Documents/Curso-R/main-r4ds-1/dados/imdb.csv"

# imdb <- leitura("~/Desktop/material_do_curso-r-para-ciencia-de-dados/dados/imdb.csv")

# Caminhos relativos - partem do diretório de trabalho
"dados/imdb.csv"
"dados/imdb.csv"

# (cara(o) professora(o), favor lembrar de falar da dica
# de navegação entre as aspas)

# Tibbles -----------------------------------------------------------------

airquality

iris

class(airquality)

as_tibble(airquality)

class(as_tibble(airquality))


t_airquality <- as_tibble(airquality)

class(t_airquality)


# Lendo arquivos de texto -------------------------------------------------

# Quais formatos vocês costumam usar?





# readr - pacote para importacao

# CSV, separado por vírgula-  comma separated values
imdb_csv <- read_csv("dados/imdb.csv")

# CSV, separado por ponto-e-vírgula
imdb_csv2 <- read_csv2("dados/imdb2.csv")

# TXT, separado por tabulação (tecla TAB)
imdb_txt <- read_delim("dados/imdb.txt", delim = "\t") # \t representa o tab

# A função read_delim funciona para qualquer tipo de separador
imdb_delim <- read_delim("dados/imdb.csv", delim = ",")
imdb_delim2 <- read_delim("dados/imdb2.csv", delim = ";")

# direto da internet
imdb_csv_url <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")


# Interface point and click do RStudio também é útil!

# Lendo arquivos do Excel -------------------------------------------------

library(readxl)

imdb_excel <- read_excel("dados/imdb.xlsx")

excel_sheets("dados/imdb.xlsx")

imdb_excel <- read_excel("dados/imdb.xlsx", sheet = "Sheet1")

# Salvando dados ----------------------------------------------------------

# As funções iniciam com 'write'

imdb <- imdb_csv

# CSV
write_csv(imdb, file = "imdb.csv")

# Excel
library(writexl)
write_xlsx(imdb, path = "imdb.xlsx")

# O formato rds -----------------------------------------------------------

# .rds são arquivos binários do R
# Você pode salvar qualquer objeto do R em formato .rds

imdb_rds <- read_rds("dados/imdb.rds")
write_rds(imdb_rds, file = "dados/imdb_rds.rds")
