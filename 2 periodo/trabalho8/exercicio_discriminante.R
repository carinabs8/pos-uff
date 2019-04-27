library(MASS)
library(readxl)
library(dplyr)
library(mvShapiroTest)
library(ggplot2)
m_saude <- read_excel("trabalho8/MSAUDE.xls", col_types = c("blank", "numeric", "numeric", "numeric", 
            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
            "numeric", "numeric"))
f_saude <- read_excel("trabalho8/FSAUDE.xls", col_types = c("blank", "numeric", "numeric", "numeric", 
                                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                            "numeric", "numeric"))
m_saude <- mutate(m_saude, sexo="M")
f_saude <- mutate(f_saude, sexo="F")
saude <- merge(f_saude, m_saude, all=TRUE)
write.csv2(saude, "trabalho8/saude.csv")

#teste_de_normalidades[[2]][12]
mvShapiro.Test(as.matrix(saude[1:12])) # p-valor muito pequeno, entao refuta a ideia de que os dados sao normais

#analise de variaveis com distribuição normal
variaveis_para_analise <- names(saude[-14])
variaveis_normais <- c()
for( i in 1:length(variaveis_para_analise)){
  variavel <- paste("saude$",variaveis_para_analise[i], sep = "")
  print(variaveis_para_analise[i])
  x <- eval(parse(text=paste("saude$",variaveis_para_analise[i], sep = "")))
  shapiro_result <- mvShapiro.Test(x)
  if(shapiro_result$p.value >= 0.05){
    vetor_indice = length(variaveis_normais)
    variaveis_normais[(length(variaveis_normais) +1)] <- variaveis_para_analise[i]
  }
}
variaveis_normais
#testes de media
analise=hotelling.test(f_saude,m_saude)
analise
#MATRIZ DE CORRELACAO ENTRE AS VARIAVEIS - QUANTO MAIS ESCURO MAIOR A CORRELACAO
matriz_de_correlacao <- cor(saude[1:12])
corrgram(matriz_de_correlacao, type = 'cor', lower.panel = panel.shade, upper.panel = panel.pie)

numero_de_linhas <- nrow(saude[1:12])
numero_de_colunas <- ncol(saude[1:12])
variancia <- var(saude[1:12])


qqnorm(saude$ALT)
qqline(saude$ALT)
#pega amostras
amostras_saude <- sample_n(saude, 30)
#medias_amostrais
medias <- matrix(apply(amostras_saude[1:12],2,mean),ncol=1)
qqplot(t(t(amostras_saude[1:12])), qchisq(ppoints(nrow(amostras_saude)), ncol(amostras_saude[1:12])))


#analise discriminante linear
analise_discriminante_linear = lda(saude$sexo ~ saude$ALT, CV=T)
analise_discriminante_linear$class
classificacao <- xtabs(~analise_discriminante_linear$class + sexo, data=saude)
porcentagem_de_acertos <- diag(classificacao)/colSums(classificacao) *100
