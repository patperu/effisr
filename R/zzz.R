cabase <- function() "http://effis.jrc.ec.europa.eu/rest/2/"

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
  z <- readr::type_convert(cbind(z, coords), col_types = readr::cols())

  z$geo_shape <- sf::st_sfc( geo_transform(x$results$shape) )

  geo <- list(bbox = z$bbox, shape = z$shape)

  z$centroid <- NULL
  z$bbox     <- NULL
  z$shape    <- NULL

  list(result=z, geo=geo)

}

get_coords <- function(x) {

    x <- x$centroid

    # set 'null' to NA
    ix <- which(is.na(x$type))
    x$coordinates[ix] <- NA
    coords <- data.frame(do.call("rbind", x$coordinates),
                         stringsAsFactors = FALSE)
    colnames(coords) <- c("lon", "lat")
    coords
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
