# Parte 1 - Instalação --------------

# -   Anote suas dificuldades e dúvidas para que possamos conversar
# na próxima aula!

# -   Caso não consiga fazer algum dos exercícios, não desista :)
# pule para o próximo.

## Parte 1 - Instalação do R e RStudio

# No dia-a-dia é interessante que vocês consigam usar o R e o RStudio no
# computador pessoal (ou de trabalho) de vocês. Caso você já tenha conseguido
# instalar o R e o RStudio, pode pular essa parte :)

# Portanto, a parte 1 da tarefa é realizar a instalação do R e do RStudio no
# computador pessoal, para que consigam usar depois do curso.

### Instalar o R:

# Primeiro é necessário instalar o R:

#  -   O link de instalação pode ser encontrado aqui: <https://cran.fiocruz.br/>
#  -   Este outro link pode ajudar também: <https://livro.curso-r.com/1-1-instalacao-do-r.html>

### Instalar o RStudio:

#  Depois de instalar o R, podemos instalar o RStudio:

# -   O link de instalação pode ser encontrado aqui: <https://www.rstudio.com/products/rstudio/download/#download>
# -   Este outro link pode ajudar também: <https://livro.curso-r.com/1-2-instalacao-do-rstudio.html>

# ATENÇÃO: Caso tenha problemas com a instalação, peça ajuda no horário pré-aula (18h30-19h00).

## Parte 2 - Teórica ---------

# As etapas a seguir são opcionais, mas caso você não esteja confortável com alguns conceitos, será importante para entender os exercícios que utilizaremos códigos. Conceitos mais importantes: média, mediana, desvio padrão.

# - Leitura: Análise com estatística descritiva para leigos:
# https://escoladedados.org/tutoriais/analise-com-estatistica-descritiva-para-leigos/

# - Esse vídeo fala sobre o cálculo de variância e desvio padrão:
# https://youtu.be/A-N-eEB1owQ - até 21:23

## Parte 3 - Exercícios com código -----


### Exercitando conceitos sobre vetores e funções

#### Pausa para uma lista de funções que pode ajudar nos exercícios

# Nos exercícios a seguir, precisamos usar algumas funcões para calcular alguns
# valores. Segue aqui uma lista que pode ser útil:
#
# nome_do_vetor <- c(valor, valor, valor) # - cria um objeto que armazena um
# conjunto de valores. chamamos isso de VETOR!
#
# class(nome_do_vetor) # - verificar a classe de um vetor
#
# length(nome_do_vetor) # - verificar quantos elementos tem em um vetor
#
# mean(nome_do_vetor) # - para vetores numéricos. essa função calcula a
# média dos valores em um vetor.
#
# median(nome_do_vetor) # - para vetores numéricos. essa função calcula a
# mediana dos valores em um vetor.
#
# var(nome_do_vetor) # - para vetores numéricos. essa função calcula a
# variância dos valores em um vetor.
#
# sd(nome_do_vetor) # - para vetores numéricos. essa função calcula o
# desvio padrão dos valores em um vetor.
#
# min(nome_do_vetor) # - para vetores numéricos. essa função retorna o
# menor valor encontrado em um vetor.
#
# max(nome_do_vetor) # - para vetores numéricos. essa função retorna o maior
# valor encontrado em um vetor.
#
# round(nome_do_vetor, numero_de_casas_decimais) # - para vetores numéricos.
# essa função retorna os valores do vetor arredondados.
# O segundo argumento define o número de casas decimais para ser usado no
# arredondamento.
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
