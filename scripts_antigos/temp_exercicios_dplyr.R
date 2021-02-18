# Exercícios --------------------------------------------------------------

# 1. Crie uma tabela com apenas as colunas titulo, diretor, 
# e orcamento. Salve em um objeto chamado imdb_simples.

# 2. Selecione apenas as colunas ator_1, ator_2 e ator_3 usando
# o ajudante contains().

# Exercícios --------------------------------------------------------------

# 1. Ordene os filmes em ordem crescente de ano e
# decrescente de receita e salve em um objeto
# chamado filmes_ordenados.

# 2. Selecione apenas as colunas título e orçamento
# e então ordene de forma decrescente pelo orçamento.


# Exercício ---------------------------------------------------------------

# Refaça o exercício 2 do arrange utilizando o %>%.

# 2. Selecione apenas as colunas título e orçamento 
# e então ordene de forma decrescente pelo orçamento.

# Exercícios --------------------------------------------------------------

# 1. Criar um objeto chamado `filmes_pb` apenas com filmes
# preto e branco. (==)
# dica: use unique(), count(), distinct() ou table() pra descobrir como que "preto e branco"
# está representado na tabela.

# 2. Criar um objeto chamado curtos_legais com filmes 
# de 90 minutos ou menos de duração e nota no imdb maior do que 8.5.

# Exercícios --------------------------------------------------------------

# 1. Crie uma coluna chamada prejuizo (orcamento - receita)
# e salve a nova tabela em um objeto chamado imdb_prejuizo.
# Em seguida, filtre apenas os filmes que deram prejuízo
# e ordene a tabela por ordem crescente de prejuízo.
# mutate, filter, arrange

# 2. Crie uma nova coluna que classifique o filme em
# "recente" (posterior a 2000) e "antigo" de 2000 para trás.
# mutate, ifelse

# Exercícios --------------------------------------------------------------

# 1. Calcule a duração média e mediana dos filmes 
# da base.
# summarise

# 2. Calcule o lucro médio dos filmes com duracao
# menor que 60 minutos.
# filter, summarise

# 3. Apresente na mesma tabela o lucro médio
# dos filmes com duracao menor que 60 minutos
# e o lucro médio dos filmes com duracao maior
# ou igual a 60 minutos.
# mutate, group by, summarise


# Exercícios --------------------------------------------------------------

# 1. Salve em um novo objeto uma tabela com a
# nota média dos filmes de cada diretor. Essa tabela
# deve conter duas colunas (diretor e nota_imdb_media)
# e cada linha deve ser um diretor diferente.

# 2. Use o left_join para trazer a coluna
# nota_imdb_media da tabela do exercício 1
# para a tabela imdb original.