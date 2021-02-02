# salvar saída versus apenas executar
33 / 11
resultado <- 33 / 11

# As coisas ficam um pouco confusas quando os dois
# vetores não tem o mesmo tamanho

vetor1 <- c(1, 2)
vetor2 <- c(10, 20, 30, 40)

# Esse comportamento é chamado de reciclagem.

# As coisas ficam um pouco mais confusas quando os comprimentos
# dos vetores não são múltiplos

vetor1 <- c(1, 2, 3)
vetor2 <- c(10, 20, 30, 40, 50)

vetor1 + vetor2


# Exercícios --------------------------------------------------------------

# a. Guarde em um objeto uma sequência de números que comece
# em 0 e termine em 5.

# b. Use subsetting para fazer o R devolver o primeiro número dessa sequência.
# Em seguida, faça o R devolver o último número da sequência.

# c. Multiplique todos os valores do vetor por -1. Guarde o resultado em
# um novo objeto chamado 'versao_negativa'.

# 1. Escreva um código que devolva apenas os valores maiores
# ou iguais a 10 do vetor abaixo:

vetor <- c(4, 8, 15, 16, 23, 42)


# Data frames -------------------------------------------------------------

mtcars

# vamos aprender tudo com calma mais pra frente...
str(iris)

head(mtcars)

names(mtcars)

dim(mtcars)

# Exercícios --------------------------------------------------------------

# 1. Use a funcao 'sum' para somar os valores de 1 a 100

# 2. Agora tire a média (mean) dos quadrados (^2) da coluna mtcars$mpg.
