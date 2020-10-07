# Exercícios de gráficos com ggplot2 --------------------------------------

library(tidyverse)

# Para fazer os exercícios abaixo, utilize a base IMDB.

imdb <- read_rds("dados/imdb.rds")

# Utilize títulos, labels e cores para que os gráficos
# fiquem bem formatados, como se eles fossem ser entregues
# em um relatório de trabalho ou publicados para o 
# público.

# 1. Faça um gráfico de dispersão (gráfico de pontos) da nota imdb
# contra o orçamento do filme.
# dicas: ggplot() aes() geom_point()

# Desafio: trace uma reta vertical indicando o orçamento médio.
# dicas: geom_abline()

# -------------------------------------------------------------------------

# 2. Rode o código abaixo. 

diretores <- c(
  "Steven Spielberg", 
  "Quentin Tarantino", 
  "Christopher Nolan",
  "Martin Scorsese"
)

imdb %>% 
  filter(diretor %in% diretores) %>% 
  group_by(ano, diretor) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_point() +
  geom_line() +
  facet_wrap(vars(diretor))

# a) Analisando o gráfico gerado, 
# descreva o que a função facet_wrap() faz.

# Dica: olhe a documentação da função facet_wrap().
help(facet_wrap)


# b) Utilize os argumentos nrow e ncol da função
# facet_wrap() para colocar os quatro gráficos
# em uma única coluna.

# -------------------------------------------------------------------------

# 3. Vamos fazer um gráfico de barras do número de
# filmes com nota maior que 8 ao longo dos anos.

# a. Crie uma nova coluna na base IMDB indicando
# se a nota de um filme é maior que 8 ou não.

# Dica: use a função ifelse.

# b. Utilizando a coluna criada em (a), 
# crie uma tabela com o número anual de filmes
# com nota maior 8.

# c. Utilize a tabela criada em (b) para 
# fazer um gráfico de barras do número de
# filmes com nota maior que 8 ao longo dos anos.


# -------------------------------------------------------------------------

# 4. Juntando gráficos diferentes.

# a. Instale o pacote patchwork.
install.packages("patchwork")

# b. Faça um gráfico das nota médias dos
# filmes do Keanu Reeves ao longo dos anos.
# Salve o gráfico no objeto grafico_notas.

# Estrutura do código:

grafico_notas <- imdb %>% 
  # codígo para manipular da base
  ggplot()
  # código para gerar o gráfico

# c. Faça um histograma do lucro dos filmes
# filmes do Keanu Reeves.
# Salve o gráfico no objeto grafico_lucro.

# Estrutura do código:

grafico_lucro <- imdb %>% 
  # codígo para manipular da base
  ggplot()
# código para gerar o gráfico

# d. Rode o código abaixo e observe a figura gerada.
library(patchwork)

grafico_notas + grafico_lucro

# e. Por que não poderíamos usar a função
# facet_wrap() para gerar a mesma figura do item (d)?


# -------------------------------------------------------------------------

# 5. Likert

# 5.1 Rode o código abaixo.

# install.packages("likert")
data("gap", package = "likert")
gap_long <- gap %>%
  tidyr::pivot_longer(-StudentId, names_to = "questao", values_to = "resposta")

# PS: pivot_longer() é uma funcao que "derrete" o banco de dados, 
# empilhando as colunas. Vale a pena estudar o que essa funcao faz.
# Ela geralmente vai bem com ggplot2().

# Use a base gap_long para fazer os exercícios a seguir.

# 5.2 Crie uma tabela com a contagem de cada resposta para cada questao.


# 5.3 Usando a tabela acima, faca um grafico com uma barra horizontal para cada questao e 
# com as contagens no eixo X. Pinte o preenchimento das barras representando as respostas (fill).


# 5.4 [avancado] Mexendo com as categorias e as cores:

# a) transforme a coluna 'resposta' em factor() no mutate().  
# b) adicione  + scale_fill_brewer(palette = "RdBu") no grafico.
# c) observe se uma escala indo de azul ao vermelho apareceu.

