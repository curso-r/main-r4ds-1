
# -------------------------------------------------------------------------
# Objetivo: analisar a relação "peso vs altura" dos personagens
# Star Wars

library(tidyverse)

starwars %>% 
  ggplot(aes(x = mass, y = height)) +
  geom_point()

starwars %>% 
  filter(mass < 500) %>% 
  ggplot(aes(x = mass, y = height)) +
  geom_point()


# -------------------------------------------------------------------------
# Objetivo: criar o tema "Star Wars" para o gráfico anterior

starwars %>% 
  ggplot(aes(x = mass, y = height)) +
  geom_point(color = "yellow") +
  coord_cartesian(xlim = c(0, 200)) +
  labs(title = "Star Wars", subtitle = "May the force be with you") +
  theme(
    plot.background = element_rect(fill = "black"),
    panel.background = element_rect(fill = "black"),
    axis.text = element_text(color = "yellow"),
    axis.title = element_text(color = "yellow"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid = element_line(color = "grey"),
    plot.title = element_text(
      color = "yellow", 
      size = 30, 
      hjust = 0.5,
      family = "Star Jedi"
    ),
    plot.subtitle = element_text(
      color = "yellow", 
      size = 10, 
      hjust = 0.5,
      family = "Star Jedi"
    )
  )

# fonte Star Jedi: https://www.dafont.com/pt/star-jedi.font
  

# -------------------------------------------------------------------------
# Objetivo: avaliar se as tempestades tropicais estão
# ficando mais fortes (com relação à velocidade do vento) 

library(tidyverse)

help(storms)

storms %>% 
  group_by(year) %>% 
  summarise(vv_media = mean(wind, na.rm = TRUE)) %>% 
  ggplot(aes(x = year, y = vv_media)) +
  geom_line()

storms %>% 
  mutate(data = lubridate::make_date(year, month, day)) %>% 
  group_by(name) %>% 
  summarise(
    vv_media = mean(wind, na.rm = TRUE),
    data = first(data)
  ) %>% 
  ggplot(aes(x = data, y = vv_media)) +
  geom_point() +
  geom_smooth()
  

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

tab_volume %>% 
  mutate(Nome = forcats::fct_reorder(Nome, VolumePorcentagem)) %>% 
  ggplot(aes(y = Nome, x = VolumePorcentagem)) +
  geom_col(aes(fill = Nome), show.legend = FALSE)

# -------------------------------------------------------------------------
# Objetivo: fazer um gráfico de barras empilhadas 
# mostrando a proporção de filmes de drama dos 10 diretores
# que mais fizeram filmes na base

library(tidyverse)

imdb <- readr::read_rds("dados/imdb.rds")

top_10_diretores <- imdb %>% 
  filter(!is.na(diretor)) %>% 
  count(diretor) %>% 
  top_n(10, n) %>% 
  pull(diretor)
  

diretor_por_filme_de_drama <- imdb %>% 
  filter(diretor %in% top_10_diretores) %>% 
  mutate(filme_de_drama = str_detect(generos, "Drama")) %>%
  count(diretor, filme_de_drama)

# Valor absoluto  
diretor_por_filme_de_drama %>% 
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama)) +
  geom_label(aes(label = n), position = position_stack(vjust = 0.5)) 

# Valor absoluto (dodge)
diretor_por_filme_de_drama %>% 
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(
    aes(fill = filme_de_drama), 
    position = position_dodge(width = 1)
  ) +
  geom_text(
    aes(label = n), 
    position = position_dodge(width = 1), 
    hjust = -0.1
  ) 

# position fill (preenchido ate 100%)
diretor_por_filme_de_drama %>%
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_fill())

# Ordenar é um desafio =(
diretor_por_filme_de_drama %>%
  group_by(diretor) %>%
  mutate(proporcao_de_drama = sum(n[filme_de_drama])/sum(n)) %>%
  ungroup() %>%
  mutate(diretor = forcats::fct_reorder(diretor, proporcao_de_drama)) %>% 
  ggplot(aes(x = n, y = diretor, group = filme_de_drama)) +
  geom_col(aes(fill = filme_de_drama), position = position_fill())
