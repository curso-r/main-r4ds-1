# Pacotes -----------------------------------------------------------------

import pandas as pd
import numpy as np

# Base de dados -----------------------------------------------------------

imdb = pd.read_csv("dados/imdb.csv")

# Métodos e atributos -----------------------------------------------------

# Em python a maior parte dos objetos tem pequenas funções que podem ser
# executadas tomando eles como referencia 

# objeto.nome_do_metodo()

# objetos em python também tem atributos, que são características dos objetos
# que podem se modo similar aos atributos.

# objeto.nome_do_metodo 

# Jeito de ver a base -----------------------------------------------------

# método
imdb.head()

# nomes
imdb.columns

imdb.dtypes

# pandas: 6 métodos principais
# filter(axis = 1)    # seleciona colunas do data.frame
# filter(axis = 0)    # filtra linhas do data.frame
# sort_**()   # reordena as linhas do data.frame
# assign()    # cria novas colunas no data.frame (ou atualiza as colunas existentes)
# agg() + group_by() # sumariza o data.frame
# join   # junta dois data.frames

## CONTINUAR AQUI ####

# select ------------------------------------------------------------------

# Selcionando uma coluna da base

select(imdb, titulo)

# A operação NÃO MODIFICA O OBJETO imdb

imdb

# Selecionando várias colunas

select(imdb, titulo, ano, orcamento)

select(imdb, titulo:cor)

# Funções auxiliares

select(imdb, starts_with("ator"))
select(imdb, contains("to"))

# Principais funções auxiliares

# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains():  para colunas que contêm um texto padrão

# Selecionando colunas por exclusão

select(imdb, -starts_with("ator"), -titulo, -ends_with("s"))

# arrange -----------------------------------------------------------------

# Ordenando linhas de forma crescente de acordo com 
# os valores de uma coluna

arrange(imdb, orcamento)

# Agora de forma decrescente

arrange(imdb, desc(orcamento))

# Ordenando de acordo com os valores 
# de duas colunas

arrange(imdb, desc(ano), orcamento)

# O que acontece com o NA?

df <- tibble(x = c(NA, 2, 1), y = c(1, 2, 3))
arrange(df, x)
arrange(df, desc(x))

# Pipe (%>%) --------------------------------------------------------------

# Transforma funçõe aninhadas em funções
# sequenciais

# g(f(x)) = x %>% f() %>% g()

x %>% f() %>% g()   # CERTO
x %>% f(x) %>% g(x) # ERRADO

# Receita de bolo sem pipe. 
# Tente entender o que é preciso fazer.

esfrie(
  asse(
    coloque(
      bata(
        acrescente(
          recipiente(
            rep(
              "farinha", 
              2
            ), 
            "água", "fermento", "leite", "óleo"
          ), 
          "farinha", até = "macio"
        ), 
        duração = "3min"
      ), 
      lugar = "forma", tipo = "grande", untada = TRUE
    ), 
    duração = "50min"
  ), 
  "geladeira", "20min"
)

# Veja como o código acima pode ser reescrito 
# utilizando-se o pipe. 
# Agora realmente se parece com uma receita de bolo.

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")

# ATALHO DO %>%: CTRL (command) + SHIFT + M



# Conceitos importantes para filtros! --------------------------------------

## Comparações lógicas -------------------------------

# Testes com resultado verdadeiro
x == 1
"a" == "a"

# Testes com resultado falso
x == 2
"a" == "b"

# Maior
x > 3
x > 0

# Maior ou igual
x > 1
x >= 1

# Menor
x < 3
x < 0

# Menor ou igual
x < 1
x <= 1

# Diferente
x != 1
x != 2

x %in% c(1, 2, 3)
"a" %in% c("b", "c")

## Operadores lógicos -------------------------------

## & - E - Para ser verdadeiro, os dois lados 
# precisam resultar em TRUE

x <- 5
x >= 3 & x <=7


y <- 2
y >= 3 & y <= 7

## | - OU - Para ser verdadeiro, apenas um dos 
# lados precisa ser verdadeiro

y <- 2
y >= 3 | y <=7

y <- 1
y >= 3 | y == 0


## ! - Negação - É o "contrário"

!TRUE

!FALSE


w <- 5
(!w < 4)

# filter ------------------------------------------------------------------


# Filtrando uma coluna da base
imdb %>% filter(nota_imdb > 9)
imdb %>% filter(diretor == "Quentin Tarantino")

# Vendo categorias de uma variável
unique(imdb$cor) # saída é um vetor
imdb %>% distinct(cor) # saída é uma tibble

# Filtrando duas colunas da base

## Recentes e com nota alta
imdb %>% filter(ano > 2010, nota_imdb > 8.5)
imdb %>% filter(ano > 2010 & nota_imdb > 8.5)

## Gastaram menos de 100 mil, faturaram mais de 1 milhão
imdb %>% filter(orcamento < 100000, receita > 1000000)

## Lucraram
imdb %>% filter(receita - orcamento > 0)

