#' Search the European Forest Fire Information System 'EFFIS'
#'
#'
#' @export
#' @param country (country) ISO2 code, only one country
#' @param year (integer) One or more year, must be smaler than the current year

ef_hcu <- function(country, year) {

 data <- purrr::map2(year, country, function(x, y) {

    url <- sprintf("http://effis.jrc.ec.europa.eu/rest/2/burntareas/historical/cumulative/?decimate=7&format=json&yearseason=%s&country=%s", x, y)

    res <- httr::GET(url)
    res <- httr::content(res, as = "text", encoding = "UTF-8")

    r <- jsonlite::fromJSON(res)

    identical(r$trend_nf[,1], r$trend_ba[,1])

    x <- data.frame(country = country,
                    year = r$years,
                    date = r$trend_nf[,1],
                    trend_nf = r$trend_nf[,2],
                    trend_ba = r$trend_ba[,2],
                    stringsAsFactors = FALSE)

    readr::type_convert(x, col_types = readr::cols())

  })

  do.call("rbind", data)

}

