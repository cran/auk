% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format-unmarked-occu.R
\name{format_unmarked_occu}
\alias{format_unmarked_occu}
\title{Format EBD data for occupancy modeling with \code{unmarked}}
\usage{
format_unmarked_occu(
  x,
  site_id = "site",
  response = "species_observed",
  site_covs,
  obs_covs
)
}
\arguments{
\item{x}{\code{data.frame}; observation data, e.g. from the eBird Basic Dataset
(EBD), for \strong{a single species}, that has been filtered to those with
repeat visits by \code{\link[=filter_repeat_visits]{filter_repeat_visits()}}.}

\item{site_id}{character; a unique idenitifer for each "site", typically
identifying observations from a unique location by the same observer
within a period of temporal closure. Data output from
\code{\link[=filter_repeat_visits]{filter_repeat_visits()}} will have a \code{.site_id} variable that meets these
requirements.}

\item{response}{character; the variable that will act as the response in
modeling efforts, typically a binary variable indicating presence or
absence or a count of individuals seen.}

\item{site_covs}{character; the variables that will act as site-level
covariates, i.e. covariates that vary at the site level, for example,
latitude/longitude or habitat predictors. If this parameter is missing, it
will be assumed that any variable that is not an observation-level
covariate (\code{obs_covs}) or the \code{site_id}, is a site-level covariate.}

\item{obs_covs}{character; the variables that will act as observation-level
covariates, i.e. covariates that vary within sites, at the level of
observations, for example, time or length of observation.}
}
\value{
A data frame that can be processed by \code{\link[unmarked:formatWideLong]{unmarked::formatWide()}}.
Each row will correspond to a unqiue site and, assuming there are a maximum
of \code{N} observations per site, columns will be as follows:
\enumerate{
\item The unique site identifier, named "site".
\item \code{N} response columns, one for each observation, named "y.1", ..., "y.N".
\item Columns for each of the site-level covariates.
\item Groups of \code{N} columns of observation-level covariates, one column per
covariate per observation, names "covariate_name.1", ...,
"covariate_name.N".
}
}
\description{
Prepare a data frame of species observations for ingestion into the package
\code{unmarked} for hierarchical modeling of abundance and occurrence. The
function \code{\link[unmarked:formatWideLong]{unmarked::formatWide()}} takes a data frame and converts it to one
of several \code{unmarked} objects, which can then be used for modeling. This
function converts data from a format in which each row is an observation
(e.g. as in the eBird Basic Dataset) to the esoteric format required by
\code{\link[unmarked:formatWideLong]{unmarked::formatWide()}} in which each row is a site.
}
\details{
Hierarchical modeling requires repeat observations at each "site" to
estimate detectability. A "site" is typically defined as a geographic
location visited by the same observer within a period of temporal closure.
To define these sites and filter out observations that do not correspond to
repeat visits, users should use \code{\link[=filter_repeat_visits]{filter_repeat_visits()}}, then pass the
output to this function.

\code{\link[=format_unmarked_occu]{format_unmarked_occu()}} is designed to prepare data to be converted into
an \code{unmarkedFrameOccu} object for occupancy modeling with
\code{\link[unmarked:occu]{unmarked::occu()}}; however, it can also be used to prepare data for
conversion to an \code{unmarkedFramePCount} object for abundance modeling with
\code{\link[unmarked:pcount]{unmarked::pcount()}}.
}
\examples{
# read and zero-fill the ebd data
f_ebd <- system.file("extdata/zerofill-ex_ebd.txt", package = "auk")
f_smpl <- system.file("extdata/zerofill-ex_sampling.txt", package = "auk")
# data must be for a single species
ebd_zf <- auk_zerofill(x = f_ebd, sampling_events = f_smpl,
                       species = "Collared Kingfisher",
                       collapse = TRUE)
occ <- filter_repeat_visits(ebd_zf, n_days = 30)
# format for unmarked
# typically one would join in habitat covariates prior to this step
occ_wide <- format_unmarked_occu(occ,
                                 response = "species_observed",
                                 site_covs = c("latitude", "longitude"),
                                 obs_covs = c("effort_distance_km", 
                                              "duration_minutes"))
# create an unmarked object
if (requireNamespace("unmarked", quietly = TRUE)) {
  occ_um <- unmarked::formatWide(occ_wide, type = "unmarkedFrameOccu")
  unmarked::summary(occ_um)
}

# this function can also be used for abundance modeling
abd <- ebd_zf \%>\% 
  # convert count to integer, drop records with no count
  dplyr::mutate(observation_count = as.integer(observation_count)) \%>\% 
  dplyr::filter(!is.na(observation_count)) \%>\% 
  # filter to repeated visits
  filter_repeat_visits(n_days = 30)
# prepare for conversion to unmarkedFramePCount object
abd_wide <- format_unmarked_occu(abd,
                                 response = "observation_count",
                                 site_covs = c("latitude", "longitude"),
                                 obs_covs = c("effort_distance_km", 
                                              "duration_minutes"))
# create an unmarked object
if (requireNamespace("unmarked", quietly = TRUE)) {
  abd_um <- unmarked::formatWide(abd_wide, type = "unmarkedFrameOccu")
  unmarked::summary(abd_um)
}
}
\seealso{
Other modeling: 
\code{\link{filter_repeat_visits}()}
}
\concept{modeling}
