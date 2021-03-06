% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drug_parsers.R
\name{drug_affected_organisms}
\alias{drug_affected_organisms}
\title{Extracts the drug affected organisms element and return data as tibble.}
\usage{
drug_affected_organisms(save_table = FALSE, save_csv = FALSE,
  csv_path = ".", override_csv = FALSE)
}
\arguments{
\item{save_table}{boolean, save table in database if true.}

\item{save_csv}{boolean, save csv version of parsed tibble if true}

\item{csv_path}{location to save csv files into it, default is current
location, save_csv must be true}

\item{override_csv}{override existing csv, if any, in case it is true in the
new parse operation}
}
\value{
drug affected organisms node attributes tibble
}
\description{
\code{drug_affected_organisms} returns tibble of drug affected
organisms elements.
}
\details{
This functions extracts the affected organisms element of drug node in
drugbank
xml database with the option to save it in a predefined database via
\code{\link{open_db}} method. It takes one single optional argument to
save the returned tibble in the database.
It must be called after \code{\link{read_drugbank_xml_db}} function like
any other parser function.
If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
no need to call it again before calling this function.
}
\examples{
\dontrun{
# return only the parsed tibble
drug_affected_organisms()

# save in database and return parsed tibble
drug_affected_organisms(save_table = TRUE)

# save parsed tibble as csv if it does not exist in current
# location and return parsed tibble.
# If the csv exist before read it and return its data.
drug_affected_organisms(save_csv = TRUE)

# save in database, save parsed tibble as csv if it does not exist
# in current location and return parsed tibble.
# If the csv exist before read it and return its data.
drug_affected_organisms(save_table = TRUE, save_csv = TRUE)

# save parsed tibble as csv if it does not exist in given location
# and return parsed tibble.
# If the csv exist before read it and return its data.
drug_affected_organisms(save_csv = TRUE, csv_path = TRUE)

# save parsed tibble as csv if it does not exist in current
# location and return parsed tibble.
# If the csv exist override it and return it.
drug_affected_organisms(
  save_csv = TRUE, csv_path = TRUE,
  override = TRUE
)
}
}
\seealso{
Other drugs: \code{\link{drug_ahfs_codes}},
  \code{\link{drug_articles}},
  \code{\link{drug_atc_codes}}, \code{\link{drug_books}},
  \code{\link{drug_calc_prop}},
  \code{\link{drug_categories}},
  \code{\link{drug_classification}},
  \code{\link{drug_dosages}},
  \code{\link{drug_ex_identity}},
  \code{\link{drug_exp_prop}},
  \code{\link{drug_external_links}},
  \code{\link{drug_food_interactions}},
  \code{\link{drug_groups}},
  \code{\link{drug_interactions}},
  \code{\link{drug_intern_brand}},
  \code{\link{drug_links}},
  \code{\link{drug_manufacturers}},
  \code{\link{drug_mixtures}},
  \code{\link{drug_packagers}}, \code{\link{drug_patents}},
  \code{\link{drug_pdb_entries}},
  \code{\link{drug_products}}, \code{\link{drug_salts}},
  \code{\link{drug_snp_adverse_reactions}},
  \code{\link{drug_snp_effects}}, \code{\link{drug_syn}},
  \code{\link{drug}}
}
\concept{drugs}
