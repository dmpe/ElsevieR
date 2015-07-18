#' @title Assign Elsevier API tokens
#' 
#' @description There are two API Keys. One is for the access of almost everything, except for text-mining 
#' capabilities (Elsevier_API). Another one (Elsevier_TM_API) is only for the purpose of using text-mining
#' functionality. See URL for your restrictions below. The first one is always required whereas the 
#' second one is optional.
#' 
#' @param x - an empty parameter, e.g. NULL
#'
#' @seealso Register your Keys \url{http://dev.elsevier.com/myapikey.html}
#' @seealso See for restrictions which apply to your key \url{http://dev.elsevier.com/api_key_settings.html}
#' @seealso See \url{https://github.com/ropensci/rnoaa/blob/master/R/zzz.r#L145}
#' @seealso See \url{https://github.com/ropensci/gistr/blob/master/R/gist_auth.R#L24}
#' 
#' @examples 
#' options(Elsevier_API = "F1QH-Q64B-BSBI-JASJ", Elsevier_TM_API = "1QH-Q64B-BSBI-JAS")
#' 
#' @export
auth_key <- function(x) {
  tmp <- if(is.null(x)) {
    Sys.getenv("Elsevier_API", "")
  } else x
  
  if(tmp == "") {
    getOption("Elsevier_API", stop("you need to set up your Elsevier API Key"))
  } else tmp
}

#' @rdname auth_key
#' @export
auth_tm_key <- function(x) {
  tmp <- if(is.null(x)) {
    Sys.getenv("Elsevier_TM_API", "")
  } else x
  
  if(tmp == "") {
    getOption("Elsevier_TM_API",  stop("you need to set up your Elsevier Text-Mining API Key"))
  } else tmp
}

#' @title Generalized function for executing GET requests 
#'
#' @param url - which is used for the request
#' @param authcode - calls the elsevierApi \code{\link{auth_key}}
#' @param queryParameters - parameters that are used for building a URL
#' @param showURL - for debugging purposes only: it shows what URL has been called
#'
#' @import httr
#' @import jsonlite
#'
#' @noRd
doRequest <- function(url, queryParameters = NULL, apiKey = auth_key(NULL), 
                      apiKeyTM = auth_tm_key(NULL), showURL = NULL) {
  
  if ( (is.null(apiKey) & is.null(apiKeyTM)) | is.null(apiKey)) {
    stop("Please assign your API Keys", call. = FALSE)
    
  } else {
    
    getResponse <- GET(url, query = queryParameters)
    
    if (identical(showURL, TRUE)) {
      cat("The requested URL has been this: ", getResponse$url, "\n") 
    }
    
    stop_for_status(getResponse)
    
    rawTextResponse <- content(getResponse, as = "text")
    
    if (grepl("application/json", getResponse$headers$`content-type`)) {
      response <- fromJSON(rawTextResponse)
    } else {
      response <- rawTextResponse
    }
    

    
    return(response)
  }
  
}

# #' @title This represents interfaces to create a secured authtoken.
# #' 
# #' @seealso See \url{http://api.elsevier.com/documentation/AuthenticationAPI.wadl}
# #' 
# #' @param httpAcpt - This represents the acceptable mime types for which the response can be generated.
# #' @param authorization - This contains the OAuth bearer access token, where the format of the 
# #' field is "<token>" (where the token represents the end-user session key). The presence of a bearer 
# #' token implies the request will be executed against user-based entitlements. This token can also be 
# #' submitted through the HTTP header "Authorization" or the query string parameter "access_token".
# #' @param insttoken - This represents a institution token. If provided, this key (in combination 
# #' with its associated APIKey) is used to establish the credentials needed to access content in this resource.
# #' @param apiKey - Override for HTTP header X-ELS-APIKey, this represents a unique application 
# #' developer key providing access to resource.
# #' 
# #' @example 
# #' auth_token(apiKey = decrypt("ElsevierR_APIKey")$key)
# #' 
# #' @import httr
# #' @import jsonlite
# #'
# #' @noRd
# auth_token <- function(httpAcpt = "application/json", author = NULL, inst_token = NULL, apiKey = auth_key(NULL)) {
#   
#   url <- "http://api.elsevier.com/authenticate/"
#   
#   returnGEt <- GET(url, query = list(httpAccept = httpAcpt, access_token = author, insttoken = inst_token, apiKey = apiKey) )
#   responseText <- content(returnGEt, as = "text")
#   
#   returnGEt$url
#   
#   cat(returnGEt$url)
#   
# }


