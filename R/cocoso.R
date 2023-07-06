#' Implementation of CoCoSo Method
#'
#' @param md_data Must be a data frame with information about Criteria, Alternatives and Optimal Value. See example_cocoso.
#' @param parameter_alpha Parameter for third aggregation strategies.
#'
#' @usage cocoso(md_data, parameter_alpha = 0.5)
#'
#' @return Final ranking of all alternatives from CoCoSo method. In addition, we compute and present all three aggregation strategies.
#' @export
#'
#' @examples data(example_cocoso)
#' cocoso(example_cocoso)
#'

cocoso<-function(md_data, parameter_alpha = 0.5){

###  Validation: Missing, NA, Character, data.frame
  if (missing(md_data)){ return("Parameter md_data is missing.")}

  if( sum(is.na(md_data)) != 0 ){ return("Error: Data md_data have NA.") }

  format_ok <- check_input_data_cocoso(md_data)
  if (is.character(format_ok)){  return(format_ok)  }


  ###  Information from md_data
  alternativas<- md_data[ c(-1,-2,-3) ,1]      # Alternatives
  col_exemp<- as.character( md_data[1,-1])     # Names of criteria
  pesos_exemp<- as.numeric( md_data[2,-1])     # Weight
  min_max_exemp<- as.character( md_data[3,-1]) # Minimization and Maximization information
  matriz_decisao_exemp<- as.matrix(md_data[c(-1,-2,-3),-1], col.names = NULL) ; matriz_decisao_exemp <- data.frame(apply(matriz_decisao_exemp, 2, function(x) as.numeric(as.character(x))))


  ### Decision-Matrix, Weight, Min_Max information
  matriz_decisao<- matriz_decisao_exemp
  pesos<- pesos_exemp
  min_max<- min_max_exemp


  ### 0)  Padronization of data
  md_padrao<- standard_cocoso(matriz_decisao)



  ### 1)  Normalization
  maximos<- apply(md_padrao, 2, max, na.rm=TRUE)
  max_01<- as.numeric(tolower(min_max) == "max")

  minimos<- apply(md_padrao, 2, min, na.rm=TRUE)
  min_01<- as.numeric(tolower(min_max) == "min")

  aux_matriz_norm<- matrix(data = (max_01*minimos) + (min_01*maximos) , nrow = dim(md_padrao)[1], ncol = dim(md_padrao)[2], byrow = T )
  mc.normal<- t( t( (abs(aux_matriz_norm- md_padrao)) )/ ( maximos - minimos  ) )



  ### 2)  Weight’s Sum and Power:  Si and Pi
  Si<- rowSums( mc.normal%*%pesos)
  Pi<- rowSums( t( t(mc.normal)^pesos ) )



  ### 3)  Aggregation strategies kia,  kib and kic
  param_alpha<- parameter_alpha
  ki_a<- ( Pi + Si )/( sum(Pi + Si) )
  ki_b<- Si/( min(Si) ) + Pi/( min(Pi) )
  ki_c<- (param_alpha*Si  +(1-param_alpha)*Pi)/( param_alpha*( max(Si) )  + (1 -param_alpha)*( max(Pi) )  )


  ### 4)  Final Ranking
  k_final<-  ( ki_a*ki_b*ki_c  )^(1/3) + (1/3)*(  ki_a + ki_b + ki_c)
  ordem<- order(k_final, decreasing = T)

  #  Results
  resultado<- data.frame( Alternatives = alternativas, Order = order(ordem, decreasing = F), k = k_final, ki_a = ki_a, ki_b, ki_c = ki_c, Si = Si, Pi = Pi ) ; names(resultado)[1]<- "Alternatives"

return(resultado)
}


