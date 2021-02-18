# [Desafio] 4.  SABESP ---------------------------------------------

# 4.1 Instale o pacote 'httr' com install.packages()

# 4.2 Carregue o pacote 'httr' com library()

# 4.3 A função abaixo, chamada baixar_sabesp(), pega informações 
# diretamente do site da SABESP.
# Crie essa função (apenas rode o código abaixo).
# Curiosidade: SABESP é a Cia. de Saneamento Básico do Estado de São Paulo. 
baixar_sabesp <- function(data) {
  u_sabesp <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", data)
  r_sabesp <- httr::GET(u_sabesp)
  results <- httr::content(r_sabesp, simplifyDataFrame = TRUE)
  results$ReturnObj$sistemas
}

# Dê uma olhada no que essa função está fazendo:
baixar_sabesp("2020-03-13")

# 4.4. Na linha abaixo, o objeto tab_sabesp recebe a tabela 
# do dia `Sys.Date() - 1` (ontem)
# Após rodar as linhas abaixo, confira o que tem dentro 
# dos objetos "ontem" e "tab_sabesp".
ontem <- Sys.Date() - 1
tab_sabesp <- baixar_sabesp(Sys.Date() - 1)


# 4.5. Arrumar os dados. Siga as etapas 
# (pense como os seis verbos podem te ajudar!)
# a) selecione apenas as colunas Nome e PrecMensal. Use select().
# b) A coluna PrecMensal é um texto e está com vírgulas separando o decimal.
#    Precisamos substituir a "," por "." e depois transformar de texto para numérica.
#    use as funções str_replace(PrecMensal, ",", ".") e as.numeric() para isso.
#    OBS: tem que fazer essas transformações da coluna PrecMensal dentro do mutate()!
# c) Ordene da maior precipitação para a menor usando arrange().

dados_arrumados <- tab_sabesp 
# O seu código %>%
# vai aqui %>%
# etc %>%
# etc %>%
# e tal


# 5. [extra] [não ensinado ainda] crie um gráfico de barras da 
# tabela dados_arrumados criada acima.
library(ggplot2)
dados_arrumados

