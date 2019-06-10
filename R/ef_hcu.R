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

   if (res$status_code > 201) {
      mssg <- jsonlite::fromJSON(res$parse("UTF-8"))$message$message
      x <- res$status_http()
      stop(
         sprintf("HTTP (%s) - %s\n  %s", x$status_code, x$explanation, mssg),
         call. = FALSE
      )
   }

   txt <- jsonlite::fromJSON(res$parse("UTF-8"))

   x <- data.frame(country = country,
                   year = txt$years,
                   date = txt$trend_nf[,1],
                   trend_nf = txt$trend_nf[, 2],
                   trend_ba = txt$trend_ba[, 2],
                   stringsAsFactors = FALSE)

   readr::type_convert(x, col_types = readr::cols())

  })

  do.call("rbind", data)

}

