#' Search EFFIS
#'
#'
#' @export
#'
#' @param country (character) Country name, a 2 letter code
#' @param countryful (character) Country name, long name
#' @param province (character) Province name
#' @param commune (character) Commune
#' @param limit (integer) record limit
#' @param critech (character) one of 'YES'
#' @param firedate (character) YYYy-MM-DD
#' @param area_ha (integer) size
#' @param page (integer) Page number
#' @param ... Curl options passed on to \code{\link[httr]{GET}}

eff_search <- function(country = NULL, countryful = NULL, province = NULL,
                    commune = NULL, limit = NULL, critech = NULL,
                    firedate = NULL, area_ha = NULL, page = NULL, ...)
{
  args <- cacomp(list(country = country, countryful = countryful,
                      province = province, commune = commune,
                      limit = limit, critech = critech,
                      firedate = firedate, area_ha = area_ha,
                      fmt = "json"))
  res <- ca_GET(cabase(), args, ...)
  list(docs = parse_facet(res)$result,
       geo =  parse_facet(res)$geo)
}