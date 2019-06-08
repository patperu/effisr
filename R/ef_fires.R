#' Search the European Forest Fire Information System 'EFFIS'
#'
#' @export
#'
#' @param country_iso2 (character) One or more country names as ISO2 code
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
                     updated = NULL, detected = NULL,
                     fireId = NULL, ordering = NULL,
                     page = NULL, ...) {


  effisr_client <- set_effisr_client()

  resp <- effisr_client$get(
    path = "rest/2/fires",
    query = cacomp(list(country_iso2 = country_iso2,
                        limit = limit,
                        updated = updated,
                        detected = detected,
                        fireId = fireId,
                        ordering = ordering,
                        fmt = "json"))
  )

  out <- jsonlite::fromJSON(rawToChar(resp$content))

  var_names <- c("fireId",
                 "metadata",
                 "detected",
                 "updated",
                 "area",
                 "country",
                 "adminSublevel1",
                 "adminSublevel2",
                 "adminSublevel3",
                 "adminSublevel4")

  data <- readr::type_convert(out$results[var_names], col_types = cols())

  make_sf_fires(out, data)

}
