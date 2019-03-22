install.packages("UsingR")
library("UsingR")
library(dplyr)
require("epiDisplay")

data(babies)

babies_maes_nao_ou_fumantes <- subset(babies, babies$smoke != 9, select= c(gestation, wt, age, smoke))
#View(babies_maes_nao_ou_fumantes)

#exercicio 1
shapiro.qqnorm(babies_maes_nao_ou_fumantes$gestation)
media_de_gestacao <- mean(babies_maes_nao_ou_fumantes$gestation)
t.test(babies_maes_nao_ou_fumantes$gestation, mu=280, alternative = "two.side")

#exercicio 2
gest_fumantes <- subset(babies, babies$smoke == 1, select = c(gestation, wt, age, smoke))
media_de_gestacao_fumantes <- mean(gest_fumantes$gestation)
t.test(gest_fumantes$gestation, mu=280, alternative = "less")

par(mfrow = c(1,1))
gestantes_nao_fumantes <- subset(babies, (babies$smoke != 1 & babies$smoke != 9), select = c(gestation, wt, age, smoke))
plot(density(gest_fumantes$gestation))

#exercicio 2
par(mfrow = c(1,2))
mean(gest_fumantes$gestation)
View(gestantes_nao_fumantes)
mean(gestantes_nao_fumantes$gestation)
hist(gestantes_nao_fumantes$gestation, main="Maes não fumantes", xlab="Gestação")
hist(gest_fumantes$gestation, main = "Maes fumantes", xlab="Gestação")
t.test(x=gest_fumantes$gestation, y=gestantes_nao_fumantes$gestation, alternative = "less", var.equal = F)

#exercicio 3
par(mfrow = c(1,1))
View(gestantes_nao_fumantes)
shapiro.qqnorm(gest_fumantes$wt)
t.test(x=gest_fumantes$wt, y=gestantes_nao_fumantes$wt, alt = "less", var.equal = F)

#parte2
data(exec.pay)
View(exec.pay)
log.exec.pay <- log(as.data.frame(exec.pay))
log.exec.pay <- subset(log.exec.pay, !is.infinite(exec.pay))
hist(log.exec.pay)

require(DescTools)
SignTest(exec.pay, mu=2200, alt = "greater")
log<-log(220.000)
mean(log.exec.pay$exec.pay)
hist(log.exec.pay$exec.pay, probability = T)
lines(density(log.exec.pay$exec.pay))
wilcox.test(log.exec.pay$exec.pay, mu=log, alternative = "greater")
help("wilcox.test")
