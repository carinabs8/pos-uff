library(dplyr)
library(epiDisplay)

#=========================CRIACAO DE TABELA D FREQUENCIA MASCULINA
hist(msaude$Idade)
help(hist)
hist_idade_m <- hist(msaude$Idade)
tb_idade_m <- tab1(cut(msaude$Idade, breaks = hist_idade_m$breaks))

hist_peso_m <- hist(msaude$Peso)
tb_peso_m <- tab1(cut(msaude$Peso, breaks = hist_peso_m$breaks))

hist_alt_m <- hist(msaude$ALT)
tb_altura_m <- tab1(cut(msaude$ALT, breaks = hist_alt_m$breaks))
#====================================================================

#=========================CRIACAO DE TABELA D FREQUENCIA FEMININA
hist(fsaude$Idade)
hist_idade_f <- hist(fsaude$Idade)
tb_idade_f <- tab1(cut(fsaude$Idade, breaks = hist_idade_f$breaks))

hist_peso_f <- hist(fsaude$Peso)
tb_peso_f <- tab1(cut(fsaude$Peso, breaks = hist_peso_f$breaks))

hist_alt_f <- hist(fsaude$ALT)
tb_altura <- tab1(cut(fsaude$ALT, breaks = hist_alt_f$breaks))
tb_altura
#medias de homens e mulheres sao iguais
#====================================================================
help("pairs")
shapiro.qqnorm(fsaude$Idade)
t.test(fsaude$Idade, msaude$Idade, alternative = "two.sided")
cor(fsaude$ALT, msaude$ALT )

variaveis <- c("CINT", "TXPUL", "SIST", "DIAST", "COL", "Pulso", "Braco")
correlacao <- c()
length(variaveis)
par(mfrow=c(1,1))
for( i in 1:length(variaveis)){
  variavel <- paste("msaude$",variaveis[i], sep = "")
  x <- eval(parse(text=paste("msaude$",variaveis[i], sep = "")))
  print(variavel)
  correlacao[i] = cor(msaude$Peso, x)
}
correlacao
pairs(msaude[,c(4:9,13:14)])

#==CORRELACAO ENTRE AS VARIAVEIS E AFIRMADO POR PESO A PARTIR DE CINT E BRACO

correlacao[5]
#coeficiente de regressao homesns
coeficiente_de_regressao <- lm(CINT ~ Peso, data=msaude)
predict(coeficiente_de_regressao, data.frame(Peso=c(200)))


#coeficiente de regressao mulheres
coeficiente_de_regressao_mulheres <- lm(CINT ~ Peso, data=fsaude)
predict(coeficiente_de_regressao_mulheres, data.frame(Peso=c(155)))
#======================================================================= PROPORCAO
media_h_col <- mean(msaude$COL)
media_f_col <- mean(fsaude$COL)
help("prop.test")

m_saude_maior_240 <- filter(msaude, msaude$COL > 240)
f_saude_maior_240 <- filter(fsaude, fsaude$COL > 240)
prop.test(n=c(length(msaude$COL), length(fsaude$COL)), x=c(length(m_saude_maior_240$COL), length(f_saude_maior_240$COL)), 
          alternative="two.sided" )

#=======================================================================MEDICAO DE PRESSAO HISTOLICA
m_saude_idade_maior <- filter(msaude, msaude$Idade > 40)
f_saude_idade_maior <- filter(fsaude, fsaude$Idade > 40)

t.test(m_saude_idade_maior$SIST, f_saude_idade_maior$SIST, alternative = "two.side")
t.test(m_saude_idade_maior$DIAST, f_saude_idade_maior$DIAST, alternative = "two.side")
#===================================================================


