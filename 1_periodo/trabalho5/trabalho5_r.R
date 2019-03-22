library(readxl)
funcionarios <- read_excel("Desktop/pos/1_periodo/trabalho5/Funcionarios.xlsx", 
                           sheet = "Plan1", skip = 1)

grau_de_instrucao <- factor(funcionarios$'Grau de Instrução')
levels(grau_de_instrucao)
grau_de_instrucao <- as.numeric(grau_de_instrucao)
#View(grau_de_instrucao)

classe_social <- factor(funcionarios$`Classe Social`, levels = c("C", "B", "A"))
levels(classe_social)
classe_social <- as.numeric(classe_social)
#View(classe_social)

cor(grau_de_instrucao, classe_social, method = "spearman")
cor(grau_de_instrucao, classe_social, method = "kendall")

#o que se pode falar dos valores obtidos?

install.packages("sjstats")
install.packages("dplyr")
library(dplyr)
library("sjstats")

data(efc)
str(efc)
View(select(efc, c12hour, e16sex, e42dep))

dados <- select(efc, c12hour, e16sex, e42dep)

ajuste1 <- aov(c12hour ~ e16sex, data=dados)
ajuste2 <- aov(c12hour ~ e42dep, data = dados)
eta_sq(ajuste1)
eta_sq(ajuste2)