## Lucraram mais de 500 milhões OU têm nota muito alta
imdb %>% filter(receita - orcamento > 500000000 | nota_imdb > 9)

# O operador %in%
imdb %>% filter(ator_1 %in% c('Angelina Jolie Pitt', "Brad Pitt"))

# Negação
imdb %>% filter(diretor %in% c("Quentin Tarantino", "Steven Spielberg"))
imdb %>% filter(!diretor %in% c("Quentin Tarantino", "Steven Spielberg"))


# O que acontece com o NA?
df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Filtrando texto sem correspondência exata
# A função str_detect()
textos <- c("a", "aa","abc", "bc", "A", NA)

str_detect(textos, pattern = "a")

## Pegando os seis primeiros valores da coluna "generos"
imdb$generos[1:6]

str_detect(
  string = imdb$generos[1:6],
  pattern = "Action"
)

## Pegando apenas os filmes que 
## tenham o gênero ação
imdb %>% filter(str_detect(generos, "Action"))

# mutate ------------------------------------------------------------------

# Modificando uma coluna

imdb %>% 
  mutate(duracao = duracao/60) %>% 
  View()

# Criando uma nova coluna

imdb %>% 
  mutate(duracao_horas = duracao/60) %>% 
  View()

imdb %>% 
  mutate(lucro = receita - orcamento) %>% 
  View()

# A função ifelse é uma ótima ferramenta
# para fazermos classificação binária

imdb %>% mutate(
  lucro = receita - orcamento,
  houve_lucro = ifelse(lucro > 0, "Sim", "Não")
) %>% 
  View()

# summarise ---------------------------------------------------------------

# Sumarizando uma coluna

imdb %>% summarise(media_orcamento = mean(orcamento, na.rm = TRUE))

# repare que a saída ainda é uma tibble


# Sumarizando várias colunas
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  media_lucro = mean(receita - orcamento, na.rm = TRUE)
)

# Diversas sumarizações da mesma coluna
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  mediana_orcamento = median(orcamento, na.rm = TRUE),
  variancia_orcamento = var(orcamento, na.rm = TRUE)
)

# Tabela descritiva
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  qtd = n(),
  qtd_diretores = n_distinct(diretor)
)


# funcoes que transformam -> N valores
log(1:10)
sqrt()
str_detect()

# funcoes que sumarizam -> 1 valor
mean(c(1, NA, 2))
mean(c(1, NA, 2), na.rm = TRUE)
n_distinct()


# group_by + summarise ----------------------------------------------------

# Agrupando a base por uma variável.

imdb %>% group_by(cor)

# Agrupando e sumarizando
imdb %>% 
  group_by(cor) %>% 
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    qtd = n(),
    qtd_diretores = n_distinct(diretor)
  )

# left join ---------------------------------------------------------------

# A função left join serve para juntarmos duas
# tabelas a partir de uma chave. 
# Vamos ver um exemplo bem simples.

band_members
band_instruments

band_members %>% left_join(band_instruments)
band_instruments %>% left_join(band_members)

# o argumento 'by'
band_members %>% left_join(band_instruments, by = "name")

# De volta ao imdb...

# Vamos calcular a média do lucro e o lucro máximo dos filmes
# por diretor.
tab_lucro_diretor <- imdb %>% 
  mutate(lucro = receita - orcamento) %>% 
  group_by(diretor) %>% 
  summarise(
    lucro_medio = mean(lucro, na.rm = TRUE),
    lucro_maximo = max(lucro, na.rm = TRUE),
  )

# E se quisermos colocar essa informação na base
# original? Para sabermos, por exemplo, o quanto
# o lucro de cada filme se afasta do lucro médio
# do diretor que o dirigiu.

# Usamos a funçõa left join para trazer a
# coluna lucro_medio para a base imdb, associando
# cada valor de lucro_medio ao respectivo diretor
left_join(imdb, tab_lucro_diretor, by = "diretor")

# Salvando em um objeto
imdb_com_lucro_medio <- imdb %>% 
  left_join(tab_lucro_diretor, by = "diretor")

# Calculando o lucro relativo. Vamos usar a
# função scales::percent() para formatar o
# nosso resultado.

scales::percent(0.05)
scales::percent(0.5)
scales::percent(1)

imdb_com_lucro_medio %>% 
  mutate(
    lucro = receita - orcamento,
    lucro_relativo = (lucro - lucro_medio)/lucro_medio,
    lucro_relativo = scales::percent(lucro_relativo)
  ) %>% 
  View()

# Fazendo de-para

depara_cores <- tibble(
  cor = c("Color", "Black and White"),
  cor_em_ptBR = c("colorido", "preto e branco")
)

left_join(imdb, depara_cores, by = c("cor")) 

imdb %>% 
  left_join(depara_cores, by = c("cor")) %>% 
  select(cor, cor_em_ptBR) %>% 
  View()

# OBS: existe uma família de joins

band_instruments %>% left_join(band_members)
band_instruments %>% right_join(band_members)
band_instruments %>% inner_join(band_members)
band_instruments %>% full_join(band_members)

