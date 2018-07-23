#' OS specific path to AWK
#'
#' Return the OS specific path to AWK, or highlights if it's not installed. To 
#' manually set the path to AWK, set the `AWK_PATH` environment variable in your
#' `.Renviron` file.
#'
#' @return Path to AWK or `NA` if AWK wasn't found.
#' @export
#' @family helpers
#' @examples
#' auk_getpath()
auk_getpath <- function() {
  sysname <- tolower(Sys.info()[["sysname"]])

  # manually specified path
  if (Sys.getenv("AWK_PATH") != "") {
    awk <- Sys.getenv("AWK_PATH")
    awk_test <- tryCatch(
      list(result = system(paste(awk, "--version"),
                           intern = TRUE, ignore.stderr = TRUE)),
      error = function(e) list(result = NULL),
      warning = function(e) list(result = NULL)
    )
  } else if (sysname %in% c("darwin", "linux")) {
    # mac or linux
    # test and find path
    awk_test <- tryCatch(
      list(result = system("which awk", intern = TRUE, ignore.stderr = TRUE)),
      error = function(e) list(result = NULL),
      warning = function(e) list(result = NULL)
    )
    # set path
    awk <- awk_test$result
  } else if (sysname == "windows") {
    # cygwin or cygwin64?
    if (file.exists("C:/cygwin64/bin/gawk.exe")) {
      awk <- "C:/cygwin64/bin/gawk.exe"
    } else if (file.exists("C:/cygwin/bin/gawk.exe")) {
      awk <- "C:/cygwin/bin/gawk.exe"
    } else {
      return(NA_character_)
    }
    # test
    awk_test <- tryCatch(
      list(result = system(paste(awk, "--version"),
                           intern = TRUE, ignore.stderr = TRUE)),
      error = function(e) list(result = NULL),
      warning = function(e) list(result = NULL)
    )
  } else {
    return(NA_character_)
  }

  if (!is.null(awk_test$result)) {
    return(awk)
  } else {
    return(NA_character_)
  }
}
