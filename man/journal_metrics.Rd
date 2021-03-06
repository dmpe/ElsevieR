% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/journalMetrics.R
\name{journal_metrics}
\alias{journal_metrics}
\title{Journal Metrics: Showing SJR and SNIP}
\usage{
journal_metrics(isnn, apiKey = auth_key(NULL), fields = "SJR,SNIP",
  view = "STANDARD", showRequestURL = F)
}
\arguments{
\item{view}{- BASIC, ENHANCED, STANDARD (default); See \url{http://api.elsevier.com/documentation/metadata/SerialTitleViews.htm}}

\item{issn}{- See \url{https://en.wikipedia.org/wiki/International_Standard_Serial_Number}}
}
\description{
Reader is encouraged to read \url{http://www.journalmetrics.com/sjr.php} about SJR
and \url{http://www.journalmetrics.com/snip.php} about SNIP.
}
\details{
Source Normalized Impact per Paper (SNIP) measures contextual citation impact by weighting
citations based on the total number of citations in a subject field. [Powered by Scopus]

SCImago Journal Rank (SJR) is a measure of scientific influence of scholarly journals that
accounts for both the number of citations received by a journal and the importance or prestige
of the journals where such citations come from. [Powered by Scopus]
}
\examples{
## Example request, retrieving only the SJR and SNIP, for the "European Journal of Marketing" (by ISSN):
journal_metrics(isnn = "0309-0566")
}
\seealso{
\url{http://dev.elsevier.com/tecdoc_journal_metrics.html}

\url{http://api.elsevier.com/documentation/SerialTitleAPI.wadl}
}

