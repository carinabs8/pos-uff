#tarefa 1
library(readxl)
funcionarios <- read_excel("Desktop/pos/1_periodo/trabalho4/funcionarios.xlsx", 
                           skip = 1)
tabela <- table(funcionarios$`Estado civil`, funcionarios$`Grau de instrução`)
show(tabela)

tabela2<- as.data.frame(table(funcionarios$`Estado civil`, funcionarios$`Grau de instrução`))

tabela3 <- matrix(tabela[1:6], nrow = 2, ncol = 3)
colnames(tabela3) <- c("Fundamental", "Médio", "Superior")
row.names(tabela3) <- c("Casado", "Solteiro")
#tarefa 2
write.xlsx(tabela3, file = "tabelas.xlsx",
           sheetName = "Tabela de contingencia1", append = F)

#tarefa 3
require(epiDisplay)
tabela4 <- tabpct(funcionarios$`Estado civil`, funcionarios$`Grau de instrução`, main= "Tabela de contigencia", ylab="Grau de instrução", xlab="Estado civil")
write.xlsx(tabela4, file = "tabelas.xlsx",
           sheetName = "Tabela de contingencia2", append = T)
#tarefa 4
mosaicplot(table(funcionarios$`Estado civil`, funcionarios$`Grau de instrução`), col=c("green", "blue", "red"), main="Gráfico de mosaico")

#tarefa 5
media_qui_quadrado = chisq.test(funcionarios$`Estado civil`, funcionarios$`Grau de instrução`)
media_qui_quadrado$statistic

require("DescTools")
ContCoef(funcionarios$`Estado civil`, funcionarios$`Grau de instrução`)
