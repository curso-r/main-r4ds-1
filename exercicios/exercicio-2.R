# Exercício 3 --------
#
# No código a seguir, criamos um vetor de alturas, chamado `valores_alturas`,
# que contém 10000 valores aleatórios, com reposição, de valores entre 1.50 à 1.90.
# A ideia é simular a altura de 1000 pessoas :)
# (sim, sabemos que tem pessoas que estão fora dessa faixa de altura,
# mas escolhi esse intervalo por ser mais comum).


alturas_possiveis <- 150:190 / 100
alturas_possiveis

valores_alturas <- sample(alturas_possiveis, # valores possiveis para sorteio
  size = 1000, # quantos valores quero "sortear"
  replace = TRUE
) # esses valores podem ser repetidos


# Nesse exemplo, a distribuição dos valores gerados no sample não
# faz muito sentido no mundo real, né?
hist(valores_alturas)


# Obs: se quisermos ser mais próximos à realidade, o ideal seria simular o
# valor de alturas utilizando a distribuicao normal.
# Como esse é um conceito que sai um pouco do contexto do curso, deixo
# um exemplo para quem tem curiosidade
valor_alturas_normal <- rnorm(1000, # vamos gerar 1000 valores
  mean = 1.65, # média
  sd = 0.1
) # desvio padrão


# com a função da normal, a distribuição fica bem mais perto da realidade!
hist(valor_alturas_normal)

# Daqui para frente, vamos utilizar o valor_alturas_normal para responder os
# exercícios.

# 3A.  Usando as funções aprendidas, verifique a classe do vetor:


# 3B.  Calcule a média da altura das pessoas do grupo.


# 3C. Quais são as alturas máximas e mínimas do grupo? Descubra usando funções.


# 3D.  Qual é a mediana desse conjunto de valores?



# 3E. Calcule a variância e o desvio padrão deste conjunto de valores.




# Exercício 4 ----------------------------
# Usaremos dados do pacote abjData!

# 4A. Instale o pacote abjData

# install.packages("abjData") # só precisa instalar uma vez!

# 4B. Carregue o pacote abjData e o tidyverse.

library(abjData)
library(tidyverse)

# 4c. Vamos criar um objeto chamado dados_pnud contendo a
# base pnud_min do pacote abjData; e outro objeto chamado dicionario_pnud
# contendo a base pnud_siglas. Verifique se os objetos apareceram no Environment,
# dê uma olhada na documentação dessas bases também, e explore as bases com funções
# como View() e glimpse() (lembre-se de que o glimpse() depende do tidyverse!)

# Ver a documentação
?pnud_min
?pnud_siglas

# Criar objetos
dados_pnud <- pnud_min
dicionario_pnud <- pnud_siglas

# Tente entender do que se trata a base pnud_min!
# ...


#  Vamos usar os dados para o ano de 2010. Para isso é necessário filtrar os dados,
# e vamos ver como fazer isso na aula 4!

dados_pnud_2010 <- filter(dados_pnud, ano == 2010)


dados_pnud_2010


# Daqui em diante, use a base dados_pnud_2010 para responder os exercícios.
# Lembre-se que você pode acessar os valores das colunas usando o $!
# Ex:
dados_pnud_2010$espvida


# 4C)  Qual era a soma da população do Brasil em 2010?



# 4D)  Qual era a média da esperança de vida da população do Brasil em 2010?


# Arredonde o valor encontrado nesse exercício, para apresentar 1 casa decimal:



# 4E)  Qual era a mediana da esperança de vida da população do Brasil em 2010?



# 4F)  Qual era a variância da esperança de vida da população do Brasil em 2010?



# 4G)  Qual era o desvio padrão da esperança de vida da população do Brasil em 2010?


# 4H) Qual foi o maior valor encontado em um estado para a esperança de vida da
# população do Brasil em 2010?


# 4I) Qual foi o menor valor encontado em um estado para a esperança de vida da
# população do Brasil em 2010?





# Curiosidade: para calcular a média ponderada pela população, podemos usar a função
# weighted.mean:
weighted.mean(dados_pnud_2010$espvida, dados_pnud_2010$pop)
