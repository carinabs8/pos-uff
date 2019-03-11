require(dplyr)
require(DescTools)
library(ggplot2)
library(readr)
winemag <- read_csv("Desktop/pos/2 periodo/trabalho7/winemag.csv")
#View(winemag_prices_ordering)
#vinhos ordenados por valor
winemag_prices <- filter(winemag, winemag$price != 'NA')
winemag_prices_ordering <- arrange(winemag_prices, desc(price))
hist(winemag_prices_ordering$price, probability = T)
lines(density(winemag_prices_ordering$price))
qplot(price, country, data=winemag_prices_ordering)

#Vinhos franceses mais caros 
vinhos_franceses <- filter(winemag, country == "France", price != 'NA')
vinhos_franceses_por_viniculas <- group_by(vinhos_franceses, variety)
arrange(vinhos_franceses_por_viniculas %>%summarize(total=max(price)), desc(total))
qplot(price, variety, data=vinhos_franceses_por_viniculas)

#vinhos por pontuacao
by_country_and_winery_grouped <- group_by(winemag_prices, country, winery)
by_variaty_and_country_summarized <- by_country_and_winery_grouped %>%summarize(pontuacao_geral=sum(points))
#by_variaty_and_country_summarized <- arrange(by_variaty_and_country_summarized, desc(pontuacao_geral))
qplot(pontuacao_geral, country, data=by_variaty_and_country_summarized)

#valor X qualidade

plot(winemag_prices$points, winemag_prices$price, xlab = "Qualidade", ylab = "Preço")

par(mfrow = c(2,2))
#vinhos agrupados por variedade X preco
by_variaty_grouped <- group_by(winemag_prices, variety)
by_variaty_grouped <- by_variaty_grouped%>% summarize(media_por_preco=mean(price), media_por_avaliacao=mean(points), quantidade_de_viniculas=n())
#View(arrange(by_variaty_grouped, desc(media_por_preco)))
vetor <- factor(by_variaty_grouped$variety, ordered=FALSE)
qplot(media_por_avaliacao, media_por_preco, data=by_variaty_grouped, xlab="Média por avaliação", ylab = "Média por preço", geom=c("point", "smooth"), colour=vetor, main="Media por avaliação e preço por vinículas")

#vinhos agrupados por variedade X pais X preco
by_variaty_and_country_grouped <- group_by(winemag_prices, country, variety)
by_variaty_and_country_grouped <- by_variaty_and_country_grouped%>% summarize(media_por_preco=mean(price), media_por_avaliacao=mean(points), quantidade_de_viniculas=n())
#View(arrange(by_variaty_and_country_grouped, desc(media_por_preco)))
qplot(media_por_avaliacao, media_por_preco, data=by_variaty_and_country_grouped, xlab="Média por avaliação", ylab = "Média por preço", geom=c("point", "smooth"), colour=factor(country, ordered=FALSE) ,main="Media por avaliação e preço por vinículas de um determinado país")
