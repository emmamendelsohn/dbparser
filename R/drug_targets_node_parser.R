get_targ_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ get_organizm_rec(.x, xmlValue(rec["drugbank-id"][[1]]))
  ))
}

get_targ_actions_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ drug_sub_df(.x, "actions", id = "id")
  ))
}

get_targ_articles_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ drug_sub_df(.x, "references", seconadary_node = "articles", id = "id")
  ))
}

get_targ_textbooks_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ drug_sub_df(.x, "references", seconadary_node = "textbooks", id = "id")
  ))
}

get_targ_links_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ drug_sub_df(.x, "references", seconadary_node = "links", id = "id")
  ))
}

get_targ_poly_df <- function(rec) {
  return(map_df(xmlChildren(rec[["targets"]]), ~ get_polypeptide_rec(.x)))
}

get_targ_poly_ex_identity_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ get_poly_ex_identity(.x)
  ))
}

get_targ_poly_syn_df <- function(rec) {
  return(map_df(xmlChildren(rec[["targets"]]), ~ get_polypeptide_syn(.x)))
}

get_targ_poly_pfams_df <- function(rec) {
  return(map_df(xmlChildren(rec[["targets"]]), ~ get_polypeptide_pfams(.x)))
}

get_targ_poly_go_df <- function(rec) {
  return(map_df(
    xmlChildren(rec[["targets"]]),
    ~ get_polypeptide_go(.x)
  ))
}

#' Extracts the drug targ polypeptides external identifiers
#'  element and return data as tibble.
#'
#' \code{targets_polypeptide_ext_ident}
#'  returns tibble of drug targ polypeptides external identifiers
#'  elements.
#'
#' This functions extracts the targ polypeptides external identifiers
#'  element of drug node in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ polypeptides external identifiers node attributes
#' date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_polypeptide_ext_ident()
#'
#' # save in database and return parsed tibble
#' targets_polypeptide_ext_ident(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location
#' # and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_ext_ident(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not exist in
#' current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_ext_ident(
#'   save_table = TRUE,
#'   save_csv = TRUE
#' )
#'
#' # save parsed tibble as csv if it does not exist in given location
#' # and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_ext_ident(
#'   save_csv = TRUE,
#'   csv_path = TRUE
#' )
#'
#' # save parsed tibble as csv if it does not exist in current location
#' # and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_polypeptide_ext_ident(
#'   save_csv = TRUE, csv_path = TRUE, override = TRUE
#' )
#' }
#' @export
targets_polypeptide_ext_ident <-
  function(save_table = FALSE, save_csv = FALSE, csv_path = ".",
           override_csv = FALSE) {
    check_data_and_connection(save_table)
    path <-
      get_dataset_full_path(
        "drug_targ_poly_ex_identity",
        csv_path
      )
    if (!override_csv & file.exists(path)) {
      drug_targ_poly_ex_identity <- readr::read_csv(path)
    } else {
      drug_targ_poly_ex_identity <-
        map_df(
          pkg_env$children,
          ~ get_targ_poly_ex_identity_df(.x)
        ) %>%
        unique()

      write_csv(
        drug_targ_poly_ex_identity, save_csv,
        csv_path
      )
    }

    if (save_table) {
      save_drug_sub(
        con = pkg_env$con,
        df = drug_targ_poly_ex_identity,
        table_name = "drug_targ_polys_external_identifiers",
        save_table_only = TRUE
      )
    }
    return(drug_targ_poly_ex_identity %>% as_tibble())
  }


#' Extracts the drug targ polypeptides syn element
#' and return data as tibble.
#'
#' \code{targets_polypeptide_syn} returns data
#'  frame of drug targ polypeptides syn elements.
#'
#' This functions extracts the targ polypeptides syn element of
#' drug node in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ polypeptides syn node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_polypeptide()
#'
#' # save in database and return parsed tibble
#' targets_polypeptide_syn(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_syn(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not exist
#' # in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_syn(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given location and
#' # return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_syn(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location
#' # and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_polypeptide_syn(
#'   save_csv = TRUE, csv_path = TRUE,
#'   override = TRUE
#' )
#' }
#' @export
targets_polypeptide_syn <-
  function(save_table = FALSE, save_csv = FALSE, csv_path = ".",
           override_csv = FALSE) {
    check_data_and_connection(save_table)
    path <-
      get_dataset_full_path("drug_targ_poly_syn", csv_path)
    if (!override_csv & file.exists(path)) {
      drug_targ_poly_syn <- readr::read_csv(path)
    } else {
      drug_targ_poly_syn <-
        map_df(
          pkg_env$children,
          ~ get_targ_poly_syn_df(.x)
        ) %>%
        unique()

      write_csv(drug_targ_poly_syn, save_csv, csv_path)
    }

    if (save_table) {
      save_drug_sub(
        con = pkg_env$con,
        df = drug_targ_poly_syn,
        table_name = "drug_targ_polys_syn",
        save_table_only = TRUE
      )
    }
    return(drug_targ_poly_syn %>% as_tibble())
  }


