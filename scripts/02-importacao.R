library(tidyverse)

# Caminhos até o arquivo --------------------------------------------------

# Diretório de trabalho
getwd()

# Caminhos absolutos
"/home/william/Documents/Curso-R/main-r4ds-1/dados/imdb.csv"

# Caminhos relativos
"dados/imdb.csv"

# (cara(o) professora(o), favor lembrar de falar da dica 
# de navegação entre as aspas)

# Tibbles -----------------------------------------------------------------

airquality
class(as_tibble(airquality))

# Lendo arquivos de texto -------------------------------------------------

# CSV, separado por vírgula
imdb_csv <- read_csv(file = "dados/imdb.csv")

# CSV, separado por ponto-e-vírgula
imdb_csv2 <- read_csv2(file = "dados/imdb2.csv")

# TXT, separado por tabulação (tecla TAB)
imdb_txt <- read_delim(file = "dados/imdb.txt", delim = "\t")

# A função read_delim funciona para qualquer tipo de separador
imdb_delim <- read_delim("dados/imdb.csv", delim = ",")
imdb_delim <- read_delim("dados/imdb2.csv", delim = ";")

# direto da internet
imdb_csv <- read_csv("https://raw.githubusercontent.com/curso-r/202005-r4ds-1/master/dados/imdb.csv")

# Interface point and click do RStudio também é útil!

# Lendo arquivos do Excel -------------------------------------------------

library(readxl)

imdb_excel <- read_excel("dados/imdb.xlsx")
excel_sheets("dados/imdb.xlsx")

# Gravando dados ----------------------------------------------------------

# As funções iniciam com 'write'

# CSV
write_csv(imdb, file = "imdb.csv")

# Excel
library(writexl)
write_xlsx(imdb, path = "imdb.xlsx")

# O formato rds -----------------------------------------------------------

# .rds são arquivos binários do R
# Você pode salvar qualquer objeto do R em formato .rds

imdb_rds <- readr::read_rds("dados/imdb.rds")
readr::write_rds(imdb_rds, file = "dados/imdb_rds.rds")
