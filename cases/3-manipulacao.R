# Objetivo: analisar dados da SABESP

library(tidyverse)

# Apenas mostrar, não explicar
# Indicar curso de web scraping
baixar_sabesp <- function(data) {
  u_sabesp <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", data)
  r_sabesp <- httr::GET(u_sabesp)
  results <- httr::content(r_sabesp, simplifyDataFrame = TRUE)
  results$ReturnObj$sistemas
}

baixar_sabesp("2021-01-01")

ontem <- Sys.Date() - 1
tab_sabesp <- baixar_sabesp(ontem)

tab_volume <- tab_sabesp %>% 
  select(Nome, VolumePorcentagem) %>% 
  arrange(desc(VolumePorcentagem))

tab_volume %>% 
  mutate(VolumePorcentagem = scales::percent(VolumePorcentagem, scale = 1))

