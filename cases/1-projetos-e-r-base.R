# Objetivo: investigar descritivamente a base mtcars

# 1. Iniciar um novo projeto

mtcars

# Estrutura da base (colunas)
str(mtcars)

# Entendendo melhos as variáveis
help(mtcars)

# Variável resposta: mpg

mean(mtcars$mpg)
var(mtcars$mpg)
min(mtcars$mpg)
max(mtcars$mpg)

# Poderíamos filtrar ou contar os carros abaixo ou 
# acima da média, mas ainda não aprendemos como fazer isso

media_mpg <- mean(mtcars$mpg)

# Resumo de todas as variáveis
summary(mtcars)

# Estudando a variável cyl

class(mtcars$cyl)
table(mtcars$cyl)

# Poderíamos calcular a média de mpg para cada
# categoria do cyl, mas ainda não aprendemos como fazer isso

# Correlação entre cyl e mpg

cor(mtcars$mpg, mtcars$cyl)

# Gráfico de dispersão entre as duas variáveis

plot(mtcars$mpg, mtcars$cyl)
