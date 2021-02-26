# -------------------------------------------------------------------------

# Objetivo: analisar dados da SABESP

library(tidyverse)

# Apenas copiar e colar, não explicar
# Indicar curso de web scraping
# install.packages("httr")
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
  mutate(
    VolumePorcentagem = scales::percent(VolumePorcentagem, scale = 1)
  )


# Gráfico de barras: positions e labels ---------------------------------

diretor_por_filme_de_drama <- imdb %>% 
  mutate(filme_de_drama = str_detect(generos, "Drama")) %>%
  count(diretor, filme_de_drama) %>%
  filter(
    !is.na(diretor), 
    !is.na(filme_de_drama),
    diretor %in% top_10_diretores$diretor
  ) %>%
  mutate(
    diretor = forcats::fct_reorder(diretor, n)
  ) 

# Colocando cor nas barras com outra variável
# coisas novas: fill = filme_de_drama e position = position_stack(vjust = 0.5)
diretor_por_filme_de_drama %>% 
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama)) +
  geom_label(aes(label = n), position = position_stack(vjust = 0.5)) 

# position dodge (lado a lado)
diretor_por_filme_de_drama %>% 
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_dodge(width = 1, preserve = "single")) +
  geom_text(aes(label = n), position = position_dodge(width = 1), hjust = -0.1) 

# position fill (preenchido ate 100%)
diretor_por_filme_de_drama %>%
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_fill()) +
  geom_text(aes(label = n), position = position_fill(vjust = 0.5)) 

# Ordenar é um desafio =(
diretor_por_filme_de_drama %>%
  group_by(diretor) %>%
  mutate(proporcao_de_drama = sum(n[filme_de_drama])/sum(n)) %>%
  ungroup() %>%
  mutate(diretor = forcats::fct_reorder(diretor, proporcao_de_drama)) %>% 
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_fill()) +
  geom_text(aes(label = n), position = position_fill(vjust = 0.5)) 
