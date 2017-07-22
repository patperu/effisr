#' R Client for the European Forest Fire Information System (EFFIS) API
#'
#'
#' @section About:
#'
#' This package gives you access to data from EFFIS System
#' \url{http://effis.jrc.ec.europa.eu/} via their API
#' (\url{http://effis.jrc.ec.europa.eu/api-test/})
#'
#' @section Functions:
#'
#' \itemize{
#'  \item \code{\link{ef_current}}
#'  \item \code{\link{ef_trend}} .
#'  \item \code{\link{ef_fires}} .
#' }
#'
#'
#' @name effisr-package
#' @aliases effisr
#' @docType package
#' @title R client for EFFIS
#' @author Patrick Hausmann \email{patrick.hausmann@@covimo.de}
#' @keywords package
#' @importFrom readr type_convert cols
#' @importFrom purrr map_df
NULL