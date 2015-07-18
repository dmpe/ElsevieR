#' Journal Metrics: Showing SJR and SNIP
#' 
#' Reader is encouraged to read \url{http://www.journalmetrics.com/sjr.php} about SJR 
#' and \url{http://www.journalmetrics.com/snip.php} about SNIP.
#' 
#' Source Normalized Impact per Paper (SNIP) measures contextual citation impact by weighting 
#' citations based on the total number of citations in a subject field. [Powered by Scopus] 
#' 
#' SCImago Journal Rank (SJR) is a measure of scientific influence of scholarly journals that 
#' accounts for both the number of citations received by a journal and the importance or prestige 
#' of the journals where such citations come from. [Powered by Scopus] 
#' 
#' @seealso \url{http://dev.elsevier.com/tecdoc_journal_metrics.html}
#' @seealso \url{http://api.elsevier.com/documentation/SerialTitleAPI.wadl}
#' 
#' @param view - BASIC, ENHANCED, STANDARD (default); See \url{http://api.elsevier.com/documentation/metadata/SerialTitleViews.htm}
#' @param issn - See \url{https://en.wikipedia.org/wiki/International_Standard_Serial_Number}
#' 
#' @examples 
#' ## Example request, retrieving only the SJR and SNIP, for the "European Journal of Marketing" (by ISSN): 
#' journal_metrics(isnn = "0309-0566")
#' 
#' @import dplyr
#' @export
journal_metrics <- function(isnn, apiKey = auth_key(NULL), fields = "SJR,SNIP", view = "STANDARD", 
                            showRequestURL = F){
  
  journalMetricsURL <- "http://api.elsevier.com/content/serial/title"
  
  query <- list(isnn = isnn, apiKey = apiKey, field = fields, view = view)
  
  return_request <- doRequest(journalMetricsURL, query = query, showURL = showRequestURL)
  
  SNIP <- bind_rows(return_request$`serial-metadata-response`$entry$SNIPList$SNIP)
  SJR <- bind_rows(return_request$`serial-metadata-response`$entry$SJRList$SJR)
  
  SNIP$id <- rownames(SNIP) 
  SNIP <- data.frame(melt(SNIP))
  
  SJR$id <- rownames(SJR) 
  SJR <- data.frame(melt(SJR))
  
  
  df_jm <- data.frame(URL = return_request$`serial-metadata-response`$entry$`prism:url`, 
                      SNIP_Year = ifelse(!is.null(SNIP$X.year), SNIP$X.year, NA),
                      SNIP_Value = ifelse(!is.null(SNIP$X.), SNIP$X., NA),
                      SJR_Year = ifelse(!is.null(SJR$X.year), SJR$X.year, NA),
                      SJR_Value = ifelse(!is.null(SJR$X.), SJR$X., NA))
  
  
  return(df_jm)
}

