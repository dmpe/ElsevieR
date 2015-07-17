#' @title Cited by in Scopus
#' 
#' @description With Scopus Abstract Citation Count API you want to show the 
#' number of times the papers have been cited by other papers covered by Scopus.
#' 
#' @seealso \url{http://dev.elsevier.com/tecdoc_cited_by_in_scopus.html}
#' @seealso \url{http://api.elsevier.com/documentation/AbstractCitationCountAPI.wadl}
#' 
#' @examples 
#' citation_count(doi ="10.1016/S0014-5793(01)03313-0")
#'
#' @import httr
#' @import jsonlite 
#' 
#' @export
citation_count <- function(doi, apiKey = auth_key(NULL), showFull = TRUE){
  
  searchSci <- "http://api.elsevier.com/content/abstract/citation-count"
  citationCountURL <- "http://api.elsevier.com/content/search/index:SCOPUSquery="
  
  if (showFull == TRUE) {
    query <- list(doi = doi, apiKey = apiKey, field = "citedby-count")
    return_request <- GET(citationCountURL, query = query)
  } else {
    query <- list(doi, apiKey = apiKey)
    return_request <- GET(citationCountURL, query = query, )
  }
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  json_response <- fromJSON(text_response)
  return(json_response)
  
}
