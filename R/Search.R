
#' Test with JSON
#' @param ScienceDirect search query string
#'
#'
#' @import httr
#' @import jsonlite
ScienceDirect_SearchJson <- function(query){

  query <- list(query = "genom", apiKey = "7f5eff1eb026d6dff5574fc165e297ee")
  searchSci <- "http://api.elsevier.com:80/content/search/scidir"

  return_request <- GET(searchSci, query = query)
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  json_response <- fromJSON(text_response)
  return(json_response)

}



#' Test with XML
#' @param ScienceDirect search query string
#'
#'
#' @import httr
#' @import xml2
ScienceDirect_SearchXML <- function(query){
  
  query <- list(query = "genom", apiKey = "7f5eff1eb026d6dff5574fc165e297ee")
  searchSci <- "http://api.elsevier.com:80/content/search/scidir"
  
  return_request <- GET(searchSci, query = query, accept("application/xml"))
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  xml_response <- read_xml(text_response)
  return(xml_response)
#   head(xml_structure(xml_response),1)
  
}



#' Test with JSON
#' @param ScienceDirect search query string
#'
#'
#' @import httr
#' @import jsonlite
Citations_Overview_Json <- function(query){
  
  query <- list(doi = "10.1016/S0014-5793(01)03313-0", apiKey = "7f5eff1eb026d6dff5574fc165e297ee")
  searchSci <- "http://api.elsevier.com:80/content/abstract/citation-count"
  
  return_request <- GET(searchSci, query = query)
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  json_response <- fromJSON(text_response)
  return(json_response)
  
}

















