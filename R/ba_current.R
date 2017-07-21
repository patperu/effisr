#' Search the European Forest Fire Information System 'EFFIS'
#'
#' @export
#'
#' @param country (character) ISO country code
#' @param province (character) Province name
#' @param limit (integer) record limit
#' @param firedate (character) YYYY-MM-DD
#' @param area_ha (integer) size
#' @param ba_class (character) one of 'ALL', '30DAYS' or '07DAYS'
#' @param page (integer) Page number
#' @param ... Curl options passed on to \code{\link[httr]{GET}}

ba_current <- function(country = NULL, province = NULL,
                       limit = NULL, firedate = NULL,
                       area_ha = NULL, ba_class = NULL,
                       page = NULL, ...)
{
  args <- cacomp(list(country = country, province = province,
                      limit = limit, firedate = firedate,
                      area_ha = area_ha, ba_class = ba_class,
                      fmt = "json"))
  res <- ca_GET(paste0(cabase(), 'burntareas/current/?'), args, ...)
  list(docs = parse_facet(res)$result,
       geo =  parse_facet(res)$geo)
}