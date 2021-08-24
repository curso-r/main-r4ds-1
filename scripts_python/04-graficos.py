# Pacotes -----------------------------------------------------------------

import pandas as pd
import numpy as np
import seaborn as sbrn
import matplotlib.pyplot as plt

# Base de dados -----------------------------------------------------------

imdb = pd.read_csv("dados/imdb.csv")

imdb = imdb.assign(
  lucro = imdb.receita - imdb.orcamento,
  teve_lucro = lambda x: x.lucro.apply(lambda y: "Sim" if y > 0 else "Não") 
)

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', kind = 'scatter')

plt.show()

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', hue = 'teve_lucro', kind = 'scatter')

plt.show()

# parece que temos uma relação né?

sbrn.regplot(data = imdb, x='orcamento', y='receita')

plt.show()

# podemos salvar uma imagem
plt.savefig("imagem.png")

# Filosofia --------------------------------------------------------------

# seaborn é uma biblioteca construída sobre matplotlib, uma outra biblioteca
# em python utilziada para construção de gráficos. matplotlib é focada em
# construir figuras a partir de objetos matemáticos como matrizes, funções, vetores
# etc.
#
# a filosofia por traz de seaborn é oferecer uma forma de construir gráficos 
# seguindo o paradigma declarativo (você escreve o gráfico que quer ver em
# poucas palavras e o seaborn faz o resto) e focado em um DataFrame de origem.
#
# por isso, um uso típico de seaborn para construir um gráfico utilizará apenas
# uma função (relplot, por exempl) dentre várias disponíveis e,
# a depender do tipo de gráfico, você
# deverá respeitar uma sintaxe específica para plugar os dados na imagem.
#
# as funções que constroem gráficos são chamadas de funções "no nível da figura".

# Gráficos de relação ------------------------------------------------------

# os tradicionais gráficos de linhas (>lines<) ou de dispersão (>scatter<)

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', kind = 'line')
plt.show()

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', kind = 'scatter')
plt.show()

# o padrão, quando não usamos o parâmetro kind é "scatter"

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita')
plt.show()

# a função respeita cores, como vimos anteriormente

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', hue = 'teve_lucro',
kind = 'scatter')

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', hue = 'teve_lucro',
kind = 'line')

plt.show()

# os elementos gráficos mais importantes são definidos nos parametros

# hue, que representa a cor
# size, que representa o tamanho
# style que representa o tipo de preenchimento da linha/ponto

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', hue = 'teve_lucro',
kind = 'line', style = 'teve_lucro')

plt.show()

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', hue = 'teve_lucro',
kind = 'line', style = 'teve_lucro', size = 'teve_lucro')

plt.show()

sbrn.relplot(data = imdb, x = 'orcamento', y = 'receita', hue = 'teve_lucro',
kind = 'scatter', style = 'teve_lucro', size = 'teve_lucro')

plt.show()

contagem_de_cores_por_ano = imdb.groupby(['ano', 'cor']).agg(
  numero_filmes = ('titulo', 'count'))

sbrn.relplot(data = contagem_de_cores_por_ano,
x = "ano", y = 'numero_filmes', hue = 'cor', kind = "line")

plt.show()

# Gráficos de distribuição ------------------------------------------------------
 
# gráficos de distribuição ajudam a visualizar o padrão de variabilidade dos nossos
# dados. o displot aceita três tipos de gráficos: histogramas, densidades e 
# distribuições empíricas

sbrn.displot(data = imdb, x = "orcamento", kind = 'hist')

plt.show()

sbrn.displot(data = imdb, x = "orcamento", kind = 'ecdf')

plt.show()

sbrn.displot(data = imdb, x = "orcamento", kind = 'kde')

plt.show()

# Gráficos com variáveis categórias e numericas ---------------------------------------------

imdb_com_log = imdb.assign(receita = np.log(imdb.receita)) 

sbrn.catplot(data = imdb.assign(receita = np.log(imdb.receita)),
x = "teve_lucro", y = "receita", kind = "box")

plt.show()

sbrn.catplot(data = imdb.assign(receita = np.log(imdb.receita)),
x = "teve_lucro", y = "receita", kind = "point")

plt.show()

sbrn.catplot(data = imdb.query('ano == 2015 & receita > 50000000'),
x = "receita", y = "diretor", kind = "box")

plt.show()

sbrn.catplot(data = imdb.query('ano == 2015 & receita > 50000000'),
x = "receita", y = "diretor", kind = "bar")

plt.show()