#' Extracts the drug targ polypeptides pfams
#'  element and return data as tibble.
#'
#' \code{targets_polypeptide_pfams} returns tibble of
#'  drug targ polypeptides pfams elements.
#'
#' This functions extracts the targ polypeptides pfams element of drug node
#' in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#' new parse operation
#' @return drug targ polypeptides pfams node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_polypeptide_pfams()
#'
#' # save in database and return parsed tibble
#' targets_polypeptide_pfams(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location
#' # and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_pfams(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not exist in
#' current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_pfams(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given location and
#' #  return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_pfams(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location
#' # and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_polypeptide_pfams(
#'   save_csv = TRUE, csv_path = TRUE,
#'   override = TRUE
#' )
#' }
#' @export
targets_polypeptide_pfams <-
  function(save_table = FALSE, save_csv = FALSE, csv_path = ".",
           override_csv = FALSE) {
    check_data_and_connection(save_table)
    path <-
      get_dataset_full_path("drug_targ_poly_pfams", csv_path)
    if (!override_csv & file.exists(path)) {
      drug_targ_poly_pfams <- readr::read_csv(path)
    } else {
      drug_targ_poly_pfams <-
        map_df(
          pkg_env$children,
          ~ get_targ_poly_pfams_df(.x)
        ) %>%
        unique()

      write_csv(drug_targ_poly_pfams, save_csv, csv_path)
    }


    if (save_table) {
      save_drug_sub(
        con = pkg_env$con,
        df = drug_targ_poly_pfams,
        table_name = "drug_targ_polys_pfams",
        save_table_only = TRUE
      )
    }
    return(drug_targ_poly_pfams %>% as_tibble())
  }


