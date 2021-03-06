% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ef_fires.R
\name{ef_fires}
\alias{ef_fires}
\title{Search the European Forest Fire Information System 'EFFIS'}
\usage{
ef_fires(country_iso2 = NULL, limit = NULL, updated = NULL,
  detected = NULL, fireId = NULL, ordering = NULL, page = NULL,
  ...)
}
\arguments{
\item{country_iso2}{(character) One or more country names as ISO2 code}

\item{limit}{(integer) Record limit}

\item{updated}{(character) date time}

\item{detected}{(character) date time}

\item{fireId}{(character) Fire ID}

\item{ordering}{(character) One or more field names. Specifies the sort order.
The names can be optionally prefixed by '-' to indicate descending sort.}

\item{page}{(integer) Page number}

\item{...}{Further args passed on to \code{\link[httr]{GET}}}
}
\description{
Search the European Forest Fire Information System 'EFFIS'
}
