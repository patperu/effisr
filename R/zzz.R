cabase <- function() "http://effis.jrc.ec.europa.eu"

ca_GET <- function(url, args, ...) {

  res <- httr::GET(url, query=args, ...)
  httr::stop_for_status(res)
  text <- httr::content(res, as = "text", encoding = "UTF-8")
  jsonlite::fromJSON(text)
}

cacomp <- function (l) Filter(Negate(is.null), l)

set_effisr_client <- function() {

  crul::HttpClient$new(
    url = "effis.jrc.ec.europa.eu",
    opts = list(timeout_ms = 30000),
    headers = list(`User-Agent` = "effisr R package; http://github.com/patperu/effisr")
  )

}

geo_transform <- function(x) {

  v <- list()

  geo_type  <- x$type
  geo_coord <- x$coordinates

  for(i in seq_along(geo_type)){
    if(geo_type[i] == "Polygon")
      v[[i]] <- sf::st_polygon(list(geo_coord[[i]][1,,]))
    else {
      v[[i]] <- sf::st_multipolygon(list(geo_coord[[i]][[1]]))
    }

  }

  v
}

make_sf_fires <- function(res, data) {

  poly_obj <- geo_transform(res$results$shape)

  sf::st_sf(cbind(data, sf::st_sfc(poly_obj, crs = 4326)))

}

make_sf_current <- function(res, data) {

  poly_obj <- purrr::map(res$results$shape$coordinates, ~{st_polygon(list(matrix(.x, ncol = 2)))})

  sf::st_sf(cbind(data, sf::st_sfc(poly_obj, crs = 4326)))
}