#' Extracts the drug targ polypeptides go classifiers
#'  element and return data as tibble.
#'
#' \code{targets_polypeptide_go}
#'  returns tibble of drug targ polypeptides go classifiers elements.
#'
#' This functions extracts the targ polypeptides go classifiers
#'  element of drug node in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ polypeptides go classifiers node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_polypeptide_go()
#'
#' # save in database and return parsed tibble
#' targets_polypeptide_go(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location
#' # and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_go(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not exist
#' # in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_go(
#'   save_table = TRUE,
#'   save_csv = TRUE
#' )
#'
#' # save parsed tibble as csv if it does not exist in given
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide_go(
#'   save_csv = TRUE,
#'   csv_path = TRUE
#' )
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_polypeptide_go(
#'   save_csv = TRUE,
#'   csv_path = TRUE, override = TRUE
#' )
#' }
#' @export
targets_polypeptide_go <-
  function(save_table = FALSE, save_csv = FALSE, csv_path = ".",
           override_csv = FALSE) {
    check_data_and_connection(save_table)
    path <-
      get_dataset_full_path(
        "drug_targ_polys_go",
        csv_path
      )
    if (!override_csv & file.exists(path)) {
      drug_targ_polys_go <- readr::read_csv(path)
    } else {
      drug_targ_polys_go <-
        map_df(
          pkg_env$children,
          ~ get_targ_poly_go_df(.x)
        ) %>%
        unique()

      write_csv(drug_targ_polys_go, save_csv, csv_path)
    }


    if (save_table) {
      save_drug_sub(
        con = pkg_env$con,
        df = drug_targ_polys_go,
        table_name = "drug_targ_polys_go",
        save_table_only = TRUE
      )
    }
    return(drug_targ_polys_go %>% as_tibble())
  }

#' Extracts the drug targ actions element and return data as tibble.
#'
#' \code{targets_actions} returns tibble of drug targ
#' actions elements.
#'
#' This functions extracts the targ actions element of drug node in drugbank
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ actions node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_actions()
#'
#' # save in database and return parsed tibble
#' targets_actions(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_actions(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_actions(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_actions(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_actions(save_csv = TRUE, csv_path = TRUE, override = TRUE)
#' }
#' @export
targets_actions <- function(save_table = FALSE, save_csv = FALSE,
                                    csv_path = ".", override_csv = FALSE) {
  check_data_and_connection(save_table)
  path <-
    get_dataset_full_path("drug_targ_actions", csv_path)
  if (!override_csv & file.exists(path)) {
    drug_targ_actions <- readr::read_csv(path)
  } else {
    drug_targ_actions <-
      map_df(pkg_env$children, ~ get_targ_actions_df(.x)) %>%
      unique()
    write_csv(drug_targ_actions, save_csv, csv_path)
  }


  if (nrow(drug_targ_actions) > 0) {
    colnames(drug_targ_actions) <- c("action", "target_id")
  }


  if (save_table) {
    save_drug_sub(
      con = pkg_env$con,
      df = drug_targ_actions,
      table_name = "drug_targ_actions",
      save_table_only = TRUE
    )
  }
  return(drug_targ_actions %>% as_tibble())
}

#' Extracts the drug targ articles element and return data as tibble.
#'
#' \code{targets_articles} returns tibble of drug targ
#' articles elements.
#'
#' This functions extracts the targ articles element of drug node in drugbank
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ articles node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_articles()
#'
#' # save in database and return parsed tibble
#' targets_articles(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_articles(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_articles(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_articles(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_articles(
#'   save_csv = TRUE, csv_path = TRUE,
#'   override = TRUE
#' )
#' }
#' @export
targets_articles <- function(save_table = FALSE, save_csv = FALSE,
                                     csv_path = ".", override_csv = FALSE) {
  check_data_and_connection(save_table)
  path <-
    get_dataset_full_path("drug_targ_articles", csv_path)
  if (!override_csv & file.exists(path)) {
    drug_targ_articles <- readr::read_csv(path)
  } else {
    drug_targ_articles <-
      map_df(pkg_env$children, ~ get_targ_articles_df(.x)) %>% unique()

    write_csv(drug_targ_articles, save_csv, csv_path)
  }

  if (save_table) {
    save_drug_sub(
      con = pkg_env$con,
      df = drug_targ_articles,
      table_name = "drug_targ_articles",
      save_table_only = TRUE
    )
  }
  return(drug_targ_articles %>% as_tibble())
}

#' Extracts the drug targ textbooks element and return data as tibble.
#'
#' \code{targets_textbooks} returns tibble of drug
#'  targ textbooks elements.
#'
#' This functions extracts the targ textbooks element of drug node in
#'  drugbank
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ textbooks node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_textbooks()
#'
#' # save in database and return parsed tibble
#' targets_textbooks(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_textbooks(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_textbooks(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given location
#' # and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_textbooks(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_textbooks(
#'   save_csv = TRUE, csv_path = TRUE,
#'   override = TRUE
#' )
#' }
#' @export
targets_textbooks <- function(save_table = FALSE, save_csv = FALSE,
                                      csv_path = ".", override_csv = FALSE) {
  check_data_and_connection(save_table)
  path <-
    get_dataset_full_path("drug_targ_textbooks", csv_path)
  if (!override_csv & file.exists(path)) {
    drug_targ_textbooks <- readr::read_csv(path)
  } else {
    drug_targ_textbooks <-
      map_df(pkg_env$children, ~ get_targ_textbooks_df(.x)) %>% unique()

    write_csv(drug_targ_textbooks, save_csv, csv_path)
  }


  if (save_table) {
    save_drug_sub(
      con = pkg_env$con,
      df = drug_targ_textbooks,
      table_name = "drug_targ_textbooks",
      save_table_only = TRUE
    )
  }
  return(drug_targ_textbooks %>% as_tibble())
}

#' Extracts the drug targ links element and return data as tibble.
#'
#' \code{targets_links} returns tibble of drug targ links
#'  elements.
#'
#' This functions extracts the targ links element of drug node in
#' \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in
#' the new parse operation
#' @return drug targ_links node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_links()
#'
#' # save in database and return parsed tibble
#' targets_links(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_links(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_links(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_links(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in
#' #  current location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_links(save_csv = TRUE, csv_path = TRUE, override = TRUE)
#' }
#' @export
targets_links <- function(save_table = FALSE, save_csv = FALSE,
                                  csv_path = ".", override_csv = FALSE) {
  check_data_and_connection(save_table)
  path <-
    get_dataset_full_path("drug_targ_links", csv_path)
  if (!override_csv & file.exists(path)) {
    drug_targ_links <- readr::read_csv(path)
  } else {
    drug_targ_links <- map_df(pkg_env$children, ~
    get_targ_links_df(.x)) %>% unique()

    write_csv(drug_targ_links, save_csv, csv_path)
  }



  if (save_table) {
    save_drug_sub(
      con = pkg_env$con,
      df = drug_targ_links,
      table_name = "drug_targ_links",
      save_table_only = TRUE,
      field_types = list(
        title = paste("varchar(",
          max(nchar(
            drug_targ_links$title
          ), na.rm = TRUE) + 100, ")",
          sep = ""
        ),
        url = paste("varchar(", max(nchar(
          drug_targ_links$url
        )) + 100, ")", sep = "")
      )
    )
  }
  return(drug_targ_links %>% as_tibble())
}

#' Extracts the drug targ polypeptides element and return data as tibble.
#'
#' \code{targets_polypeptide} returns tibble of drug targ
#'  polypeptides elements.
#'
#' This functions extracts the targ polypeptides element of drug node
#' in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return drug targ polypeptides node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets_polypeptide()
#'
#' # save in database and return parsed tibble
#' targets_polypeptide(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets_polypeptide(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets_polypeptide(
#'   save_csv = TRUE, csv_path = TRUE,
#'   override = TRUE
#' )
#' }
#' @export
targets_polypeptide <- function(save_table = FALSE,
                                  save_csv = FALSE, csv_path = ".",
                                  override_csv = FALSE) {
  check_data_and_connection(save_table)
  path <-
    get_dataset_full_path("drug_targ_polys", csv_path)
  if (!override_csv & file.exists(path)) {
    drug_targ_polys <- readr::read_csv(path)
  } else {
    drug_targ_polys <-
      map_df(pkg_env$children, ~ get_targ_poly_df(.x)) %>%
      unique()

    write_csv(drug_targ_polys, save_csv, csv_path)
  }


  if (save_table) {
    save_drug_sub(
      con = pkg_env$con,
      df = drug_targ_polys,
      table_name = "drug_targ_polys",
      save_table_only = TRUE,
      field_types = list(
        general_function =
          paste("varchar(",
            max(nchar(drug_targ_polys$general_function),
              na.rm = TRUE
            ), ")",
            sep = ""
          ),
        specific_function = paste("varchar(max)", sep = ""),
        amino_acid_sequence = paste("varchar(max)", sep = ""),
        gene_sequence = paste("varchar(max)", sep = "")
      )
    )
  }
  return(drug_targ_polys %>% as_tibble())
}


#' Extracts the drug targ element and return data as tibble.
#'
#' \code{targets} returns tibble of drug targ elements.
#'
#' This functions extracts the target element of drug node in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. It takes one single optional argument to
#' save the returned tibble in the database.
#' It must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' If \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#' new parse operation
#' @return drug target node attributes date frame
#' @family targets
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' targets()
#'
#' # save in database and return parsed tibble
#' targets(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given
#' # location and return parsed tibble.
#' # If the csv exist before read it and return its data.
#' targets(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' #  location and return parsed tibble.
#' # If the csv exist override it and return it.
#' targets(save_csv = TRUE, csv_path = TRUE, override = TRUE)
#' }
#' @export
targets <- function(save_table = FALSE, save_csv = FALSE,
                            csv_path = ".", override_csv = FALSE) {
  check_data_and_connection(save_table)
  path <-
    get_dataset_full_path("drug_targ", csv_path)
  if (!override_csv & file.exists(path)) {
    drug_targ <- readr::read_csv(path)
  } else {
    drug_targ <-
      map_df(pkg_env$children, ~ get_targ_df(.x)) %>%
      unique()

    write_csv(drug_targ, save_csv, csv_path)
  }


  if (save_table) {
    save_drug_sub(
      con = pkg_env$con,
      df = drug_targ,
      table_name = "drug_targ",
      foreign_key = "parent_key"
    )
  }
  return(drug_targ %>% as_tibble())
}
