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
# query()    # filtra linhas do data.frame
# sort_value()   # reordena as linhas do data.frame
# assign()    # cria novas colunas no data.frame (ou atualiza as colunas existentes)
# agg() + group_by() # sumariza o data.frame
# join   # junta dois data.frames

## CONTINUAR AQUI ####

# select ------------------------------------------------------------------

# Selcionando uma coluna da base

imdb.filter(['titulo'], axis = 1)
imdb.filter(items = ['titulo'])

# não funciona:

imdb.filter('titulo', axis = 1)

# A operação NÃO MODIFICA O OBJETO imdb

imdb

# Selecionando várias colunas

imdb.filter(['titulo', 'ano', 'orcamento'], axis = 1)

# Funções auxiliares

imdb.filter(regex = "^ator", axis = 1)
imdb.filter(like = "to", axis = 1)

# arrange -----------------------------------------------------------------

# Ordenando linhas de forma crescente de acordo com 
# os valores de uma coluna

imdb.sort_values('orcamento')

# Agora de forma decrescente

imdb.sort_values('orcamento', ascending=False)

# Ordenando de acordo com os valores 
# de duas colunas

imdb.sort_values(['ano', 'orcamento'], ascending=[False, True]).filter(['ano', 'orcamento'], axis = 1)

# O que acontece com o NA?

df = pd.DataFrame({'x':[1,np.nan, 3], 'y':[1,2,3]}, columns=['x','y'])

df

df.sort_values('x')
df.sort_values('x', ascending=False)
df.sort_values('x', ascending=False, na_position='first')


# Conceitos importantes para filtros! --------------------------------------

## Comparações lógicas -------------------------------

x = 1

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

x in [1, 2, 3]
"a" in ["b", "c"]

1 in ["a", "b"]

# erros
x > "a"

"a"+x>1



## Operadores lógicos -------------------------------

## & - E - Para ser verdadeiro, os dois lados 
# precisam resultar em TRUE

x = 5
x >= 3 & x <=7


y = 2
y >= 3 & y <= 7

## | - OU - Para ser verdadeiro, apenas um dos 
# lados precisa ser verdadeiro

y = 2
y >= 3 | y <=7

y = 1
y >= 3 | y == 0


## ! - Negação - É o "contrário"

not True

not False


w = 5
(not w < 4)

# filter ------------------------------------------------------------------


# Filtrando uma coluna da base
imdb.query('nota_imdb > 9')
imdb.query('diretor == "Quentin Tarantino"')

# Vendo categorias de uma variável

imdb['cor'].unique()

imdb['cor'].unique() # saída é um vetor
imdb.drop_duplicates('cor') # saída é um pandas DataFrame

# Filtrando duas colunas da base

## Recentes e com nota alta
imdb.query('ano > 2010 & nota_imdb > 8.5')

## Gastaram menos de 100 mil, faturaram mais de 1 milhão
imdb.query('orcamento < 100000 & receita > 1000000')

## Lucraram
imdb.query('receita - orcamento > 0')

## Lucraram mais de 500 milhões OU têm nota muito alta
imdb.query('receita - orcamento > 500000000 | nota_imdb > 9')

# O operador %in%
imdb.query('ator_1 in ["Angelina Jolie Pitt", "Brad Pitt"]')

# Negação
imdb.query('diretor in ["Quentin Tarantino", "Steven Spielberg"]')
imdb.query('~(diretor in ["Quentin Tarantino", "Steven Spielberg"])')


# O que acontece com valores faltantes?
df = pd.DataFrame({'x': ['a', 'b', None], 'y': [4, 5, None]})
df
# Todo valor fantante é declarado como None, mas dentro do y vira NaN

df.query("x == 'a'")

# o None sumiu

df.query("y > 4")

# o None (que virou NaN) sumiu aqui também

df.query("@pd.isna(x) | x == 'a'")

# Filtrando texto sem correspondência exata
# O método "contains"

imdb.query("titulo.str.contains('Pirate')")

## Pegando os seis primeiros valores da coluna "generos"
imdb['generos'].unique()[1:6]

