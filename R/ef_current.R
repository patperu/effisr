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
                       page = NULL, ...) {


  effisr_client <- set_effisr_client()

  res <- effisr_client$get(
            path = "rest/2/burntareas/current",
            query = cacomp(list(country = country,
                                province = province,
                                limit = limit,
                                firedate = firedate,
                                area_ha = area_ha,
                                ba_class = ba_class,
                                ordering = ordering,
                                fmt = "json")))

  if (res$status_code > 201) {
    mssg <- jsonlite::fromJSON(res$parse("UTF-8"))$message$message
    x <- res$status_http()
    stop(
      sprintf("HTTP (%s) - %s\n  %s", x$status_code, x$explanation, mssg),
      call. = FALSE
    )
  }

  txt <- jsonlite::fromJSON(res$parse("UTF-8"))

  var_names <- c("objectid",
                 "id",
                 "countryful",
                 "province",
                 "commune",
                 "firedate",
                 "area_ha",
                 "broadlea",
                 "conifer",
                 "mixed",
                 "scleroph",
                 "transit",
                 "othernatlc",
                 "agriareas",
                 "artifsurf",
                 "otherlc",
                 "percna2k",
                 "lastupdate",
                 "ba_class",
                 "mic",
                 "se_anno_cad_data",
                 "critech",
                 "country")

  data <- readr::type_convert(txt$results[var_names], col_types = cols())

  make_sf_current(txt, data)

}