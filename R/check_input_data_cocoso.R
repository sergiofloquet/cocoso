#' Verify if the dataset to be submitted to cocoso function is correctly formatted.
#'
#' @param md_data Must be a data frame with information about Criteria, Alternatives and Optimal Value. See example_cocoso.
#'
#' @usage check_input_data_cocoso(md_data)
#'
#' @return True if the dataset is correctly formatted and False otherwise.
#' @export
#'
#' @examples data(example_cocoso)
#' check_input_data_cocoso(example_cocoso)

check_input_data_cocoso<- function(md_data){

  ###  Validation: Missing, NA and data.frame
  if (missing(md_data)){ return("Parameter md_data is missing.") }
  if( sum(is.na(md_data)) != 0 ){ return("Error: Data md_data have NA.") }


  ###  Information from md_data
  # Weight must be 1
  pesos_exemp<- as.numeric( md_data[2,-1])     # Weight
  if( sum( pesos_exemp ) != 1 ){ return("Error: Sum of weight must be 1.") }

  # Optimal must be Min or Max
  min_max_data<- as.character( md_data[3,-1])
  aux_mm<- as.numeric(tolower(min_max_data) == "max") + as.numeric(tolower(min_max_data) == "min")
  if ( length(aux_mm) != sum(aux_mm) ){ return("Error: Data md_data must have Min or Max.")  }

  # Decision Matrix must be numeric
  matriz_decisao_data<- as.matrix(md_data[c(-1,-2,-3),-1], col.names = NULL) ; matriz_decisao_data <- data.frame(apply(matriz_decisao_data, 2, function(x) as.numeric(as.character(x))))
  if ( sum(is.na(matriz_decisao_data)) != 0 ){ return("Error: Data md_data must have decision matrix numeric.")   }

return(TRUE)
}

