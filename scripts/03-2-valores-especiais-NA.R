# Valores especiais -------------------------------------------------------

# Existem valores reservados para representar dados faltantes,
# infinitos, e indefinições matemáticas.

NA   # (Not Available) significa dado faltante/indisponível.
 

NaN  # (Not a Number) representa indefinições matemáticas, como 0/0 e log(-1).
# Um NaN é um NA, mas a recíproca não é verdadeira.

Inf  # (Infinito) é um número muito grande ou o limite matemático, por exemplo,
# 1/0 e 10^310. Aceita sinal negativo -Inf.

NULL # representa a ausência de objeto (no R).

# Comparações lógicas

idade_ana <- 30
idade_beto <- NA
idade_carla <- NA

idade_ana == idade_beto

idade_beto == idade_carla

5 == NA

NA + 5


# Use as funções is.na(), is.nan(), is.infinite() e is.null()
# para testar se um objeto é um desses valores.

x <- NA
is.na(x)

0 / 0 == NaN
is.nan(0 / 0)


idades <- c(15, 64, 31, NA, 59)
is.na(idades)

is.nan(NaN)
is.infinite(10 ^ 309)
is.null(NULL)

# NAs em bases de dados
# Pacotes -----------------------------------------------------------------
library(tidyverse)

# Base de dados -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")

# em vetores!
imdb$orcamento
is.na(imdb$orcamento)
sum(imdb$orcamento)
mean(imdb$orcamento) # se tem NA no vetor, o resultado será NA

# soma
sum(imdb$orcamento, na.rm = TRUE)

# valor menor
min(imdb$orcamento, na.rm = TRUE)

# valor maior
max(imdb$orcamento, na.rm = TRUE)

# calcular a média
mean(imdb$orcamento, na.rm = TRUE) # o argumento na.rm = TRUE remove os NAs

# desvio padrao
sd(imdb$orcamento, na.rm = TRUE)


# em data frames --------
# remove todas as linhas que contenha qualquer NA
imdb %>% 
  drop_na()   # tidyr

# remove todas as linhas que contenha NA nas colunas que oferecemos para o 
# drop_na()
imdb %>% 
  drop_na(orcamento, receita)


imdb %>% 
  drop_na(ano)

# funciona como o drop_na() que remove todas linhas que tem algum NA
na.omit(imdb)


# mostrar depois! NA no filter e no summarize.
