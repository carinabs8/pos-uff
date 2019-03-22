#install.packages("tidyverse")
require(DescTools)
require(tidyverse)
library(ggplot2)
setwd("~/Desktop/pos/2 periodo/trabalho7")
estabelecer_conexao_com_bd <- function(user, password){
  #install.packages('RPostgreSQL', repos='http://cran.rstudio.com/')
  #install.packages('RODBC', repos='http://cran.rstudio.com/')
  library(DBI)
  library(dplyr)
  library(dbplyr)
  library(odbc)
  DBI::dbConnect(
    RPostgreSQL::PostgreSQL(), 
    host = "localhost",
    dbname = "pos",
    user = "carinabs8",
    password = "abc,123",
    port = 5432
  )
}
conn <- estabelecer_conexao_com_bd("carinabs8", "abc,123")
winemag <- tbl(conn, "winemag")

#vinhos ordenados por valor
winemag_prices <- dbGetQuery(conn, "select  price, country from winemag where price is not null ORDER BY price DESC;")
hist(winemag_prices$price, probability = T)
lines(density(winemag_prices$price))
qplot(price, country, data=winemag_prices)

#Vinhos franceses mais caros 
vinhos_franceses <- filter(winemag, country == "France", price != 'NA')
vinhos_franceses_por_viniculas <- group_by(vinhos_franceses, variety)
arrange(vinhos_franceses_por_viniculas %>%summarize(total=max(price)), desc(total))
qplot(price, variety, data=distinct(vinhos_franceses_por_viniculas))

#vinhos por pontuacao
by_country_and_winery_grouped <- dbGetQuery(conn, "select country, winery, SUM(CAST(points AS DECIMAL)) AS pontuacao_geral from winemag where points ~ '^[0-9]+$' group by country, winery ORDER BY pontuacao_geral ASC")
qplot(pontuacao_geral, country, data=by_country_and_winery_grouped)

#valor X qualidade

plot(winemag_prices$points, winemag_prices$price, xlab = "Qualidade", ylab = "Preço")

par(mfrow = c(2,2))
#vinhos agrupados por variedade X preco
by_variaty_grouped <- dbGetQuery(conn, "SELECT variety, AVG(price) AS media_por_preco, AVG(CAST(points AS float)) AS media_por_avaliacao, COUNT(id) AS quantidade_de_viniculas FROM winemag WHERE points ~ '^[0-9]+$' AND price is not null GROUP BY variety")
View(arrange(by_variaty_grouped, desc(media_por_preco)))
#vetor <- factor(by_variaty_grouped$variety, ordered=TRUE)
ggplot(by_variaty_grouped, xlab="Média por avaliação", ylab = "Média por preço",
      geom=c("point", "smooth"),
      aes(x=media_por_avaliacao, y=media_por_preco, color=by_variaty_grouped$variety),
      main="Media por avaliação e preço por vinículas") + geom_point() +
      theme(legend.position="bottom") + guides(fill=guide_legend(nrow=6, byrow=TRUE))

#vinhos agrupados por variedade X pais X preco
by_variaty_and_country_grouped <- group_by(winemag_prices, country, variety)
by_variaty_and_country_grouped <- by_variaty_and_country_grouped%>% summarize(media_por_preco=mean(price), media_por_avaliacao=mean(points), quantidade_de_viniculas=n())
#View(arrange(by_variaty_and_country_grouped, desc(media_por_preco)))
qplot(media_por_avaliacao, media_por_preco, data=by_variaty_and_country_grouped, 
      xlab="Média por avaliação", ylab = "Média por preço", geom=c("point", "smooth"), 
      colour=factor(country, ordered=FALSE),
      main="Media por avaliação e preço por vinículas de um determinado país")

#por ano
winemag_year <- mutate(winemag_prices, year=as.numeric(str_extract(winemag_prices$title, "(20[0-9]{2})"))) %>%
    filter(ano != "NA") %>% 
    group_by(year, country) %>% summarize(media_por_preco=mean(price), n()) 
View(winemag_year)

#podemos dizer que o preco é interferido pelo ano??
shapiro.test(winemag_year$media_por_preco)
cor(winemag_year$year, winemag_year$media_por_preco, method="spearman")
winemag_year$year

qplot(year, media_por_preco, data=winemag_year, 
      xlab="Média de preco", ylab = "Média anos", geom=c("point", "smooth"), 
      colour=factor(year),
      main="Media de preço por anos")+
      theme(legend.position="bottom", title = "") + guides(fill=guide_legend(nrow=6, byrow=TRUE))

