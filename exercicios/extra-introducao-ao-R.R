# 1.  O pai de Julio pediu para ele ir ao mercado. 
# Ele pediu para o garoto comprar feijão e, se 
# o quilo do arroz estiver abaixo de 10 reais,
# trazer também um quilo de arroz.

# Se o quilo do arroz estivesse custando 12 reais,
# o cenário acima poderia ser expresso na linguagem
# R, pelo código abaixo.

preco_kg_arroz <- 12

if (preco_kg_arroz < 10) {
  "Julio comprou arroz e feijão."
} else {
  "Julio comprou apenas feijão."
}

# Nesse caso, o "resultado" é Julio ter comprado apenas
# feijão.

# Podemos generalizar esse código para testarmos 
# com vários preços de arroz. Para isso, vamos 
# transformá-lo em uma função

o_que_julio_comprou <- function(preco_kg_arroz) {
  if (preco_kg_arroz < 10) {
    "Julio comprou arroz e feijão."
  } else {
    "Julio comprou apenas feijão."
  }
}

o_que_julio_comprou(8)
o_que_julio_comprou(12)

# Agora podemos testar o nosso cenário
# qualquer valor do quilo do arroz que quisermos.

# Modifique a função "o_que_julio_comprou" para
# representar os seguintes novos cenários:

# a) Julio deve comprar feijão e, se o quilo
# do arroz estiver abaixo de 12 reais, comprar
# arroz.

# b) Julio deve comprar arroz e feijão, mas
# apenas se o quilo do arroz estiver abaixo 
# de 10 reais. Caso contrário, não deve comprar
# nada.

# c) Julio deve comprar arroz e feijão se o quilo
# do arroz estiver menor de 10 reais; apenas 
# feijão se o quilo do arroz estiver entre 10 
# (inclusive) e 12 reais; e não deve comprar nada
# se o quilo do arroz estiver 12 reais ou mais 
# caro.

# d) Julio deve comprar arroz e feijão se o quilo
# do arroz estiver abaixo de 10 reais E se o quilo
# do feijão estiver abaixo de 8 reais. Caso contrário,
# ele não deve comprar nada.

# DICA: você deve insirir outro argumento (preco_kg_feijao)
# na função o_que_julio_comprou.


# 2. Quando programos o despertador do nosso
# celular para acordar de manhã, estamos, 
# internamente, programando um laço (for) para 
# que uma mesma tarefa (despertar) seja
# executada várias vezes.

# Vamos imaginar que todos os dias o nosso 
# celular verifica se ele precisa despertar 
# às 8 horas da manhã. Se quisermos acordar
# todos os dias nesse horário, isso poderia ser
# representado, no R, pelo seguinte código

dias_da_semana <- c("seg", "ter", "qua", "qui", "sex", "sab", "dom")

for (dia in dias_da_semana) {
  mensagem <- paste0("8 horas da manhã de ", dia, "! Hora de acordar!")
  print(mensagem)
  beepr::beep(1)
  Sys.sleep(1)
}

# O comando Sys.sleep(1) faz o R esperar
# 1 segundo antes de continuar executando
# o código. (Esse 1 segundo representa
# no nosso exemplo as 24 horas entre dois dias.)

# a) Complete o código abaixo para 
# fazer o nosso despertador não "tocar" no
# fim de semana.

dias_da_semana <- c("seg", "ter", "qua", "qui", "sex", "sab", "dom")

for (dia in dias_da_semana) {
  if (..........) {
    mensagem <- paste0("8 horas da manhã de ", dia, "! Hora de acordar!")
    print(mensagem)
    beepr::beep(1)
    Sys.sleep(1)
  }
}

# b) Complete o código abaixo para fazer
# o nosso despertador iterar (caminhar) no 
# dia do mês e não mais no dia da semana.
# Pode considerar que todo mês tem 30 dias.


dias_do_mes <- ..........

for (dia in ..........) {
  mensagem <- paste0("8 horas da manhã de ", ..........)
  print(mensagem)
  beepr::beep(1)
  Sys.sleep(1)
}
