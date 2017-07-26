#' Search the European Forest Fire Information System 'EFFIS'
#'
#' @export
#'
#' @param country (character) ISO country code
#' @param province (character) Province name
#' @param limit (integer) Record limit
#' @param firedate (character) YYYY-MM-DD
#' @param area_ha (integer) Size of the fire
#' @param ba_class (character) One of 'ALL', '30DAYS' or '07DAYS'
#' @param ordering (character) One or more field names. Specifies the sort order.
#' The names can be optionally prefixed by “-” to indicate descending sort.
#' @param decimate (integer) pick one date every x
#' @param page (integer) Page number
#' @template otherargs

ef_trend <- function(country = NULL, province = NULL,
                       limit = NULL, firedate = NULL,
                       area_ha = NULL, ba_class = NULL,
                       ordering = NULL,
                       decimate	= NULL,
                       page = NULL, ...)
{
  args <- cacomp(list(country = country, province = province,
                      limit = limit, firedate = firedate,
                      area_ha = area_ha, ba_class = ba_class,
                      decimate = decimate,
                      ordering = ordering,
                      fmt = "json"))
  res <- ca_GET(paste0(cabase(), 'burntareas/trend/?'), args, ...)

  data <- purrr::map_df(res$trend, function(x) jsonlite:::null_to_na(x))

  res <- data.frame(country,
                    day = names(res$trend),
                    year_first = res$dates$first,
                    year_last  = res$dates$last,
                    data,
                    stringsAsFactors = FALSE)

  res <- readr::type_convert(res, col_types = readr::cols())

  res

  }