# -------------------------------------------------------------------------
# Objetivo: analisar a relação "peso vs altura" dos personagens
# Star Wars
# contar a historia do will pra contextualizar de onde surgiu essa curiosidade!

library(tidyverse)

starwars %>% 
  ggplot(aes(x = mass, y = height)) +
  geom_point()

starwars %>% 
  filter(mass < 500) %>% 
  ggplot(aes(x = mass, y = height)) +
  geom_point()


# -------------------------------------------------------------------------
# Objetivo: avaliar se as tempestades tropicais estão
# ficando mais fortes (com relação à velocidade do vento) 

library(tidyverse)

help(storms)

View(storms)

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
  

## outro exemplo com manancias - grafico de linhas

library(readr)
mananciais <- read_delim("https://github.com/beatrizmilz/mananciais/raw/master/inst/extdata/mananciais.csv", 
                         ";", escape_double = FALSE, col_types = cols(data = col_date(format = "%Y-%m-%d")), 
                         locale = locale(decimal_mark = ",", grouping_mark = "."), 
                         trim_ws = TRUE)
View(mananciais)

# nivel dos reservatorios 
mananciais %>%
  dplyr::mutate(ano = lubridate::year(data)) %>%
  dplyr::filter(ano == 2021) %>%
  ggplot() +
  geom_line(aes(x = data, y = volume_porcentagem, color = sistema)) +
  scale_y_continuous(breaks = c(-25, 0, 25, 50, 75, 100)) +
  theme_bw() +
  labs(x = "Anos", y = "Volume operacional (%)")

# FINAL DA PARTE DA AULA 1

# -------------------------------------------------------------------------
# Objetivo: analisar dados da SABESP (usando web scraping)

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

# versão com a base do mananciais

library(tidyverse)
mananciais <- read_delim("https://github.com/beatrizmilz/mananciais/raw/master/inst/extdata/mananciais.csv", 
                         ";", escape_double = FALSE, col_types = cols(data = col_date(format = "%Y-%m-%d")), 
                         locale = locale(decimal_mark = ",", grouping_mark = "."), 
                         trim_ws = TRUE)
View(mananciais)

data_de_hoje <- format(Sys.Date(), "%d/%m/%Y")

mananciais %>% 
  dplyr::filter(data == Sys.Date()) %>% 
  dplyr::select(sistema, volume_porcentagem) %>% 
  mutate(sistema = forcats::fct_reorder(sistema, volume_porcentagem)) %>% 
  ggplot() +
  geom_col(aes(y = sistema, x = volume_porcentagem, fill = sistema), show.legend = FALSE) + 
  theme_bw() +
  labs(x = "Volume operacional (%)", y = "Sistema",
       title = paste0("Volume operacional dos Sistemas que abastecem a RMSP \n em ", data_de_hoje),
       caption = "Fonte: Dados de SABESP") + 
  #scale_fill_viridis_d() + # color blind friendly
  scale_fill_brewer(palette = "Set2") +
  ggsave(filename = "mananciais.png", width = 10, height = 10, units = "cm")



# -------------------------------------------------------------------------
# Objetivo: fazer um gráfico de barras empilhadas fct
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

# --------------
# Exemplo: gráfico de barras de duração dos filmes (em categorias)
# ideia com case_when() + fatores + paleta de cores manual 

# comecar com case_when(), ai depois fazer o gráfico. mostrar que a ordenação
# não respeita a ordem das variáveis. mudar com forcats e executar o gráfico denovo!

# usar a paleta de cores manual no final :)

library(tidyverse)

imdb <- readr::read_rds("dados/imdb.rds")


paleta_de_cores_definida <- c("#40E0D0",
                              "#48D1CC",
                              "#20B2AA",
                              "#008B8B",
                              "#008080",
                              "#A9A9A9")

prismatic::color(paleta_de_cores_definida)



imdb %>%
  mutate(
    duracao_filme = case_when(
      duracao < 60 ~ "Muito curto",
      duracao >= 60 &
        duracao < 90 ~ "Curto",
      duracao >= 90 &
        duracao < 120 ~ "Normal",
      duracao >= 120 &
        duracao < 200 ~ "Longo",
      duracao >= 200 ~ "Muito longo",
      TRUE ~ "Não sei"
    )
  ) %>%
  relocate(duracao_filme, .after = duracao) %>%
  count(duracao_filme, name = "frequencia") %>%
  mutate(duracao_filme = forcats::fct_relevel(
    # util para variaveis ordinais
    duracao_filme,
    c(
      "Muito curto",
      "Curto",
      "Normal",
      "Longo",
      "Muito longo",
      "Não sei"
    )
  )) %>%
  ggplot() +
  geom_col(aes(x = duracao_filme, y = frequencia, fill = duracao_filme),
           show.legend = FALSE) +
  theme_light() +
  scale_fill_manual(values = paleta_de_cores_definida) +
  labs(x = "Duração do filme", y = "Número de filmes") +
  geom_label(aes(x = duracao_filme, y = frequencia + 110, label = frequencia))



# -------------------------------------------------------------------------
# DESAFIO
# Objetivo: criar o tema "Star Wars" para o gráfico do comeco da pratica
library(tidyverse)

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
