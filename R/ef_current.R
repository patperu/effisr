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
#' @param page (integer) Page number
#' @template otherargs

ef_current <- function(country = NULL, province = NULL,
                       limit = NULL, firedate = NULL,
                       area_ha = NULL, ba_class = NULL,
                       ordering = NULL,
                       page = NULL, ...)
{
  args <- cacomp(list(country = country, province = province,
                      limit = limit, firedate = firedate,
                      area_ha = area_ha, ba_class = ba_class,
                      ordering = ordering,
                      fmt = "json"))
  res <- ca_GET(paste0(cabase(), 'burntareas/current/?'), args, ...)
  list(docs = parse_facet(res)$result,
       geo =  parse_facet(res)$geo)
}