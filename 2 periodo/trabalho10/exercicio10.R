setwd("~/Desktop/pos/2 periodo/trabalho10")
library(dplyr)
library(epiDisplay)
library(readxl)
beisebol <- read_excel("Beisebol.xlsx")
par(mfrow=c(1,1))
plot(beisebol$Proporcao_de_vitorias ~ beisebol$Runs_Feitos, xlab = "Runs feitos",
     ylab = "Proporção de vitórias", col="blue")

cor(beisebol$Proporcao_de_vitorias, beisebol$Runs_Feitos)
#Proporcao_de_vitorias e Runs_Feitos.
ajuste1 <- lm(Proporcao_de_vitorias ~ Runs_Feitos, data=beisebol)
abline(ajuste1, col="red")
ajuste2 <- lm(Proporcao_de_vitorias[-9] ~ Runs_Feitos[-9], data=beisebol)#ponto de alavancagem 
abline(ajuste2, col="purple")
ajuste3 <- lm(Proporcao_de_vitorias[-25] ~ Runs_Feitos[-25], data=beisebol)#ponto de alavancagem 
abline(ajuste3, col="black")
par(mfrow=c(2,2))

#distancia de cook
plot(cooks.distance(ajuste2), type="h")
#verificando normalidade
shapiro.test(residuals(ajuste2)) #p-valor bem alto, 0.509, nao desprezo a hipótesa que ajuste 2 seja normal

#homocedasticidade
require(lmtest)
gqtest(ajuste2)#p-valor bem alto, nao despreza hipotese de homocedasticidade

#teste de independencia
res <- residuals(ajuste2)
n <- length(res)
plot(res[-n], res[-1])
dwtest(ajuste2) #p-valor alto, indica que ajuste2 possui pontos independentes.

#exercicio3
par(mfrow=c(1,1))
plot(beisebol$Proporcao_de_vitorias ~ beisebol$Runs_Permitidos, xlab = "Runs permitidos",
     ylab = "Proporção de vitórias", col="blue")
cor(beisebol$Proporcao_de_vitorias, beisebol$Runs_Permitidos)
ajuste_vitoria <- lm(Proporcao_de_vitorias ~ Runs_Permitidos, data = beisebol)
summary(ajuste_vitoria)
abline(ajuste_vitoria, col="pink")
identify(beisebol$Runs_Permitidos, beisebol$Proporcao_de_vitorias)

ajuste_vitoria_1 <- lm(Proporcao_de_vitorias[-5] ~ Runs_Permitidos[-5], data = beisebol)
abline(ajuste_vitoria_1, col="green")
ajuste_vitoria_2 <- lm(Proporcao_de_vitorias[-24] ~ Runs_Permitidos[-24], data = beisebol)
abline(ajuste_vitoria_2, col="red")

#verificando normalidade
shapiro.test(residuals(ajuste_vitoria_1)) #p-valor bem alto, 0.9079, nao desprezo a hipótesa que ajuste 2 seja normal
gqtest(ajuste_vitoria_1)#p-valor bem alto,0.7737, nao despreza hipotese de homocedasticidade
par(mfrow=c(2,2))
plot(ajuste_vitoria_2)

#exercicio 4
par(mfrow=c(1,1))
plot(beisebol$Proporcao_de_vitorias ~ beisebol$Saldo, xlab = "Saldos",
     ylab = "Proporção de vitórias", col="blue")
identify(beisebol$Proporcao_de_vitorias ~ beisebol$Saldo)
ajuste_saldos_1 <- lm(beisebol$Proporcao_de_vitorias ~ beisebol$Saldo)
abline(ajuste_saldos_1)
ajuste_saldos_2 <- lm(beisebol$Proporcao_de_vitorias[-9] ~ beisebol$Saldo[-9])
abline(ajuste_saldos_2, col="red")

summary(ajuste_saldos_1)
par(mfrow=c(2,2))
plot(ajuste_saldos_2)

#exercicio 5
#Com base na analise, o melhor ajuste em todos, é o primeiro, pois nao existem pontos de alavancagem nem uma distancia de cook alta nos outros modelos.
cor(beisebol[,c(2:6)])
cor(beisebol$Runs_Feitos,beisebol$Vitorias)
cor(beisebol$Runs_Permitidos,beisebol$Vitorias)
#b) Parecer ser mais eficaz um ataque forte a uma defesa forte. Observamos isso na correlação entre Runs feitos e vitorias vs runs permitidos e vitorias.

#exercicio6
lm_1 <- lm(Vitorias ~ Runs_Feitos, data = beisebol)
lm_2 <- lm(Vitorias ~ Runs_Permitidos, data = beisebol)
x = data.frame(Runs_Feitos = 844.0)
x_2 = data.frame(Runs_Permitidos = 722)
predict(lm_1, x, int="prediction")
predict(lm_2, x_2, int="prediction")
