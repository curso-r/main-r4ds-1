# Rodando códigos (o Py como calculadora) ---------------------------------

# ATALHO para rodar o código: CTRL + ENTER

# adição

1+1

# subtração
4 - 2

# multiplicação
2 * 3

# divisão
5 / 3

# potência
4 ^ 2

# Objetos -----------------------------------------------------------------

# As bases de dados serão o nosso objeto de trabalho 

# para trabalhar com base de dados importamos o pacote panda para o Python
# para instalar podemos fazer reticulate::py_install("pandas") no R

# o padrao de importacao de pacotes é
import pandas

#agora podemos usar as funções do pacote pandas fazendo

pd.read_csv("dados/imdb.csv")
# por exemplo le uma base de dados

# podemos resumir essa palavra "pandas" também
import pandas as pd

# As bases de dados serão o nosso objeto de trabalho 

# para criar um objeto que se chama "dados_imdb" com o conteúdo
# lido do csv fazemos assim:
dados_imdb = pd.read_csv("dados/imdb.csv")

dados_imdb

# de maneira similar (usando = "=") podemos criar objetos numéricos:

# Salvando o valor 1 no objeto "obj"
obj = 1
obj

# Também dizemos 'guardando as saídas'
soma = 2 + 2
soma

# podemos criar varias variaveis de uma vez tambem:

variavel1, variavel2 = 1, 2

# Em geral, começaremos a nossa análise com:
nossa_base = funcao_que_carrega_uma_base("caminho/ate/arquivo")

# O erro "NameError: name 'funcao_que_carrega_uma_base' is not defined" significa que 
# você pediu para o R avaliar uma função que
# não existe. O mesmo vale para objetos:

nossa_base

# O mesmo vale para "NameError: name 'nossa_base' is not defined"

# Dicas:
# - sempre leia as mensagens de erro
# - verifique no Environment se um objeto existe

# salvar saída versus apenas executar
33 / 11
resultado = 33 / 11

# atualizar um objeto
resultado = resultado * 5

# Os nomes devem começar com uma letra.
# Podem conter letras, números, _ e .

# Permitido

x = 1
x1 = 2
objeto = 3
meu_objeto = 4
_objeto = 2

# Não permitido

1x = 1
meu-objeto = 3
meu.objeto = 3

# RASCUNHOS -----------------------------------------------------------------
# 
# Outros exemplos 

X = {"a": ["a", "d"], "b": "c"}

letters = ["a", "b", "c", "d"]
letras = letters

letras[3] = "e"

letras
letters

pi = 3.14
y = pi

y = 1

pi
y

vetor_numerico = (1, 2)
vetor_numerico2 = vetor_numerico

tupla = ([1,1], (1,2))
# RASCUNHOS -----------------------------------------------------------------

# Funções -----------------------------------------------------------------

# Funções são nomes que guardam um código de Python. Esse código é
# avaliado quando rodamos uma função e sempre precisa dos parênteses ()

print(resultado)
print(soma)

# o print aceita varios objetos tambem:

print("O resultado da soma deu", soma)


# checkpoint --------------------------------------------------------------

# 1. Escrevam (não copiem e colem) o código que lê a base e 
# a salva num objeto imdb. Rodem o código e observem 
# na aba environment se o objeto imdb apareceu.

# Classes -----------------------------------------------------------------

# a função type devolve no console o tipo de objeto que entrou dentro dos ()

type(soma)
type(resultado)

# os tipos dos objetos "soma" e "resultado" são diferentes

# normalmente vamos trabalhar com vários objetos de tipos diferentes, pois
# é comum que colunas diferentes tenham tipos diferentes

# o comando abaixo mostra os tipos de objeto
dados_imdb.dtypes

#temos float, inteiros e "object", que é como o panda armazena colunas do tipo
#texto ou "str", aqui no "python".

variavel_texto = "a"

type(variavel_texto)

# variaveis textuais aceitam o sinal de soma "+", mas na verdade o Python "cola"
# os textos

variavel_texto + "b"

# também temos valores lógicos:

valor_logico_verdadeiro = True
valor_logico_falso = False

valor_logico_verdadeiro + valor_logico_falso
valor_logico_verdadeiro & valor_logico_falso
valor_logico_verdadeiro | valor_logico_falso
valor_logico_verdadeiro * valor_logico_falso

type(valor_logico_verdadeiro)
type(valor_logico_falso)

# Listas -----------------------------------------------------------------

# Listas são conjuntos de valores

lista1 = [1, 4, 3, 10]
lista2 = ["a", "b", "z"]

lista1
lista2

type(lista1)

# A função len nos indica quantos valores compõem a lista

len(lista1)
len(lista2)

# Uma maneira fácil de criar uma lista com uma sequência de números
# é utilizar a função range e a função list

# Vetor de 1 a 10
list(range(1, 10))

# Vetor de 10 a 1
list(range(10, 1, -1))

# Vetor de -3 a 3
list(range(-3, 3))

# Uma lista pode guardar qualquer tipo de objeto e inclusive misturar objetos
# de tipos diferentes

vetor1 = ["a", 5, 3, -10]
vetor2 = ["a", "b", 3]

type(vetor1)
type(vetor2)

# Miisturando objetos com tipos diferentes:

numero_inteiro = 1
numero_com_virgula = 1.1

type(numero_inteiro)
type(numero_com_virgula)

numero_inteiro + numero_com_virgula

# Python compatibilia tipos alguns tipos de objetos, mas não todos:

# para manipular bol, integer e float o tipo do resultado vai ser sempte
# o tipo maior na sequência abaixo:
# float > integer > bool 

type(True + 1.1)
type(True + 1)
type(1 + 1.1)

# str é o único tipo que não se mistura com os outros:
"a"+1

# Naturalmente, podemos fazer operações matemáticas com listas que só tem números
# usando o pacote numpy

import numpy as np

lista_de_numeros = [0, 5, 20, -3]

np.add(lista_de_numeros, 1)
np.subtract(lista_de_numeros, 1)
np.divide(lista_de_numeros, 2)
np.multiply(lista_de_numeros, 10)

# Você também pode fazer operações que envolvem mais de um vetor se
# eles tiverem o mesmo comprimento

vetor1 = [1, 2, 3]
vetor2 = [10, 20, 30]

np.add(vetor1, vetor2)
