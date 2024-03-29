#' eBird Taxonomy
#'
#' A simplified version of the taxonomy used by eBird. Includes proper species
#' as well as various other categories such as `spuh` (e.g. *duck sp.*) and
#' *slash* (e.g. *American Black Duck/Mallard*). This taxonomy is based on the
#' Clements Checklist, which is updated annually, typically in the late summer. 
#' Non-ASCII characters (e.g. those with accents) have been converted to ASCII 
#' equivalents in this data frame.
#'
#' @format A data frame with eight variables and 16,248 rows:
#'   - `scientific_name`: scientific name.
#'   - `common_name`: common name, defaults to English, but different languages 
#'   can be selected using the `locale` parameter.
#'   - `species_code`: a unique alphanumeric code identifying each species.
#'   - `category`: whether the entry is for a species or another 
#'   field-identifiable taxon, such as `spuh`, `slash`, `hybrid`, etc.
#'   - `taxon_order`: numeric value used to sort rows in taxonomic order.
#'   - `order`: the scientific name of the order that the species belongs to.
#'   - `family`: the scientific name of the family that the species belongs to.
#'   - `report_as`: for taxa that can be resolved to true species (i.e. species,
#'   subspecies, and recognizable forms), this field links to the corresponding
#'   species code. For taxa that can't be resolved, this field is `NA`.
#'
#' For further details, see \url{https://support.ebird.org/support/solutions/articles/48000837816-the-ebird-taxonomy}
#' @family data
"ebird_taxonomy"

#' eBird States
#'
#' A data frame of state codes used by eBird. These codes are 4 to 6 characters, 
#' consisting of two parts, the 2-letter ISO country code and a 1-3 character 
#' state code, separated by a dash. For example, `"US-NY"` corresponds to New 
#' York State in the United States. These state codes are required to filter by 
#' state using [auk_state()].
#' 
#' 
#' Note that some countries are not broken into states in eBird and therefore do 
#' not appear in this data frame.
#' 
#' @format A data frame with four variables and 3,145 rows:
#' - `country`: short form of English country name.
#' - `country_code`: 2-letter ISO country code.
#' - `state`: state name.
#' - `state_code`: 4 to 6 character state code.
#' @family data
"ebird_states"

#' BCR Codes
#'
#' A data frame of Bird Conservation Region (BCR) codes. BCRs are ecologically
#' distinct regions in North America with similar bird communities, habitats,
#' and resource management issues. These codes are required to filter by BCR
#' using [auk_bcr()].
#' 
#' @format A data frame with two variables and 66 rows:
#' - `bcr_code`: integer code from 1 to 66.
#' - `bcr_name`: name of BCR.
#' @family data
"bcr_codes"

#' Valid Protocols
#' 
#' A vector of valid protocol names, e.g. "Traveling", "Stationary", etc.
#' 
#' @format A vector with 42 elements.
#' @family data
"valid_protocols"