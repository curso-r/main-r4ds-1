# Exemplo utilizando os dados do SEADE (para o Estado de São Paulo) -----------

# Importação dos dados do SEADE
# Download feito no site do SEADE, dia 27 de fevereiro de 2021
# http://www.imp.seade.gov.br/frontend/#/tabelas

# Dados do Nível de Atendimento por Serviços de Abastecimento de Água, Esgotamento Sanitário e Coleta de Lixo
# https://docs.google.com/spreadsheets/d/14n31bXrjSIa8HGYZYGvAT02SMBZtdzfbMZTv8jRAyhA/edit?usp=sharing

# Aula de importação

library(tidyverse)
# install.packages("googlesheets4")
# install.packages("janitor")

# Carregar a base do google sheets
dados_brutos_seade <-
  googlesheets4::read_sheet(
    "https://docs.google.com/spreadsheets/d/14n31bXrjSIa8HGYZYGvAT02SMBZtdzfbMZTv8jRAyhA/edit?usp=sharing"
  )

# Mostrar o que foi carregado, com View()

View(dados_brutos_seade)

# Precisamos limpar o nome das colunas
dados_seade <- dados_brutos_seade %>%
  janitor::clean_names()

# Olhar a base carregada e observar o que ainda precisamos arrumar
glimpse(dados_seade)

# Próxima aula:
# O que arrumar com mutate? Perguntar a opinião das pessoas participantes do curso
# melhorar o nome das colunas... com a função rename
# a coluna de período está como texto, mudar para número
# a coluna de abastecimento de agua, coleta de lixo e esgoto sanitario estão como texto: função parse_number()


# PARTE 2 - MANIPULACAO DA BASE ------------

## Exemplo com os verbos básicos do dplyr --------

dados_limpos <- dados_seade %>%
  rename(
    "abastecimento_de_agua" = abastecimento_de_agua_nivel_de_atendimento_censo_demografico_em_percent,
    "coleta_de_lixo" = coleta_de_lixo_nivel_de_atendimento_censo_demografico_em_percent,
    "esgoto_sanitario" = esgoto_sanitario_nivel_de_atendimento_censo_demografico_em_percent
  ) %>%
  mutate(
    periodos = as.numeric(periodos),
    abastecimento_de_agua =
      parse_number(abastecimento_de_agua, locale = locale(decimal_mark = ",")),
    coleta_de_lixo =
      parse_number(coleta_de_lixo, locale = locale(decimal_mark = ",")),
    esgoto_sanitario =
      parse_number(esgoto_sanitario, locale = locale(decimal_mark =  ","))
  )


# Parte 3 - Unir os dados (Joins) NÃO USAR ISSO!-------------

municipios_sp <- geobr::read_municipality("SP")


municipios_sp %>% glimpse()

left_join(dados_limpos, municipios_sp) # não tem coluna em comum.
# precisa informar qual é a coluna que utilizaremos, usando o argumento by


left_join(dados_limpos, municipios_sp, by = c("cod_ibge" = "code_muni"))
# erro denovo! não podemos unir pois o tipo da coluna é diferente

dados_unidos <- dados_limpos %>%
  mutate(cod_ibge = as.numeric(cod_ibge)) %>%
  left_join(municipios_sp, by = c("cod_ibge" = "code_muni"))

dados_unidos %>% View()

# Parte 4 - Visualização dos dados


dados_unidos %>%
  ggplot() +
  geom_sf(aes(geometry = geom, fill = abastecimento_de_agua)) +
  facet_wrap(~periodos)
