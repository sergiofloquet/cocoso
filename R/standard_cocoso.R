#' Padronization of decision-making matriz by sum.
#'
#' @param md_data Decision-making matrix.
#'
#' @return A Decision-making matrix normalize.
#' @export
#'
#' @examples standard_cocoso(mtcars)

standard_cocoso<- function(md_data){
  soma<- apply(md_data, 2, sum, na.rm=TRUE)
  md_padrao<- t( t(md_data)/soma )
  return(md_padrao)}
