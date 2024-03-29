% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auk-clean.R
\name{auk_clean}
\alias{auk_clean}
\title{Clean an eBird data file (Deprecated)}
\usage{
auk_clean(f_in, f_out, sep = "\\t", remove_text = FALSE, overwrite = FALSE)
}
\arguments{
\item{f_in}{character; input file. If file is not found as specified, it will
be looked for in the directory specified by the \code{EBD_PATH} environment
variable.}

\item{f_out}{character; output file.}

\item{sep}{character; the input field separator, the basic dataset is tab
separated by default. Must only be a single character and space delimited
is not allowed since spaces appear in many of the fields.}

\item{remove_text}{logical; whether all free text entry columns should be
removed. These columns include comments, location names, and observer
names. These columns cause import errors due to special characters and
increase the file size, yet are rarely valuable for analytical
applications, so may be removed. Setting this argument to \code{TRUE} can lead
to a significant reduction in file size.}

\item{overwrite}{logical; overwrite output file if it already exists.}
}
\value{
If AWK ran without errors, the output filename is returned, however,
if an error was encountered the exit code is returned.
}
\description{
This function is no longer required by current versions of the eBird Basic
Dataset (EBD).
}
\examples{
\dontrun{
# get the path to the example data included in the package
f <- system.file("extdata/ebd-sample.txt", package = "auk")
# output to a temp file for example
# in practice, provide path to output file
# e.g. f_out <- "output/ebd_clean.txt"
f_out <- tempfile()

# clean file to remove problem rows
# note: this function is deprecated and no longer does anything
auk_clean(f, f_out)
}
}
\seealso{
Other text: 
\code{\link{auk_select}()},
\code{\link{auk_split}()}
}
\concept{text}
