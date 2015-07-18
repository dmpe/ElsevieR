#' @title Retrieving Scopus Cited-By counts
#' 
#' @description With Scopus Abstract Citation Count API you want to show the 
#' number of times the papers have been cited by other papers covered by Scopus.
#' 
#' @seealso \url{http://dev.elsevier.com/tecdoc_cited_by_in_scopus.html}
#' 
#' @section TODO :
#' You can use OR statements in the 'query' field of the URL to get the cited-by counts for multiple documents in one go - e.g.:
#' http://api.elsevier.com/content/search/index:SCOPUS?query=DOI(10.1016/j.stem.2011.10.002)+OR+DOI(10.1098/rsbl.2011.0293)&field=citedby-count,prism:doi 
#' This example uses both 'citedby-count' and 'prism:doi' as a value for the 'field' parameter. This tells the API to return 
#' the DOI for every cited-by count in the response, which will allow you to map the cited-by counts to the DOIs you passed into my request. 
#' 
#' @note Beware: The format must be this "DOI(...)", "PMID(22136928)", "SCP(82755170946)" etc.
#' 
#' @examples 
#' citation_count_scopus(value = "DOI(10.1016/S0014-5793(01)03313-0)")
#' citation_count_scopus(value = "DOI(10.1016/j.stem.2011.10.002) OR DOI(10.1098/rsbl.2011.0293)", fields = "citedby-count,prism:doi")
#' 
#' @export
citation_count_scopus <- function(value, apiKey = auth_key(NULL), fields = "citedby-count", showRequestURL = FALSE){
  
  citationCountURL <- "http://api.elsevier.com/content/search/index:SCOPUS"
  
  query <- list(query = value, apiKey = apiKey, field = fields)
  return_request <- doRequest(citationCountURL, query = query, showURL = showRequestURL)
  
  # we request that wherever you show them, you have to attribute and link back to the cited-by list on Scopus - something like "Cited x times in Scopus"
  citedByScopusString <- cat("Cited", return_request$`search-results`$entry$`citedby-count`, "times in Scopus")
  
  return(citedByScopusString)
}

#   searchSci <- "http://api.elsevier.com/content/abstract/citation-count"
#' ## @seealso \url{http://api.elsevier.com/documentation/AbstractCitationCountAPI.wadl}
