
#' Test with JSON
#' @param ScienceDirect search query string
#' 
#' Load libraries & execute code manually
#' 
#' library(httr)
#' library(jsonlite)
#'
#' @import httr
#' @import jsonlite
ScienceDirect_SearchJson <- function(query){

  query <- list(query = "genom", apiKey = "api")
  searchSci <- "http://api.elsevier.com:80/content/search/scidir"

  return_request <- GET(searchSci, query = query)
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  json_response <- fromJSON(text_response)
  df_search <- data.frame(json_response$`search-results`$entry)
  
  return(json_response)

}



#' Test with XML
#' @param ScienceDirect search query string
#'
#' library(xml2)
#' library(XML)
#' 
#' @import httr
#' @import xml2
#' @import XML
ScienceDirect_SearchXML <- function(query){
  
  query <- list(query = "genom", apiKey = "5b4c22442fdb5685587b566c7de8a567")
  searchSci <- "http://api.elsevier.com:80/content/search/scidir"
  
  return_request <- GET(searchSci, query = query, accept("application/xml"))
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  
  #XML
  xmlBig <- xmlTreeParse(text_response, asText=TRUE)
  xmlBig <- xmlToList(xmlBig)
  # https://stackoverflow.com/questions/17198658/how-to-parse-xml-to-r-data-frame
  xmlBig2 <- xmlToDataFrame(xmlBig)
  #xml2
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
  
  query <- list(doi = "10.1016/S0014-5793(01)03313-0", apiKey = "5b4c22442fdb5685587b566c7de8a567")
  searchSci <- "http://api.elsevier.com:80/content/abstract/citation-count"
  
  return_request <- GET(searchSci, query = query)
  stop_for_status(return_request)
  text_response <- content(return_request, as = "text")
  json_response <- fromJSON(text_response)
  return(json_response)
  
}

















