#grafico único GRAFICO1
consumo <- read.csv(file="/Users/carinabs8/Desktop/pos/1_periodo/Consumo.csv", header = TRUE, sep = ";", fill=TRUE)

grafico_width <- 2
colores_grafico <- c("red", "blue")
par(mfrow=c(1,1))

consumo_bovino = as.numeric(str_replace(consumo$consumo_bovino, ",", '.'))
consumo_frango = as.numeric(str_replace(consumo$consumo_frango, ",", '.'))

plot(as.numeric(consumo$ano), consumo_bovino, type="l", main="Consumo por ano", xlab="Ano", ylab="Consumo", col=colores_grafico[1], ylim=c(0, 100), lwd=grafico_width)
lines( consumo$ano, consumo_frango, type="l", col=colores_grafico[2], lwd=grafico_width, ylim=c(0,100))

legend("top", c("bovino", "frango"), col = colores_grafico, merge = TRUE, lty=1:1, cex=1, lwd=grapico_width)


#grafico duplo GRAFICO2
par(mfrow=c(1,2))
preco_bovino_varejo = as.numeric(str_replace(consumo$preco_bovino_varejo, ",", '.'))
preco_frango_varejo = as.numeric(str_replace(consumo$preco_frango_varejo, ",", '.'))


plot(as.numeric(consumo$ano), consumo_bovino, type="l", main="Consumo por ano", xlab="Ano", ylab="Consumo", col=colores_grafico[1], ylim=c(33, 100), lwd=grafico_width)
lines( consumo$ano, consumo_frango, type="l", col=colores_grafico[2], lwd=grafico_width)

legend("top", c("bovino", "frango"), col = colores_grafico, merge = TRUE, lty=1:1, cex=1, lwd=grapico_width)

plot(as.numeric(consumo$ano), preco_bovino_varejo, type="l", main="Preço a varejo por ano", xlab="Ano", ylab="Preço", col=colores_grafico[1], ylim=c(50, 700), lwd=grafico_width)

lines(as.numeric(consumo$ano), preco_frango_varejo, type="l",col=colores_grafico[2], lwd=grafico_width)

legend("top", c("bovino", "frango"), col=colores_grafico, merge=TRUE, lty=1:1, cex=1, lwd=grapico_width, inset = c(-0.2, 0))

#GRAFICO 3
#install.packages("stringr", repos='http://cran.us.r-project.org')
#library("stringr")

par(mfrow=c(1,1))

libra_para_quilo <- 0.453592
consumo_bovino_quilograma <-  as.numeric(str_replace(consumo$consumo_bovino, ",", '.')) * libra_para_quilo
consumo_frango_quilograma <- as.numeric(str_replace(consumo$consumo_frango, ",", '.')) * libra_para_quilo

plot(as.numeric(consumo$ano), consumo_bovino_quilograma, type="l", main="Consumo por ano em quilograma", xlab="Ano", ylab="Consumo", col=colores_grafico[1], ylim=c(15, 50), lwd=grafico_width)
lines(consumo$ano, consumo_frango_quilograma, type="l", col=colores_grafico[2], lwd=grafico_width)

legend("top", c("bovino", "frango"), col = colores_grafico, merge = TRUE, lty=1:1, cex=1, lwd=grapico_width, inset = c(-0.2, 0))

#GRAFICO 4

par(mfrow=c(1,1))
libra_para_euro <- 1.1391

preco_bovino_varejo_euro <- as.numeric(str_replace(consumo$preco_bovino_varejo, ",", '.')) * libra_para_euro
preco_frango_varejo_euro <- as.numeric(str_replace(consumo$preco_frango_varejo, ",", '.')) * libra_para_euro

plot(as.numeric(consumo$ano), preco_bovino_varejo_euro, type="l", main="Preço a varejo em euros por ano", xlab="Ano", ylab="Preço", col=colores_grafico[1], ylim=c(50, 750), lwd=grafico_width)
lines(consumo$ano, preco_frango_varejo_euro, type="l", col=colores_grafico[2], lwd=grafico_width)

legend("top", c("bovino", "frango"), col = colores_grafico, merge = TRUE, lty=1:1, cex=1, lwd=grapico_width, inset = c(-0.2, 0))