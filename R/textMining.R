#' Text Mining methods
#'
#' @seealso See \url{http://dev.elsevier.com/tecdoc_text_mining.html}
#'
#' @description Also there is the option to pass in an 'Accept' parameter that allows you to specify 
#' whether you want the full XML version (with the full-text containing Elsevier's DTD markup in 
#' all its glory) or a 'simplified' document which contains a structured metadata 'header' and the 
#' body of the text itself as one big UTF-8 string, without markup. By default (as implied by the 
#' previous point), the response is the full-text XML.
#' 
#' @note For text mining purposes, we have exposed an XML version of this sitemap on: 
#' \url{http://api.elsevier.com/sitemap/page/sitemap/index.html}. The sitemap doesn't know about 
#' your subscriptions and therefore may list URLs for documents you don't have access to. This will 
#' lead to an authorization error if you try to retrieve such a document, and your crawling script 
#' will have to be able to handle that error.
#'
#' @import wordcloud
#' @import tm
#'  
#' @examples 
#' textM()
#'
#'
#' @export
textM <- function(isnn, apiKey = auth_key(NULL), view = "FULL", showRequestURL = F) {
  
}
