# ## Exercício aula 2 - Exercitando conceitos sobre vetores e funções
#
#### Pausa para uma lista de funções que pode ajudar nos exercícios
#
# Nos exercícios a seguir, precisamos usar algumas funcões para calcular alguns
# valores. Segue aqui uma lista que pode ser útil:
#
# nome_do_vetor <- c(valor, valor, valor) # - cria um objeto que armazena um
# conjunto de valores. chamamos isso de VETOR!
#
# class(nome_do_vetor) # - verificar a classe de um vetor
#
# lenght(nome_do_vetor) # - verificar quantos elementos tem em um vetor
#
# mean(nome_do_vetor) # - para vetores numéricos. essa função calcula a média dos valores em um vetor.
#
# median(nome_do_vetor) # - para vetores numéricos. essa função calcula a mediana dos valores em um vetor.
#
# var(nome_do_vetor) # - para vetores numéricos. essa função calcula a variância dos valores em um vetor.
#
# sd(nome_do_vetor) # - para vetores numéricos. essa função calcula o desvio padrão dos valores em um vetor.
#
# min(nome_do_vetor) # - para vetores numéricos. essa função retorna o menor valor encontrado em um vetor.
#
# max(nome_do_vetor) # - para vetores numéricos. essa função retorna o maior valor encontrado em um vetor.
#
# round(nome_do_vetor, numero_de_casas_decimais) # - para vetores numéricos.
# essa função retorna os valores do vetor arredondados.
# O segundo argumento define o número de casas decimais para ser usado no arredondamento.
#
# ### Respondendo perguntas com código
#
# Exercícios 1 E 2 --------
# 1) - O vetor abaixo apresenta a esperança de vida por UF no Brasil em 2010:
#
esp_vida_2010 <- c(
  71.63, 70.32, 73.8, 73.3, 71.97, 72.6, 77.35, 75.1, 74.6,
  70.4, 74.25, 74.96, 75.3, 72.36, 72, 74.8, 72.32, 71.62,
  75.1, 72.52, 75.38, 72.97, 73.51, 76.61, 75.69, 71.84, 72.56
)

# Execute o código e veja se o objeto foi criado no seu environment.


# 2 - Usando o vetor criado anteriormente, responda utilizando funções do R base.
#
# 2a - Qual é a classe desse vetor?



# 2b - Quantos estados estão presentes neste vetor?


# 2c - Calcule a média, mediana, variância e desvio padrão desse vetor.




# 2d - Encontre o valor mínimo e máximo deste vetor.



# 2e - Calcule a amplitude dos valores deste vetor (valor maximo - valor mínimo).



# 2f - Experimente a função quantile() com o vetor criado. Ex: quantile(nome_do_vetor) .
# Compare com os outros valores retornados. O que você interpreta do resultado?
# O que significa os valores em 0%, 25%, 50%, 75%, 100%?


# 2g - Arredonde os valores deste vetor para apenas 1 casa decimal.


# Exercício 3 --------
#
# No código a seguir, criamos um vetor de alturas, chamado `valores_alturas`,
# que contém 10000 valores aleatórios, com reposição, de valores entre 1.50 à 1.90.
# A ideia é simular a altura de 1000 pessoas para fazer o exercício :)
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
  mean = 1.7, # média
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

# install.packages("abjData")

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

# duvida do Daniel
slice_max(dados_pnud_2010, order_by = espvida, n = 1)



# Daqui em diante, use a base dados_pnud_2010 para responder os exercícios.
# Lembre-se que você pode acessar os valores das colunas usando o $!
# Ex:
dados_pnud_2010$espvida


# 4C)  Qual era a soma da população do Brasil em 2010?



# 4D)  Qual era a média da esperança de vida da população do Brasil em 2010?


# Arredonde o valor encontrado nesse exercício, para apresentar 1 casa decimal:


# Osb: para calcular a média ponderada pela população, podemos usar a função
# weighted.mean:
weighted.mean(dados_pnud_2010$espvida, dados_pnud_2010$pop)

# 4E)  Qual era a mediana da esperança de vida da população do Brasil em 2010?



# 4F)  Qual era a variância da esperança de vida da população do Brasil em 2010?



# 4G)  Qual era o desvio padrão da esperança de vida da população do Brasil em 2010?

# 4H) Qual foi o maior valor encontado em um estado para a esperança de vida da
# população do Brasil em 2010?


# 4I) Qual foi o menor valor encontado em um estado para a esperança de vida da
# população do Brasil em 2010?
