#' Test with JSON
#' @param ScienceDirect search query string
#' 
#' @seealso See \url{http://dev.elsevier.com/api_key_settings.html}
#' http://dev.elsevier.com/tecdoc_api_authentication.html
#' Load libraries & execute code manually
#' 
#' @import httr
#' @import jsonlite
ScienceDirect_SearchJson <- function(query){

  query <- list(query = "genom", apiKey = decrypt("ElsevierR_APIKey")$key)
  searchSci <- "http://api.elsevier.com:80/content/search/scidir"

  return_request <- GET(searchSci, query = query)
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  json_response <- fromJSON(text_response)
  df_search <- data.frame(json_response$`search-results`$entry)
  
  return(json_response)

}


# 
# #' Test with XML
# #' @param ScienceDirect search query string
# #' 
# #' @import httr
# 
# ScienceDirect_SearchXML <- function(query){
#   
#   query <- list(query = "genom", apiKey = decrypt("ElsevierR_APIKey")$key)
#   searchSci <- "http://api.elsevier.com:80/content/search/scidir"
#   
#   return_request <- GET(searchSci, query = query, accept("application/xml"))
#   stop_for_status(return_request)
#   text_response <- content(return_request, as = "text")
#   
#   #XML
#   xmlBig <- xmlTreeParse(text_response, asText=TRUE)
#   xmlBig <- xmlToList(xmlBig)
#   # https://stackoverflow.com/questions/17198658/how-to-parse-xml-to-r-data-frame
#   xmlBig2 <- xmlToDataFrame(xmlBig)
#   #xml2
#   xml_response <- read_xml(text_response)
#   return(xml_response)
# #   head(xml_structure(xml_response),1)
#   
# }
# 
# 
# 
# 
# #' citations_overview(documentIdentifier = "doi", query = "10.1016/S0014-5793(01)03313-0")
# #' @description Abstract Citation API allows to retrieve citations given one of the document identifiers (DOI, PII, scopus_id or pubmed_id).
# citations_overview <- function(documentIdentifier = c("doi", "scopus_id", "pubmed_id", "pii"), query, apiKey = auth_key(NULL), httpAccept="application/json") {
#   
#   url <- "http://api.elsevier.com/content/abstract/citations"
#   
#   queryParams <- list(documentIdentifier = asdas, apiKey = apiKey, httpAccept = httpAccept )
#   queryParams
# }
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
