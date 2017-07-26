#' Search the European Forest Fire Information System 'EFFIS'
#'
#' @export
#'
#' @param country_iso2 (character) ISO2 country code
#' @param limit (integer) Record limit
#' @param updated (character) date time
#' @param detected (character) date time
#' @param fireId (character) Fire ID
#' @param ordering (character) One or more field names. Specifies the sort order.
#' The names can be optionally prefixed by “-” to indicate descending sort.
#' @param page (integer) Page number
#' @template otherargs

ef_fires <- function(country_iso2 = NULL,
                     limit = NULL,
                     updated = NULL,
                     detected = NULL,
                     fireId = NULL,
                     ordering = NULL,
                     page = NULL, ...)
{
  args <- cacomp(list(country_iso2 = country_iso2,
                      limit = limit,
                      updated = updated,
                      detected = detected,
                      fireId = fireId,
                      ordering = ordering,
                      fmt = "json"))
  res <- ca_GET(paste0(cabase(), 'fires/?'), args, ...)

  res$results$lon <- get_coords(res$results)[["lon"]]
  res$results$lat <- get_coords(res$results)[["lat"]]

  res$results$centroid <- NULL
  res$results$bbox <- NULL
  res$results$metadata <- NULL

  res$results$country_iso2 <- country_iso2

  out <- readr::type_convert(res$results, col_types = readr::cols())

  out

  }
