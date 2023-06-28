####  Skectch of Package
library(devtools)




###   Gera um novo arquivo r para construir funcoes
#use_r("standard_cocoso")
#use_r("cocoso")
#use_r("check_input_data_cocoso")

###   Gera a Licenca
#use_gpl_license(version = 2, include_future = TRUE) #use_gpl3_license() ; use_mit_license()

###   Salva os dados
#library(readxl) ; example_cocoso<- read_excel(path =  "~/Dropbox/Unicamp/Tomada de Decisao - UFF/cocoso - Metodo/www/exemplo1.xlsx", col_names = F) ; example_cocoso
#example_cocoso<- as.data.frame( example_cocoso) ; colnames(example_cocoso)<-NULL
#use_data(example_cocoso)

citation(package = "cocosoR")
###  Documentar os dados
#use_r("example_cocoso")

### Vignette do pacote
#use_vignette("Intro_to_CoCoSo", title = "Introduction to CoCoSo")


###  Fazendo varios testes
#use_testthat()
#use_test()
#cocoso(example_cocoso)

###  Subindo para o GitHub

use_citation()
install_github(repo = "sergiofloquet/cocosoR")


#waspasR()
### Testanto a funcao
#library(roxygen2)
#roxygenise();

#data("example_cocoso")

###  Testando se e data.frame
#  df_test<- NA ; try( df_test<- as.data.frame(md_data, row.names = F) , silent = T)
#  if( sum(is.na(df_test)) != 0 ){ return("Error: Data md_data must be a Data Frame.") }




