library(readr)
poluicao <- read_delim("Desktop/pos/1_periodo/2_trabalho/poluicao.csv", ";", escape_double = FALSE, locale = locale(encoding = "ISO-8859-1"), trim_ws = TRUE)
#install.packages("stringr", repos='http://cran.us.r-project.org')
library("stringr")

grafico_width <- 2
colores_grafico <- c("red", "blue", "yellow")
datas <- as.Date(poluicao$DATA, "%d/%m/%Y")
pm_10 <- as.numeric(str_replace(poluicao$PM10, ",", '.'))
co <- as.numeric(str_replace(poluicao$co, ",", '.'))
no2 <- as.numeric(str_replace(poluicao$no2, ",", '.'))

plot(datas, pm_10, type="h", main="Medição atmosférica diária de partículas sólidas", xlab="Data", ylab="PM10", col=colores_grafico[1],  lwd=grafico_width)
plot(datas, co, type="h", main="Medição atmosférica diária de partículas sólidas", xlab="Data", ylab="CO", col=colores_grafico[2],  lwd=grafico_width)
plot(datas, no2, type="h", main="Medição atmosférica diária de partículas sólidas", xlab="Data", ylab="NO2", col=colores_grafico[3],  lwd=grafico_width)

tabela1 <- as.data.frame(poluicao)
View(tabela1)

plot(datas, pm_10, type="l", main="Medição atmosférica diária de partículas sólidas", xlab="Data", ylab="PM10", col=colores_grafico[1],  lwd=grafico_width)
plot(datas, co, type="l", main="Medição atmosférica diária de partículas sólidas", xlab="Data", ylab="CO", col=colores_grafico[2],  lwd=grafico_width)
plot(datas, no2, type="l", main="Medição atmosférica diária de partículas sólidas", xlab="Data", ylab="NO2", col=colores_grafico[3],  lwd=grafico_width)


library(lubridate)
library(dplyr)
semanas = week(datas)
meses = month(datas)
poluicao_2 <- mutate(poluicao, semana= semanas, meses= meses)

poluicao_semana <- group_by(poluicao_2, semana)
medias_semanais <- summarise(poluicao_semana, pm_10=mean(as.numeric(str_replace(PM10, ",", '.'))), co=mean(as.numeric(str_replace(co, ",", '.'))), no2=mean(as.numeric(str_replace(no2, ",", '.'))))
View(medias_semanais$semana)

par(mfrow=c(1,3))
plot(medias_semanais$semana, medias_semanais$pm_10, type="l", xlab="Semanas", ylab="PM10", col=colores_grafico[1],  lwd=grafico_width, ylim=c(28801.00, 100532.86))
plot(medias_semanais$semana, medias_semanais$co, type="l", xlab="Semanas", ylab="CO", col=colores_grafico[2],  lwd=grafico_width)
plot(medias_semanais$semana, medias_semanais$no2, type="l", xlab="Semanas", ylab="NO2", col=colores_grafico[3],  lwd=grafico_width)

poluicao_mensal <- group_by(poluicao_2, meses)
medias_mensais <- summarise(poluicao_mensal, pm_10=mean(as.numeric(str_replace(PM10, ",", '.'))), co=mean(as.numeric(str_replace(co, ",", '.'))), no2=mean(as.numeric(str_replace(no2, ",", '.'))))
View(medias_mensais)

plot(medias_mensais$meses, medias_mensais$pm_10, type="l",xlab="MES", ylab="PM10", col=colores_grafico[1],  lwd=grafico_width)
plot(medias_mensais$meses, medias_mensais$co, type="l", xlab="MES", ylab="CO", col=colores_grafico[2],  lwd=grafico_width)
plot(medias_mensais$meses, medias_mensais$no2, type="l", xlab="MES", ylab="NO2", col=colores_grafico[3],  lwd=grafico_width)

#summary(poluicao)
tabela1 <- table(data=poluicao$DATA, pm_10=poluicao$PM10, no2=poluicao$no2)
tabela1 <- as.data.frame(tabela1)
write.table(tabela1, file="Desktop/pos/1_periodo/2_trabalho/tabela1.csv", sep = ";", row.names = F)
#remove(tabela1)