imdb.query("generos.str.contains('Action')")

# mutate ------------------------------------------------------------------

# Modificando uma coluna

imdb.assign(receita=lambda x: x.receita+1)
imdb.assign(receita=imdb.receita+1)

# Criando uma nova coluna

imdb.assign(
  duracao_horas = imdb.duracao/60
)

imdb.assign(
  lucro = imdb.receita - imdb.orcamento)

# tem alguns NaN aqui

# A função ifelse é uma ótima ferramenta
# para fazermos classificação binária

imdb.assign(
  lucro = imdb.receita - imdb.orcamento,
  duracao_horas = imdb.duracao/60
).assign(
  teve_lucro = lambda x: x.lucro.apply(lambda y: "Sim" if y > 0 else "Não") 
)

# summarise ---------------------------------------------------------------

# Sumarizando uma coluna

sumarios = imdb.agg({'orcamento': ['min', 'mean', 'max']})
# repare que a saída ainda também é um pandas DataFrame

imdb.agg({'orcamento': ['mean'],
          'receita': ['mean']})

# Diversas sumarizações da mesma coluna
imdb.agg({
  'orcamento': ['mean', 'var', 'median']
})

imdb.agg({
  'orcamento': ['mean', 'count'],
  'receita': ['mean', 'count'],
  'diretor': 'count'
})

imdb.count()


# funcoes que sumarizam suportadas:
'mean', 'count', 'var', 'median'



# group_by + summarise ----------------------------------------------------

# Agrupando a base por uma variável.

imdb.group_by('cor')

# pra usar essa notação em que vc pode renomear a saída vc precisa usar o 
# .agg
imdb.groupby('cor').agg(max_duration=('orcamento', 'mean'))

# Sumarizando várias colunas
imdb.groupby('cor').agg(
  media_orcamento = ('orcamento', 'mean'),
  media_receita = ('receita', 'mean')#,
  #media_lucro = ('receita - orcamento', 'mean')
)

imdb.groupby("cor").agg(
  media_orcamento = ('orcamento', 'mean'),
  media_receita = ('receita', 'mean'),
  qtd = ('titulo', 'count'),
  qtd_diretores = ('diretor', 'count')
)

# left join ---------------------------------------------------------------

# A função left join serve para juntarmos duas
# tabelas a partir de uma chave. 
# Vamos ver um exemplo bem simples.

df_um = pd.DataFrame(
  {"A": ["A0", "A1", "A2"],
  "B": ["K0", "B1", "B2"]},
  index=["K0", "K1", "K2"])
  
df_dois = pd.DataFrame(
   {"C": ["C0", "C2", "C3"],
   "D": ["K0", "D2", "D3"]},
   index=["K0", "K2", "K3"])

df_um.join(df_dois)
df_dois.join(df_um)

# sem nenhum parâmetro adicional, o join é feito considerando a propriedade
# "index"

# o argumento 'on' permite fazer um join de uma coluna à esquerda com o 
# index à direita

df_um.join(df_dois, on=['B'])

# se não houver index, a coluna do 'on' será usada como se fosse um index

# De volta ao imdb...

# Vamos calcular a média do lucro e o lucro máximo dos filmes
# por diretor.
lucro_por_diretor = imdb.assign(lucro=lambda x: x.receita-x.orcamento).groupby('diretor').agg(
  media_lucro = ('lucro', 'mean'),
  maximo_lucro = ('lucro', 'max'),
  qtd_filmes = ('titulo', 'count')
)

# E se quisermos colocar essa informação na base
# original? Para sabermos, por exemplo, o quanto
# o lucro de cada filme se afasta do lucro médio
# do diretor que o dirigiu.

# Usamos a funçõa left join para trazer a
# coluna lucro_medio para a base imdb, associando
# cada valor de lucro_medio ao respectivo diretor
imdb.join(lucro_por_diretor, on = "diretor")

# Salvando em um objeto
imdb_com_lucro_medio = imdb.join(lucro_por_diretor, on = "diretor")

