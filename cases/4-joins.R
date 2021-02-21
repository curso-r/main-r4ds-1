# Carregar pacotes utilizados

library(readr)
library(janitor)
library(dplyr)
library(ggplot2)
library(stringr)
library(abjutils)


# Importar dados do SEADE -----------

# Download das bases feito dia 02 de novembro de 2020
# URL: http://www.imp.seade.gov.br/frontend/#/tabelas

seade_bruto <- read_delim(
  "dados/imp_2020-11-02_12-22.csv",
  ";",
  escape_double = FALSE,
  locale = locale(grouping_mark = ".",
                  encoding = "ISO-8859-1"),
  trim_ws = TRUE
)


# Limpeza dos dados

seade_limpo <- seade_bruto %>%
  # Limpar o nome das colunas com clean names
  janitor::clean_names() %>%
  # Renomear algumas colunas em que o nome ficou muito grande
  dplyr::rename(
    "esgoto_sanitario" =
      esgoto_sanitario_nivel_de_atendimento_censo_demografico_em_percent,
    "coleta_de_lixo" =
      coleta_de_lixo_nivel_de_atendimento_censo_demografico_em_percent,
    "abastecimento_de_agua" =
      abastecimento_de_agua_nivel_de_atendimento_censo_demografico_em_percent
  ) %>%
  # Filtrar: queremos apenas os dados mais recentes
  dplyr::filter(periodos == 2010) %>%
  # Arrumar coluna esgoto_sanitario, número está como texto
  dplyr::mutate(esgoto_sanitario = parse_double(esgoto_sanitario,
                                                locale = locale(decimal_mark = ",")))

# Ver a base, verificar se todas as colunas tem a classe correta
glimpse(seade_limpo)

# Carregar base do pacote geobr ----------------
# Ler os dados de municípios no estado de São Paulo

municipios_sp <- geobr::read_municipality("SP")



# Left Join usando código IBGE ----------------
# O argumento by representa as colunas chaves

municipios_leftjoin_codigoibge <- left_join(x = municipios_sp, 
                                            y = seade_limpo,   
                                            by = c("code_muni" = "cod_ibge"))

# Verificar se tem NA na coluna periodos na base unida
sum(is.na(municipios_leftjoin_codigoibge$periodos))


# Visualização (apenas um exemplo) ---------

municipios_leftjoin_codigoibge %>%
  ggplot() +
  geom_sf(aes(fill = esgoto_sanitario)) +
  theme_bw() +
  scale_fill_viridis_b(direction = -1)


# Join usando o nome dos municípios -----------
# Deu errado! 
# Left Join
municipios_leftjoin_nomemunicipios <- left_join(x = municipios_sp,
                                                y = seade_limpo,
                                                by = c("name_muni" = "localidades"))

View(municipios_leftjoin_nomemunicipios)

#inner join

municipios_innerjoin_nomemunicipios <-
  inner_join(x = municipios_sp,
             y = seade_limpo,
             by = c("name_muni" = "localidades"))

View(municipios_innerjoin_nomemunicipios)
nrow(municipios_innerjoin_nomemunicipios)

# antijoin

municipios_antijoin_nomemunicipios <- anti_join(x = municipios_sp,
                                                y = seade_limpo,
                                                by = c("name_muni" = "localidades"))

View(municipios_antijoin_nomemunicipios)
nrow(municipios_antijoin_nomemunicipios)

# full join
municipios_fulljoin_nomemunicipios <- full_join(x = municipios_sp,
                                                y = seade_limpo,
                                                by = c("name_muni" = "localidades"))

View(municipios_fulljoin_nomemunicipios)
nrow(municipios_fulljoin_nomemunicipios)


# Limpando a base - Parte 2 - para fazer o join usando o nome dos municípios

municipios_sp_limpo <- municipios_sp %>%
  mutate(
    # Transformar nome de municípios em letras minúsculas
    nome_muni = stringr::str_to_lower(name_muni),
    # Remover acentuação do nome dos municípios
    nome_muni = abjutils::rm_accent(nome_muni),
    # Substituir o - por espaço
    nome_muni = stringr::str_replace_all(nome_muni, "-", " "),
    # Arrumar casos onde existe erro de digitação no nome do município
    nome_muni = dplyr::case_when(
      nome_muni == "moji mirim" ~ "mogi mirim",
      nome_muni == "embu" ~ "embu das artes",
      nome_muni == "florinia" ~ "florinea",
      nome_muni == "sao luis do paraitinga" ~ "sao luiz do paraitinga",
      TRUE ~ nome_muni
    )
  )

# Faz a mesma limpeza nas duas bases! Para ficar padronizado
seade_limpo_nomes <- seade_limpo %>%
  mutate(
    nome_muni = stringr::str_to_lower(localidades),
    nome_muni = abjutils::rm_accent(nome_muni),
    nome_muni = stringr::str_replace_all(nome_muni, "-", " "),
    nome_muni = dplyr::case_when(
      nome_muni == "moji mirim" ~ "mogi mirim",
      nome_muni == "embu" ~ "embu das artes",
      nome_muni == "florinia" ~ "florinea",
      nome_muni == "sao luis do paraitinga" ~ "sao luiz do paraitinga",
      TRUE ~ nome_muni
    )
  )


# Juntando as bases com as colunas nome_muni padronizadas 

municipios_sp_nome <- full_join(municipios_sp_limpo,
                                seade_limpo_nomes,
                                by = "nome_muni")

View(municipios_sp_nome)
nrow(municipios_sp_nome)


# Novamente, uma visualização de exemplo

municipios_sp_nome  %>%
  ggplot() +
  geom_sf(aes(fill = abastecimento_de_agua)) +
  theme_bw() +
  scale_fill_viridis_b(direction = -1)