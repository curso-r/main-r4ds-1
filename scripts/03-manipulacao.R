# Pacotes -----------------------------------------------------------------

library(tidyverse)

# Base de dados -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")

# Jeito de ver a base -----------------------------------------------------

glimpse(imdb)
names(imdb)
View(imdb) # Cuidado com bases muito grandes!
head(imdb)

# dplyr: 6 verbos principais
# select()    # seleciona colunas do data.frame
# arrange()   # reordena as linhas do data.frame
# filter()    # filtra linhas do data.frame
# mutate()    # cria novas colunas no data.frame (ou atualiza as colunas existentes)
# summarise() + group_by() # sumariza o data.frame
# left_join   # junta dois data.frames

# select ------------------------------------------------------------------

# Selcionando uma coluna da base

select(imdb, titulo)

# A operação NÃO MODIFICA O OBJETO imdb

imdb

# Selecionando várias colunas

select(imdb, titulo, ano, orcamento)

select(imdb, titulo:generos)

# Funções auxiliares

select(imdb, starts_with("num"))

select(imdb, ends_with("cao"))

select(imdb, contains("cri"))



# Principais funções auxiliares

# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains():  para colunas que contêm um texto padrão

# Selecionando colunas por exclusão

select(imdb, -titulo)

select(imdb, -starts_with("num"), -titulo, -ends_with("ao"))

# arrange -----------------------------------------------------------------

# Ordenando linhas de forma crescente de acordo com 
# os valores de uma coluna

arrange(imdb, orcamento)

# Agora de forma decrescente

arrange(imdb, desc(orcamento))

# Ordenando de acordo com os valores 
# de duas colunas

arrange(imdb, desc(ano), orcamento)

# O que acontece com o NA? Sempre fica no final!

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


# pipe nativo - Atalho: CTRL SHIFT M 
imdb |> 
  select(titulo, ano, nota_imdb, num_avaliacoes) |> 
  arrange(desc(nota_imdb))

# pipe do tidyverse - Atalho: CTRL SHIFT M 
imdb %>% 
  select(titulo, ano, nota_imdb, num_avaliacoes) %>% 
  arrange(desc(nota_imdb))



# filter ------------------------------------------------------------------

# filter() - filtrar linhas da base --------

# R é case sensitive: 'NOME' é diferente de 'nome'


# olhar as categorias de uma variável:


# Retorna uma tabela
imdb %>% 
  distinct(direcao) 

# Retorna um vetor
unique(imdb$direcao)



# Aqui falaremos de Conceitos importantes para filtros, 
# seguindo de exemplos!

## Comparações lógicas -------------------------------


# comparacao logica
# == significa: uma coisa é igual a outra?
x <- 1

# Teste com resultado verdadeiro
x == 1

# Teste com resultado falso
x == 2

# Exemplo com filtros!
# Filtrando uma coluna da base: O que for TRUE (verdadeiro)
# será mantido!

imdb %>% 
  filter(direcao == "Quentin Tarantino") %>%
  View()

imdb %>% 
  filter(direcao == "Quentin Tarantino", 
         producao == "Miramax") %>%
  View()




## Comparações lógicas -------------------------------

# maior 
x > 3
x > 0
# menor
x < 3
x < 0


x > 1
x >= 1 # # Maior ou igual
x < 1
x <= 1 # menor ou igual

# Exemplo com filtros!

## Recentes e com nota alta
imdb %>% filter(nota_imdb > 9, num_avaliacoes > 10000)
imdb %>% filter(ano > 2010, nota_imdb > 8.5)
imdb %>% filter(ano > 2010 & nota_imdb > 8.5)

## Gastaram menos de 100 mil, faturaram mais de 1 milhão
imdb %>% filter(orcamento < 100000, receita > 1000000)

## Lucraram
imdb %>% filter(receita - orcamento > 0)


## Comparações lógicas -------------------------------

x != 2
x != 1

# Exemplo com filtros!
imdb %>% 
  filter(direcao != "Quentin Tarantino") %>% 
  View()

## Comparações lógicas -------------------------------

# operador %in%
x %in% c(1, 2, 3)
x %in% c(2, 3, 4)

# Exemplo com filtros!


# O operador %in%



imdb %>% 
  filter(direcao %in% c('Matt Reeves', "Christopher Nolan"))


imdb %>%
  filter(
    direcao %in% c(
      "Quentin Tarantino",
      "Christopher Nolan",
      "Matt Reeves",
      "Steven Spielberg",
      "Francis Ford Coppola"
    )
  )



## Operadores lógicos -------------------------------
## operadores lógicos - &, | , !

## & - E - Para ser verdadeiro, os dois lados
# precisam resultar em TRUE
x <- 5

x >= 3
x <= 7

x >= 3 & x <= 7

x >= 3 & x <= 4

# no filter, a virgula funciona como o &!
imdb %>%  
  filter(ano > 2010, nota_imdb > 8.5) %>%
  View()


