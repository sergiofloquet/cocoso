
###############
###################################   Metodo CoCoSo
###############


### Pacotes Utilizados
rm(list = ls()) ; setwd("~/Dropbox/Unicamp/Tomada de Decisao - UFF/cocoso - Metodo/") ; library(vroom) ; library(readxl) ; library(openxlsx); #library(xlsx) ;
#exemplo<- read.csv(file = "www/exemplo1.csv", header = F, sep = "," , dec = ".")
exemplo <- vroom::vroom(file = "www/exemplo1.csv", delim = ",", locale = locale(decimal_mark = ".") )



### Entrada: Exemplos dos artigos
# Exemplo da Tabela 1
#rm(list = ls()) ; exemplo<- read_excel(path = "cocoso - Metodo/tabela1.xlsx", col_names = F) ; exemplo
#rm(list = ls()) ; exemplo<- read.csv(file = "www/exemplo1.csv", header = F, sep = "," , dec = ".")
rm(list = ls()) ; exemplo <- vroom::vroom(file = "www/exemplo1.csv", delim = ",", locale = locale(decimal_mark = "."), col_names = F )
alternativas<- exemplo[ c(-1,-2,-3) ,1]
col_exemp<- as.character( exemplo[1,-1]) # Nome dos Criterios
pesos_exemp<- as.numeric( exemplo[2,-1]) ; sum(pesos_exemp) # Pesos
min_max_exemp<- as.character( exemplo[3,-1])
matriz_decisao_exemp<- as.matrix(exemplo[c(-1,-2,-3),-1]) ; matriz_decisao_exemp <- data.frame(apply(matriz_decisao_exemp, 2, function(x) as.numeric(as.character(x))))




# Exemplo da Tabela 11
rm(list = ls()) ; exemplo<- read.xlsx(file = "www/exemplo1.xlsx", col_names = F, sheetIndex = 1) ; exemplo
rm(list = ls()) ; exemplo<- read_excel(path = "www/exemplo1.xlsx", col_names = F) ; exemplo
rm(list = ls()) ; exemplo<- read.csv(file = "www/exemplo2.csv", header = F, sep = "," , dec = ".")
rm(list = ls()) ; exemplo <- vroom::vroom(file = "www/exemplo2.csv", delim = ",", locale = locale(decimal_mark = "."), col_names = F  )
alternativas<- exemplo[ c(-1,-2,-3) ,1]
col_exemp<- as.character( exemplo[1,-1]) # Nome dos Criterios
pesos_exemp<- as.numeric( exemplo[2,-1]) ; sum(pesos_exemp) # Pesos
min_max_exemp<- as.character( exemplo[3,-1])
matriz_decisao_exemp<- as.matrix(exemplo[c(-1,-2,-3),-1], col.names = NULL) ; matriz_decisao_exemp <- data.frame(apply(matriz_decisao_exemp, 2, function(x) as.numeric(as.character(x))))



### Entradas
matriz.decisao<- matriz_decisao_exemp
pesos<- pesos_exemp
min.max<- min_max_exemp


### 0)  Padronizacao pela soma dos valores
soma<- apply(matriz.decisao, 2, sum, na.rm=TRUE) ; soma
md.padrao<- t( t(matriz.decisao)/soma ) ; md.padrao # Divisao por linha, por isso tomei o transposto
#rm(matriz.decisao)


### 1)  Normalizacao pelo Maximo ou Minimo, dependendo do criterio de lucro ou custo respectivamente
maximos<- apply(md.padrao, 2, max, na.rm=TRUE) ; maximos
max_01<- as.numeric(tolower(min.max) == "max")

minimos<- apply(md.padrao, 2, min, na.rm=TRUE) ; minimos
min_01<- as.numeric(tolower(min.max) == "min")

aux_matriz_norm<- matrix(data = (max_01*minimos) + (min_01*maximos) , nrow = dim(md.padrao)[1], ncol = dim(md.padrao)[2], byrow = T ) # Se for lucro usa o minimo ; se for custo usa o maximo
mc.normal<- t( t( (abs(aux_matriz_norm- md.padrao)) )/ ( maximos - minimos  ) ) ; mc.normal # Divisao por linha, por isso tomei o transposto
#write.table(file = "1normalizada.csv", x = round( mc.normal, 4), row.names = T, dec = ",", sep = ";")


### 2)  Calculando os pesos:  Si para a soma e Pi para o produto
Si<- rowSums( mc.normal%*%pesos)
Pi<- rowSums( t( t(mc.normal)^pesos ) )



### 3)  Calculando os kia,  kib  e kic
param_alpha<- 0.5
ki_a<- ( Pi + Si )/( sum(Pi + Si) )
ki_b<- Si/( min(Si) ) + Pi/( min(Pi) )
ki_c<- (param_alpha*Si  +(1-param_alpha)*Pi)/( param_alpha*( max(Si) )  + (1 -param_alpha)*( max(Pi) )  )


### 4)  Calculando o k_final
k_final<-  ( ki_a*ki_b*ki_c  )^(1/3) + (1/3)*(  ki_a + ki_b + ki_c)
ordem<- order(k_final, decreasing = T)

#  Exportando os resultados
#resultado<- data.frame( Ordem = 1:length(k_final), Alternativas = alternativas[ ordem,1 ],  Si = Si[ordem], Pi = Pi[ordem], ki_a = ki_a[ordem], ki_b = ki_b[ordem], ki_c = ki_c[ordem], k = k_final[ordem]  ) ; names(resultado)[2]<- "Alternativas"
resultado<- data.frame( Ordem = order(ordem, decreasing = F), Alternativas = alternativas,  Si = Si, Pi = Pi, ki_a = ki_a, ki_b, ki_c = ki_c, k = k_final  ) ; names(resultado)[2]<- "Alternativas"


#write.table(file = "5resultado.csv", x = data.frame(Ordenacao = names(resul), Resultado = round(resul, 4) ) , row.names = T, dec = ",", sep = ";")

rm(list = ls()) ; exemplo<- read_excel(path = "www/exemplo1.xlsx", col_names = F) ; exemplo
write.xlsx(x = exemplo, file = "~/Downloads/exemplo_teste.xlsx" ,col_names = F, sheetName="Exemple1")



