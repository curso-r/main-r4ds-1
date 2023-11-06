# AULA 3 --------------------------------------
# Exemplo usando dados do IBGE, para o Brasil e Estados

# Download feito no dia 28/02/2021
# https://www.ibge.gov.br/cidades-e-estados

# Exportar > Todas as UFs. Escolhi xlsx

url <- "https://docs.google.com/spreadsheets/d/1FzVnUUG5Fp-VuuGe0ummQ8KliH9C_47G6Q-pB310m9s/edit?usp=sharing"


# Importação
# Aula de importação

library(tidyverse)
# install.packages("googlesheets4")
# install.packages("janitor")

# Primeira tentativa de importação
dados_brutos_brasil <-
  googlesheets4::read_sheet(url)

# Perguntar: o que acha que precisamos arrumar na importação?

dados_brutos_brasil <-
  googlesheets4::read_sheet(url, skip = 2, n_max = 27)


names(dados_brutos_brasil)

View(dados_brutos_brasil)


# Organização da base ------------



# > names(dados_brutos_brasil)
# [1] "UF [-]"
# [2] "Código [-]"
# [3] "Gentílico [-]"
# [4] "Governador [2019]"
# [5] "Capital [2010]"
# [6] "Área Territorial - km² [2019]"
# [7] "População estimada - pessoas [2020]"
# [8] "Densidade demográfica - hab/km² [2010]"
# [9] "Matrículas no ensino fundamental - matrículas [2018]"
# [10] "IDH <span>Índice de desenvolvimento humano</span> [2010]"
# [11] "Receitas realizadas - R$ (×1000) [2017]"
# [12] "Despesas empenhadas - R$ (×1000) [2017]"
# [13] "Rendimento mensal domiciliar per capita - R$ [2020]"
# [14] "Total de veículos - veículos [2018]"

dados_brasil_arrumando <- dados_brutos_brasil %>%
  janitor::clean_names()

dados_brasil_arrumando %>%
  glimpse()


dados_brasil <- dados_brasil_arrumando %>%
  rename(
    "capital" = capital_2010,
    "area_territorial" = area_territorial_km2_2019,
    "populacao_estimada" = populacao_estimada_pessoas_2020,
    "densidade_demografica" = densidade_demografica_hab_km2_2010,
    "matriculas_ensino_fund" = matriculas_no_ensino_fundamental_matriculas_2018,
    "idh" = idh_span_indice_de_desenvolvimento_humano_span_2010,
    "receitas_realizadas" = receitas_realizadas_r_1000_2017,
    "despesas_empenhadas" = despesas_empenhadas_r_1000_2017,
    "rendimento_mensal_domiciliar_per_capita" = rendimento_mensal_domiciliar_per_capita_r_2020,
    "total_veiculos" = total_de_veiculos_veiculos_2018
  )


# Salvar a base de dados

readr::write_csv2(x = dados_brasil, file = "pratica/dados_brasil.csv")



# Exemplos com select e arrange
# Organizar os estados por IDH

dados_brasil %>%
  select(uf, populacao_estimada) %>%
  arrange(-populacao_estimada)


# Dentre os estados da sua região, qual é o estado com maior
# população estimada?

dados_brasil_regiao %>%
  filter(regiao == "Sudeste") %>%
  select(uf, populacao_estimada) %>%
  arrange(desc(populacao_estimada)) %>%
  slice(1)


# Na aula 4 - faltou na aula 3: lembrar de salvar a base gerada até aqui.
#  Vamos usar na continuacao da aula.


# Aula 4, parte 2 sobre manipulação de dados ------------


# Depois de mutate - case_when e criar o vetor com a região

dados_brasil_regiao <- dados_brasil %>%
  mutate(
    regiao = case_when(
      uf %in% c(
        "São Paulo",
        "Minas Gerais",
        "Rio de Janeiro",
        "Espírito Santo"
      ) ~ "Sudeste",
      uf %in% c(
        "Acre",
        "Amapá",
        "Amazonas",
        "Pará",
        "Rondônia",
        "Roraima",
        "Tocantins"
      ) ~ "Norte",
      uf %in% c(
        "Alagoas",
        "Bahia",
        "Ceará",
        "Paraíba",
        "Pernambuco",
        "Pernambuco",
        "Piauí",
        "Sergipe",
        "Rio Grande do Norte",
        "Maranhão"
      ) ~ "Nordeste",
      uf %in% c(
        "Paraná", "Rio Grande do Sul",
        "Santa Catarina"
      ) ~ "Sul",
      uf %in% c(
        "Goiás", "Mato Grosso do Sul",
        "Mato Grosso",
        "Distrito Federal"
      ) ~ "Centro-Oeste"
    )
  ) %>%
  relocate(regiao, .after = uf)


# Agrupar e summarizar ----------------------

# Quantos estados tem em cada região?
dados_brasil_regiao %>%
  group_by(regiao) %>%
  summarise(quantidade = n())

# Qual é a área territorial total das regioes?
# Qual é a região com maior área?
dados_brasil_regiao %>%
  group_by(regiao) %>%
  summarise(
    quantidade_estados = n(),
    total_area = sum(area_territorial)
  ) %>%
  arrange(desc(total_area))


# Joins ----------
# precisa de internet, fazer depois
geo_brasil <- geobr::read_state()


ibge_brasil_geo <- left_join(dados_brasil_regiao, geo_brasil, by = c("codigo" = "code_state"))

# salvar a base denovo em um .rds!!! vamos usar depois no relatório

readr::write_rds(ibge_brasil_geo, file = "pratica/data-output/ibge_brasil.Rds")


# Visualização (aulas 5 e 6) ------ #

dados_brasil_regiao %>%
  mutate(pop_milhoes = populacao_estimada / 1000000) %>%
  ggplot() +
  geom_col(aes(x = uf, y = pop_milhoes)) +
  coord_flip() +
  facet_wrap(~regiao, scales = "free_y") +
  theme_bw() +
  labs(
    x = "Unidade Federativa",
    y = "População estimada em (em milhões de pessoas)"
  )

# Mapa, exemplo do geom_sf ---------
ibge_brasil_geo %>%
  mutate(pop_milhoes = populacao_estimada / 1000000) %>%
  ggplot() +
  geom_sf(aes(geometry = geom, fill = pop_milhoes))