imdb %>% 
  filter(ano > 2010 & nota_imdb > 8.5)


## Operadores lógicos -------------------------------

## | - OU - Para ser verdadeiro, apenas um dos
# lados precisa ser verdadeiro

# operador |


y <- 2
y >= 3
y <= 7

y >= 3 | y <= 7

y >= 3 | y <= 0

# Exemplo com filter

## Lucraram mais de 500 milhões OU têm nota muito alta
imdb %>% 
  filter(receita - orcamento > 500000000 | nota_imdb > 9)

# O que esse quer dizer?
imdb %>%
  filter(ano > 2010 | nota_imdb > 8.5) %>%
  View()

## Operadores lógicos -------------------------------

## ! - Negação - É o "contrário"

# operador de negação !
# é o contrario

!TRUE

!FALSE

# Exemplo com filter

imdb %>% 
  filter(!direcao %in% c("Quentin Tarantino",
                         "Christopher Nolan",
                         "Matt Reeves",
                         "Steven Spielberg",
                         "Francis Ford Coppola"
  )) %>%
  View()



##  NA ---- 

# exemplo com NA
is.na(imdb$orcamento)

imdb %>% 
  filter(!is.na(orcamento))

# o filtro por padrão tira os NAs!
df <- tibble(x = c(1, 2, 3, NA))
df

filter(df, x > 1)

# manter os NAs!
filter(df, x > 1 | is.na(x))

# filtrar textos sem correspondência exata

textos <- c("a", "aa", "abc", "bc", "A", NA)
textos

library(stringr) # faz parte do tidyverse

str_detect(textos, pattern =  "a")


## Pegando os seis primeiros valores da coluna "generos"
imdb$generos[1:6]

str_detect(
  string = imdb$generos[1:6],
  pattern = "Drama"
)


## Pegando apenas os filmes que 
## tenham o gênero ação
imdb %>% filter(str_detect(generos, "Action")) 


# filtra generos que contenha filmes que tenha "Crime" no texto
imdb %>% 
  filter(str_detect(generos, "Crime")) %>% 
  View()

# filtra generos que seja IGUAL e APENAS "Crime"
imdb %>% filter(generos == "Crime")






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
# para fazermos classificação binária (2 CATEGORIAS)

imdb %>% mutate(
  lucro = receita - orcamento,
  houve_lucro = ifelse(lucro > 0, "Sim", "Não")
) %>% 
  View()



# classificacao com mais de 2 categorias:
# usar a função case_when()

imdb %>%
  mutate(
    categoria_nota = case_when(
      nota_imdb >= 8 ~ "Alta",
      nota_imdb < 8 & nota_imdb >= 5 ~ "Média",
      nota_imdb < 5 ~ "Baixa",
      TRUE ~ "Não classificado"
    )
  ) %>% View()

# summarise ---------------------------------------------------------------

# Sumarizando uma coluna

imdb %>% 
  summarise(media_orcamento = mean(orcamento, na.rm = TRUE))

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
  variancia_orcamento = var(orcamento, na.rm = TRUE),
  variancia_orcamento = var(orcamento, na.rm = TRUE),
  desvio_padrao_orcamento = sd(orcamento, na.rm = TRUE)
)

# Tabela descritiva
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  qtd = n(),
  qtd_direcao = n_distinct(direcao)
)


# n_distinct() é similar à:
imdb %>% 
  distinct(direcao) %>% 
  nrow()


# funcoes que transformam -> N valores
log(1:10)
sqrt()
str_detect()

# funcoes que sumarizam -> 1 valor - FUNÇÕES BOAS PARA SUMMARISE
mean(c(1, NA, 2))
mean(c(1, NA, 2), na.rm = TRUE)
n_distinct()


# group_by + summarise ----------------------------------------------------

# Agrupando a base por uma variável.

imdb %>% group_by(producao)

# Agrupando e sumarizando
imdb %>% 
  group_by(producao) %>% 
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    qtd = n(),
    qtd_direcao = n_distinct(direcao)
  ) %>%
  arrange(desc(qtd)) 



  
  
# left join ---------------------------------------------------------------

# A função left join serve para juntarmos duas
# tabelas a partir de uma chave. 
# Vamos ver um exemplo bem simples.

band_members
band_instruments

band_members %>% 
  left_join(band_instruments)

band_instruments %>%
  left_join(band_members)

# o argumento 'by'
band_members %>%
  left_join(band_instruments, by = "name")

# OBS: existe uma família de joins

band_instruments %>%
  left_join(band_members)

band_instruments %>%
  inner_join(band_members)

band_instruments %>%
  full_join(band_members)

band_instruments %>%
  anti_join(band_members)

band_instruments %>%
  right_join(band_members)


# Um exemplo usando a outra base do imdb

imdb <- read_rds("dados/imdb.rds")
imdb_avaliacoes <- read_rds("dados/imdb_avaliacoes.rds")

imdb %>% 
  left_join(imdb_avaliacoes, by = "id_filme") %>%
  View()

