# install.packages("devtools")
# devtools::install_github("curso-r/basesCursoR")

# Quais são as bases disponíveis no basesCursoR?
basesCursoR::bases_disponiveis()

# Salvar a base imdb em um objeto
imdb <- basesCursoR::pegar_base("imdb")
imdb_avaliacoes <- basesCursoR::pegar_base("imdb_avaliacoes")

imdb <- imdb %>% 
  select(-titulo) %>% 
  rename(titulo = titulo_original) %>% 
  filter(pais == "USA")

# Salvar o imdb localmente
readr::write_csv2(imdb, "dados/imdb2.csv")
readr::write_csv(imdb, "dados/imdb.csv")
readr::write_rds(imdb, "dados/imdb_rds.rds")
readr::write_rds(imdb, "dados/imdb.rds")
readr::write_tsv(imdb, "dados/imdb.txt")
writexl::write_xlsx(imdb, "dados/imdb.xlsx")

readr::write_rds(imdb_avaliacoes, "dados/imdb_avaliacoes.rds")

