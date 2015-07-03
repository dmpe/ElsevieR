elsevier_api_auth_token <- NA

#' @title Assign Elsevier API token
#'
#' @param auth_token - Passed parameter to set Bit.ly Generic Access Token \code{\link{elsevierApi}}.
#'
#' @seealso See \url{http://dev.elsevier.com/myapikey.html}
#'
#' @examples
#' elsevierApi("574fc165e297ee") ## invalid key
#'
#' @export
elsevierApi <- function(auth_token) {
  if (!missing(auth_token)) {
    assignInMyNamespace('elsevier_api_auth_token', auth_token)
  }
  invisible(elsevier_api_auth_token)
}


#' @seealso See \url{https://github.com/ropensci/rnoaa/blob/master/R/zzz.r#L145}
#' @seealso See \url{https://github.com/ropensci/gistr/blob/master/R/gist_auth.R#L24}
#' 
#' better api
check_key <- function(x){
  tmp <- if (is.null(x)) Sys.getenv("elsevier_api_auth_token", "") else x
  if (tmp == "") getOption("elsevier_api_auth_token", stop("need an Elsevier's API key")) else tmp
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
    stop("Please assign your API Key ('Generic Access Token') ", call. = FALSE)
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

#' @title This represents interfaces to create a secured authtoken.
#' 
#' @seealso See \url{http://api.elsevier.com/documentation/AuthenticationAPI.wadl}
#' 
#' @param httpAcpt - This represents the acceptable mime types for which the response can be generated.
#' @param authorization - This contains the OAuth bearer access token, where the format of the 
#' field is "<token>" (where the token represents the end-user session key). The presence of a bearer 
#' token implies the request will be executed against user-based entitlements. This token can also be 
#' submitted through the HTTP header "Authorization" or the query string parameter "access_token".
#' @param insttoken - This represents a institution token. If provided, this key (in combination 
#' with its associated APIKey) is used to establish the credentials needed to access content in this resource.
#' @param apiKey - Override for HTTP header X-ELS-APIKey, this represents a unique application 
#' developer key providing access to resource.
#' 
#' @example 
#' auth_token(apiKey = decrypt("ElsevierR_APIKey")$key)
#' 
#' @import httr
#' @import jsonlite
#' @import secure
#'
#' @noRd
auth_token <- function(httpAcpt = "application/json", author = NULL, inst_token = NULL, apiKey = elsevierApi()) {
  
  url <- "http://api.elsevier.com/authenticate/"
  
  returnGEt <- GET(url, query = list(httpAccept = httpAcpt, access_token = author, insttoken = inst_token, apiKey = apiKey) )
  responseText <- content(returnGEt, as = "text")
  
  returnGEt$url
  
  cat(returnGEt$url)
  
}


