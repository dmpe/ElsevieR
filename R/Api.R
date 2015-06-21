elsevier_api_auth_token <- NA

#' @title Assign Elsevier API token
#'
#' @param auth_token - Passed parameter to set Bit.ly Generic Access Token \code{\link{elsevierApi}}.
#'
#' @seealso See \url{http://dev.elsevier.com/myapikey.html}
#'
#' @examples
#' elsevierApi("7f5eff1eb026d6dff5574fc165e297ee")
#'
#' @export
elsevierApi <- function(auth_token) {
  if (!missing(auth_token)) {
    assignInMyNamespace('elsevier_api_auth_token', auth_token)
  }
  invisible(elsevier_api_auth_token)
}


#' @title Generalized function for executing GET requests by always appending user's Bit.ly API Key.
#'
#' @param url - which is used for the request
#' @param authcode - calls the elsevierApi \code{\link{elsevierApi}}
#' @param queryParameters - parameters that are used for building a URL
#' @param showURL - for debugging purposes only: it shows what URL has been called
#'
#' @import httr
#' @import jsonlite
#'
#' @noRd
doRequest <- function(url, queryParameters = NULL, auth_code = elsevierApi(), showURL = NULL) {

  if (is.na(auth_code)) {
    # actually unnecessary; flawn logic because queryParameters will always contain API Key.
    # Yet for making sure that the user has set it, I'll let it go
    stop("Please assign your API Key ('Generic Access Token') ")
  } else {

    return_request <- GET(url, query = queryParameters)
    stop_for_status(return_request)
    text_response <- content(return_request, as = "text")
    json_response <- fromJSON(text_response)

    if (identical(showURL, TRUE)) {
      cat("The requested URL has been this: ", as.character(return_request$request$opts$url), "\n")
    }
    return(json_response)
  }

}


