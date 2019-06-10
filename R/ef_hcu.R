#' Search the European Forest Fire Information System 'EFFIS'
#'
#'
#' @export
#' @param country (country) ISO2 code, only one country
#' @param year (integer) One or more year, must be smaler than the current year

ef_hcu <- function(country, year) {

 data <- purrr::map2(country, year, function(x, y) {

   effisr_client <- set_effisr_client()

   res <- effisr_client$get(
                  path = "rest/2/burntareas/historical/cumulative/",
                  query = cacomp(list(country = x,
                                      yearseason = y,
                                      decimate = 7,
                                      fmt = "json")))

   res <- jsonlite::fromJSON(rawToChar(res$content))

   x <- data.frame(country = country,
                   year = res$years,
                   date = res$trend_nf[,1],
                   trend_nf = res$trend_nf[, 2],
                   trend_ba = res$trend_ba[, 2],
                   stringsAsFactors = FALSE)

   readr::type_convert(x, col_types = readr::cols())

  })

  do.call("rbind", data)

}

