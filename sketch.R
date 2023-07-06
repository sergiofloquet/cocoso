####  Skectch of Package
library(devtools)

# Comments for submit the package
# The Combined Compromise Solution Method (CoCoSo), proposed by Yazdani et al. (2019) <https://doi.org/10.1108/MD-05-2017-0458> is a new method for Multi-Criteria Decision Analysis(MCDA) and have more that 440 citation. This package is the first implementation of this method in R.


#use_github_pages
#use_github_links
###   Gera um novo arquivo r para construir funcoes
#use_r("standard_cocoso")
#use_r("cocoso")
#use_r("check_input_data_cocoso")

###   Gera a Licenca
#use_gpl_license(version = 3, include_future = TRUE) #use_gpl3_license() ; use_mit_license()

###   Salva os dados
#library(readxl) ; example_cocoso<- read_excel(path =  "~/Dropbox/Unicamp/Tomada de Decisao - UFF/cocoso - Metodo/www/exemplo1.xlsx", col_names = F) ; example_cocoso
#example_cocoso<- as.data.frame( example_cocoso) ; colnames(example_cocoso)<-NULL
#use_data(example_cocoso)

#citation(package = "cocosoR")
###  Documentar os dados
#use_r("example_cocoso")

### Vignette do pacote
#use_vignette("Intro_to_CoCoSo", title = "Introduction to CoCoSo")


###
#use_description(fields = list(Language = "en-US"))



###  Fazendo varios testes
#use_testthat()
#use_test()
#cocoso(example_cocoso)

###  Construindo Manual
#build_manual()


###  Construindo o Readme
#use_readme_rmd()
#build_readme()

###  Subindo para o GitHub
#use_citation()
#install_github(repo = "sergiofloquet/cocosoR", subdir = )


#waspasR()
### Testanto a funcao
#library(roxygen2)
#roxygenise();

#data("example_cocoso")

###  Testando se e data.frame
#  df_test<- NA ; try( df_test<- as.data.frame(md_data, row.names = F) , silent = T)
#  if( sum(is.na(df_test)) != 0 ){ return("Error: Data md_data must be a Data Frame.") }

#data(example_cocoso)
example_cocoso
standard_cocoso(md_data = example_cocoso[-c(1,2,3), -1]  )
cocoso(example_cocoso)

ex_1<- example_cocoso[-c(1,2,3), -1]  ; ex_1[3,3]<- "c"
standard_cocoso(ex_1)

