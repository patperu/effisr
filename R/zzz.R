cabase <- function() "http://effis.jrc.ec.europa.eu/rest/2/burntareas/current/?"

makeurl <- function(url, x) if(is.null(x)) paste0(url, "/search") else paste0(url, "/", x)

ca_GET <- function(url, args, ...) {
  res <- httr::GET(url, query=args, ...)
  httr::stop_for_status(res)
  text <- httr::content(res, as = "text", encoding = "UTF-8")
  jsonlite::fromJSON(text)
}

cacomp <- function (l) Filter(Negate(is.null), l)

parse_facet  <- function(x) {

  z <- x$results
  coords <- data.frame(t(sapply(z$centroid$coordinates, "[")), stringsAsFactors = FALSE)
  colnames(coords) <- c("lon", "lat")
  z <- cbind(z, coords)

  k <- lapply(x$results$shape$coordinates,
              function(m) {
              v <- m[1,,]
              sf::st_polygon(list(v))
              })

  z$geom <- sf::st_sfc(k)

  geo <- list(bbox = z$bbox, shape = z$shape)

  z$centroid <- NULL
  z$bbox     <- NULL
  z$shape    <- NULL

  list(result=z, geo=geo)

}
