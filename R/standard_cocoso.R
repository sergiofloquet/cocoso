#' Padronization of decision-making matriz by sum.
#'
#' @param md_data Decision-making matrix.
#'
#' @usage standard_cocoso(md_data)
#'
#' @return A Decision-making matrix normalize.
#' @export
#'
#' @examples standard_cocoso(mtcars)

standard_cocoso<- function(md_data){

  ###  Validation: Missing, NA, Character, data.frame
  if (missing(md_data)){ return("Parameter md_data is missing.")}
  if( sum(is.na(md_data)) != 0 ){ return("Error: Data md_data have NA.") }

  md_data <- data.frame(apply(md_data, 2, function(x) as.numeric(as.character(x))))
  if ( sum(is.na(md_data)) != 0 ){ return("Error: Data md_data must have decision matrix numeric.")   }

  soma<- apply(md_data, 2, sum, na.rm=TRUE)
  md_padrao<- t( t(md_data)/soma )
  return(md_padrao)}
