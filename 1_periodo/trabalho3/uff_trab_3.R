library(readxl)
consumo <- read_excel("Desktop/pos/1_periodo/1_trabalho/Consumo.xlsx")

#carne bovina
plot(consumo$consumo_bovino, consumo$preco_bovino_varejo, main="Preço varejo e consumo da carne bovina.", xlab="consumo bovino", ylab="preço varejo da carne bovina", pch=20, col="blue")
cor(consumo$preco_bovino_varejo, consumo$consumo_bovino)

#carne de frango
plot(consumo$consumo_frango, consumo$preco_frango_varejo, main="Preço varejo e consumo da carne de frango", xlab="consumo de frango", ylab="preço varejo da carne de frango", pch=20, col="green")
cor(consumo$preco_frango_varejo, consumo$consumo_frango)

library(dplyr)
consumo <- mutate(consumo, diferenca_carne_bovina_e_frango=(consumo$preco_bovino_varejo - consumo$preco_frango_varejo))
View(consumo)

#diagrama de dispersão das variáveis consumo da carne de frango e diferença de preço.

plot(consumo$consumo_frango, consumo$diferenca_carne_bovina_e_frango, main="Consumo da carne de frango", xlab="consumo de frango", ylab="variação de preço entre a carne de frango e bovina", pch=20, col="green")
cor(consumo$diferenca_carne_bovina_e_frango, consumo$consumo_frango)
