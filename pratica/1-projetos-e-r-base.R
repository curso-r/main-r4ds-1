# Objetivo: investigar descritivamente a base imdb

# 1. Iniciar um novo projeto

imdb <- read.csv("dados/imdb.csv")
imdb

# Estrutura da base (colunas)
str(imdb)

# Variável resposta: receita

min(imdb$receita)
min(imdb$receita, na.rm = TRUE)
max(imdb$receita, na.rm = TRUE)
mean(imdb$receita, na.rm = TRUE)


# Resumo de todas as variáveis
summary(imdb)

# Podemos contar quantos filmes estão acima
# da receita média e quantos estão abaixo

imdb[1, 1]
imdb[1,"titulo"]
imdb[1:10,"titulo"]

imdb$receita[1]
imdb$receita[1:10]

media_receita <- mean(imdb$receita, na.rm = TRUE)
receitas <- imdb$receita

receitas > media_receita

imdb$titulo[receitas > media_receita]

# Estudando a variável cor

class(imdb$cor)
table(imdb$cor)

# Podemos ver a receita média para filmes coloridos 
# versus a média para filmes preto e branco

filmes_coloridos <- imdb[imdb$cor == "Color",]
filmes_pb <- imdb[imdb$cor == "Black and White",]

mean(filmes_coloridos$receita, na.rm = TRUE)
mean(filmes_pb$receita, na.rm = TRUE)

# Gráfico de dispersão entre as duas variáveis

plot(imdb$orcamento, imdb$receita)
