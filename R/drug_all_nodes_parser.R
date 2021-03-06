#' extracts the all drug elements and return data as list of tibbles.
#'
#' this functions extracts all element of drug nodes in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. it takes one single optional argument to
#' save the returned tibble in the database.
#' it must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' if \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#' location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @return all drug elements tibbles
#' @family common
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' drug_all()
#'
#' # save in database and return parsed tibble
#' drug_all(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location,
#' # and return parsed tibble.
#' # if the csv exist before read it and return its data.
#' drug_all(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv,
#' # if it does not exist in current location and return parsed tibble.
#' # if the csv exist before read it and return its data.
#' drug_all(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given location,
#' # and return parsed tibble.
#' # if the csv exist before read it and return its data.
#' drug_all(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location and
#' # return parsed tibble.
#' # if the csv exist override it and return it.
#' drug_all(save_csv = TRUE, csv_path = TRUE, override = TRUE)
#' }
#' @export
drug_all <-
  function(save_table = FALSE,
           save_csv = FALSE,
           csv_path = ".",
           override_csv = FALSE) {
    check_data_and_connection(save_table)
    drugs <- drug(save_table, save_csv, csv_path, override_csv)
    message("parsed drugs main attributes, 1/75")
    groups_drug <-
      drug_groups(save_table, save_csv, csv_path, override_csv)
    message("parsed groups_drug, 2/75")
    articles_drug <-
      drug_articles(save_table, save_csv, csv_path, override_csv)
    message("parsed articles_drug, 3/75")
    books_drug <-
      drug_books(save_table, save_csv, csv_path, override_csv)
    message("parsed books_drug, 4/75")
    links_drug <-
      drug_links(save_table, save_csv, csv_path, override_csv)
    message("parsed links_drug, 5/75")
    syn_drug <-
      drug_syn(save_table, save_csv, csv_path, override_csv)
    message("parsed syn_drug, 6/75")
    products_drug <-
      drug_products(save_table, save_csv, csv_path, override_csv)
    message("parsed products_drug, 7/75")
    mixtures_drug <-
      drug_mixtures(save_table, save_csv, csv_path, override_csv)
    message("parsed mixtures_drug, 8/75")
    packagers_drug <-
      drug_packagers(save_table, save_csv, csv_path, override_csv)
    message("parsed packagers_drug, 9/75")
    categories_drug <-
      drug_categories(save_table, save_csv, csv_path, override_csv)
    message("parsed categories_drug, 10/75")
    affected_organisms_drug <-
      drug_affected_organisms(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed affected_organisms_drug, 11/75")
    dosages_drug <-
      drug_dosages(save_table, save_csv, csv_path, override_csv)
    message("parsed dosages_drug, 12/75")
    ahfs_codes_drug <-
      drug_ahfs_codes(save_table, save_csv, csv_path, override_csv)
    message("parsed ahfs_codes_drug, 13/75")
    pdb_entries_drug <-
      drug_pdb_entries(save_table, save_csv, csv_path, override_csv)
    message("parsed pdb_entries_drug, 14/75")
    patents_drug <-
      drug_patents(save_table, save_csv, csv_path, override_csv)
    message("parsed patents_drug, 15/75")
    food_interactions_drug <-
      drug_food_interactions(save_table, save_csv, csv_path, override_csv)
    message("parsed food_interactions_drug, 16/75")
    interactions_drug <-
      drug_interactions(save_table, save_csv, csv_path, override_csv)
    message("parsed interactions_drug, 17/75")
    experimental_properties_drug <-
      drug_exp_prop(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed experimental_properties_drug, 18/75")
    external_identifiers_drug <-
      drug_ex_identity(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed external_identifiers_drug, 19/75")
    external_links_drug <-
      drug_external_links(save_table, save_csv, csv_path, override_csv)
    message("parsed external_links_drug, 20/75")
    snp_effects_drug <-
      drug_snp_effects(save_table, save_csv, csv_path, override_csv)
    message("parsed snp_effects_drug, 21/75")
    snp_adverse_reactions <-
      drug_snp_adverse_reactions(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed snp_adverse_reactions, 22/75")
    atc_codes_drug <-
      drug_atc_codes(save_table, save_csv, csv_path, override_csv)
    message("parsed atc_codes_drug, 23/75")
    actions_carrier_drug <-
      carriers_actions(save_table, save_csv, csv_path, override_csv)
    message("parsed actions_carrier_drug, 24/75")
    articles_carrier_drug <-
      carriers_articles(save_table, save_csv, csv_path, override_csv)
    message("parsed articles_carrier_drug, 25/75")
    textbooks_carrier_drug <-
      carriers_textbooks(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed textbooks_carrier_drug, 26/75")
    links_carrier_drug <-
      carriers_links(save_table, save_csv, csv_path, override_csv)
    message("parsed links_carrier_drug, 27/75")
    polypeptides_carrier_drug <-
      carriers_polypeptide(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed polypeptides_carrier_drug, 28/75")
    carr_poly_ext_identity <-
      carriers_polypeptide_ext_identity(
        save_table,
        save_csv, csv_path,
        override_csv
      )
    message("parsed carr_poly_ext_identity, 29/75")
    carr_polypeptides_syn <-
      carriers_polypeptidepeptides_syn(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed carr_polypeptides_syn, 30/75")
    carr_polypeptides_pfams <-
      carriers_polypeptidepeptides_pfams(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed carr_polypeptides_pfams, 31/75")
    carr_polypeptides_go <-
      carriers_polypeptidepeptides_go(
        save_table, save_csv,
        csv_path, override_csv
      )
    message("parsed carr_polypeptides_go, 32/75")
    carriers_drug <-
      carriers(save_table, save_csv, csv_path, override_csv)
    message("parsed carriers_drug, 33/75")
    classifications_drug <-
      drug_classification(save_table, save_csv, csv_path, override_csv)
    message("parsed classifications_drug, 34/75")
    actions_enzyme_drug <-
      enzymes_actions(save_table, save_csv, csv_path, override_csv)
    message("parsed actions_enzyme_drug, 35/75")
    articles_enzyme_drug <-
      enzymes_articles(save_table, save_csv, csv_path, override_csv)
    message("parsed articles_enzyme_drug, 36/75")
    textbooks_enzyme_drug <-
      enzymes_textbooks(save_table, save_csv, csv_path, override_csv)
    message("parsed textbooks_enzyme_drug, 37/75")
    links_enzyme_drug <-
      enzymes_links(save_table, save_csv, csv_path, override_csv)
    message("parsed links_enzyme_drug, 38/75")
    polypeptides_enzyme_drug <-
      enzymes_polypeptide(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed polypeptides_enzyme_drug, 39/75")
    enzy_poly_ext_identity <-
      enzymes_polypeptide_ext_ident(
        save_table,
        save_csv, csv_path,
        override_csv
      )
    message("parsed external_identifiers_polypeptides_enzyme_drug, 40/75")
    enzy_poly_syn <-
      enzymes_polypeptide_syn(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed enzy_poly_syn, 41/75")
    pfams_polypeptides_enzyme_drug <-
      enzymes_polypeptide_pfams(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed pfams_polypeptides_enzyme_drug, 42/75")
    enzy_poly_go <-
      enzymes_polypeptide_go(
        save_table, save_csv,
        csv_path, override_csv
      )
    message("parsed enzy_poly_go, 43/75")
    enzymes_drug <-
      enzymes(save_table, save_csv, csv_path, override_csv)
    message("parsed enzyme_drug, 44/75")
    manufacturers_drug <-
      drug_manufacturers(save_table, save_csv, csv_path, override_csv)
    message("parsed manufacturers_drug, 45/75")
    enzymes_pathway_drug <-
      drug_pathway_enzyme(save_table, save_csv, csv_path, override_csv)
    message("parsed enzymes_pathway_drug, 46/75")
    drugs_pathway_drug <-
      drug_pathway_drugs(save_table, save_csv, csv_path, override_csv)
    message("parsed drug_pathway_drugs, 47/75")
    pathways_drug <-
      drug_pathway(save_table, save_csv, csv_path, override_csv)
    message("parsed pathways_drug, 48/75")
    prices_drug <-
      drug_prices(save_table, save_csv, csv_path, override_csv)
    message("parsed prices_drug, 49/75")
    reactions_drug <-
      drug_reactions(save_table, save_csv, csv_path, override_csv)
    message("parsed reactions_drug, 50/75")
    enzymes_reactions_drug <-
      drug_reactions_enzymes(save_table, save_csv, csv_path, override_csv)
    message("parsed enzymes_reactions_drug, 51/75")
    sequences_drug <-
      drug_sequences(save_table, save_csv, csv_path, override_csv)
    message("parsed sequences_drug, 52/75")
    targ_poly_ext_identity <-
      targets_polypeptide_ext_ident(
        save_table, save_csv,
        csv_path,
        override_csv
      )
    message("parsed targ_poly_ext_identity, 53/75")
    targ_poly_syn <-
      targets_polypeptide_syn(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed targ_poly_syn, 54/75")
    pfams_polypeptide_target_drug <-
      targets_polypeptide_pfams(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed pfams_polypeptide_target_drug, 55/75")
    targ_poly_go <-
      targets_polypeptide_go(
        save_table, save_csv,
        csv_path, override_csv
      )
    message("parsed targ_poly_go attributes, 56/75")
    actions_target_drug <-
      targets_actions(save_table, save_csv, csv_path, override_csv)
    message("parsed actions_target_drug, 57/75")
    articles_target_drug <-
      targets_articles(save_table, save_csv, csv_path, override_csv)
    message("parsed articles_target_drug, 58/75")
    textbooks_target_drug <-
      targets_textbooks(save_table, save_csv, csv_path, override_csv)
    message("parsed textbooks_target_drug, 59/75")
    links_target_drug <-
      targets_links(save_table, save_csv, csv_path, override_csv)
    message("parsed links_target_drug, 60/75")
    polypeptide_target_drug <-
      targets_polypeptide(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed polypeptide_target_drug, 61/75")
    targ_drug <-
      targets(save_table, save_csv, csv_path, override_csv)
    message("parsed targ_drug, 62/75")
    actions_transporter_drug <-
      transporters_actions(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed actions_transporter_drug, 63/75")
    articles_transporter_drug <-
      transporters_articles(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed articles_transporter_drug, 64/75")
    textbooks_transporter_drug <-
      transporters_textbooks(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed textbooks_transporter_drug, 65/75")
    links_transporter_drug <-
      transporters_links(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed links_transporter_drug, 66/75")
    polypeptides_transporter_drug <-
      transporters_polypeptide(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed polypeptides_transporter_drug, 67/75")
    trans_poly_ex_identity <-
      transporters_polypep_ex_ident(
        save_table, save_csv,
        csv_path, override_csv
      )
    message("parsed trans_poly_ex_identity, 68/75")
    trans_poly_syn <-
      transporters_polypeptide_syn(
        save_table, save_csv,
        csv_path, override_csv
      )
    message("parsed syn_polypeptides_transporter_drug, 69/75")
    trans_poly_pfams <-
      transporters_polypeptide_pfams(
        save_table, save_csv,
        csv_path, override_csv
      )
    message("parsed pfams_polypeptides_transporter_drug, 70/75")
    trans_poly_go <-
      transporters_polypeptide_go(
        save_table, save_csv,
        csv_path,
        override_csv
      )
    message("parsed go_polypeptides_transporter_drug, 71/75")
    transporters_drug <-
      transporters(save_table, save_csv, csv_path, override_csv)
    message("parsed transporters_drug, 72/75")
    international_brands_drug <-
      drug_intern_brand(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed international_brands_drug, 73/75")
    salts_drug <-
      drug_salts(save_table, save_csv, csv_path, override_csv)
    message("parsed salts_drug, 74/75")
    calculated_properties_drug <-
      drug_calc_prop(
        save_table, save_csv, csv_path,
        override_csv
      )
    message("parsed calculated_properties_drug, 75/75")
    return(
      list(
        drugs = drugs,
        groups_drug = groups_drug,
        articles_drug = articles_drug,
        books_drug = books_drug,
        links_drug = links_drug,
        syn_drug = syn_drug,
        products_drug = products_drug,
        mixtures_drug = mixtures_drug,
        packagers_drug = packagers_drug,
        categories_drug = categories_drug,
        affected_organisms_drug = affected_organisms_drug,
        dosages_drug = dosages_drug,
        ahfs_codes_drug = ahfs_codes_drug,
        pdb_entries_drug = pdb_entries_drug,
        patents_drug = patents_drug,
        food_interactions_drug = food_interactions_drug,
        interactions_drug = interactions_drug,
        experimental_properties_drug = experimental_properties_drug,
        external_identifiers_drug = external_identifiers_drug,
        external_links_drug = external_links_drug,
        snp_effects_drug = snp_effects_drug,
        snp_adverse_reactions = snp_adverse_reactions,
        atc_codes_drug = atc_codes_drug,
        actions_carrier_drug = actions_carrier_drug,
        articles_carrier_drug = articles_carrier_drug,
        textbooks_carrier_drug = textbooks_carrier_drug,
        links_carrier_drug = links_carrier_drug,
        polypeptides_carrier_drug = polypeptides_carrier_drug,
        carr_poly_ext_identity =
          carr_poly_ext_identity,
        carr_polypeptides_syn = carr_polypeptides_syn,
        carr_polypeptides_pfams = carr_polypeptides_pfams,
        carr_polypeptides_go =
          carr_polypeptides_go,
        carriers_drug = carriers_drug,
        classifications_drug =
          classifications_drug,
        actions_enzyme_drug = actions_enzyme_drug,
        articles_enzyme_drug = articles_enzyme_drug,
        textbooks_enzyme_drug = textbooks_enzyme_drug,
        links_enzyme_drug = links_enzyme_drug,
        polypeptides_enzyme_drug = polypeptides_enzyme_drug,
        enzy_poly_ext_identity =
          enzy_poly_ext_identity,
        enzy_poly_syn = enzy_poly_syn,
        pfams_polypeptides_enzyme_drug = pfams_polypeptides_enzyme_drug,
        enzy_poly_go =
          enzy_poly_go,
        enzymes_drug = enzymes_drug,
        manufacturers_drug = manufacturers_drug,
        enzymes_pathway_drug = enzymes_pathway_drug,
        drugs_pathway_drug = drugs_pathway_drug,
        pathways_drug = pathways_drug,
        prices_drug = prices_drug,
        reactions_drug = reactions_drug,
        enzymes_reactions_drug = enzymes_reactions_drug,
        sequences_drug = sequences_drug,
        targ_poly_ext_identity =
          targ_poly_ext_identity,
        targ_poly_syn = targ_poly_syn,
        pfams_polypeptide_target_drug = pfams_polypeptide_target_drug,
        targ_poly_go =
          targ_poly_go,
        actions_target_drug = actions_target_drug,
        articles_target_drug = articles_target_drug,
        textbooks_target_drug = textbooks_target_drug,
        links_target_drug = links_target_drug,
        polypeptide_target_drug = polypeptide_target_drug,
        targ_drug = targ_drug,
        actions_transporter_drug = actions_transporter_drug,
        articles_transporter_drug = articles_transporter_drug,
        textbooks_transporter_drug = textbooks_transporter_drug,
        links_transporter_drug = links_transporter_drug,
        polypeptides_transporter_drug = polypeptides_transporter_drug,
        trans_poly_ex_identity =
          trans_poly_ex_identity,
        trans_poly_syn =
          trans_poly_syn,
        trans_poly_pfams = trans_poly_pfams,
        trans_poly_go =
          trans_poly_go,
        transporters_drug = transporters_drug,
        international_brands_drug = international_brands_drug,
        salts_drug = salts_drug,
        culculated_properties_drug = calculated_properties_drug
      )
    )
  }

#' extracts the given drug elements and return data as list of tibbles.
#'
#' \code{drug_element} returns list of tibbles of drugs selected
#' elements.
#'
#' this functions extracts selected element of drug nodes in \strong{DrugBank}
#' xml database with the option to save it in a predefined database via
#' \code{\link{open_db}} method. it takes one single optional argument to
#' save the returned tibble in the database.
#' it must be called after \code{\link{read_drugbank_xml_db}} function like
#' any other parser function.
#' if \code{\link{read_drugbank_xml_db}} is called before for any reason, so
#' no need to call it again before calling this function.
#'
#' drug_element_options can be called to know the valid options for
#' this method
#'
#' @param save_table boolean, save table in database if true.
#' @param save_csv boolean, save csv version of parsed tibble if true
#' @param csv_path location to save csv files into it, default is current
#'  location, save_csv must be true
#' @param override_csv override existing csv, if any, in case it is true in the
#'  new parse operation
#' @param elements_options list,  options of elements to be parsed. default is
#'  "all"
#' @return list of selected drug elements tibbles
#' @family common
#' @examples
#' \dontrun{
#' # return only the parsed tibble
#' drug_element()
#'
#' # save in database and return parsed tibble
#' drug_element(save_table = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current location and
#' # return parsed tibble.
#' # if the csv exist before read it and return its data.
#' drug_element(save_csv = TRUE)
#'
#' # save in database, save parsed tibble as csv if it does not
#' # exist in current location and return parsed tibble.
#' # if the csv exist before read it and return its data.
#' drug_element(save_table = TRUE, save_csv = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in given location and
#' # return parsed tibble.
#' # if the csv exist before read it and return its data.
#' drug_element(save_csv = TRUE, csv_path = TRUE)
#'
#' # save parsed tibble as csv if it does not exist in current
#' # location and return parsed tibble.
#' # if the csv exist override it and return it.
#' drug_element(save_csv = TRUE, csv_path = TRUE, override = TRUE)
#' drug_element(c("drug_ahfs_codes", "drug_carriers"), save_table = TRUE)
#' drug_element(save_table = FALSE)
#' drug_element(c("drug_ahfs_codes", "drug_carriers"))
#' }
#' @export
drug_element <-
  function(elements_options = c("all"),
           save_table = FALSE,
           save_csv = FALSE,
           csv_path = ".",
           override_csv = FALSE) {
    check_data_and_connection(save_table)
    if (!all(elements_options %in% drug_element_options())) {
      stop("invalid options\nplease use drug_element_options() to
           know valid options")
    }

    if ("all" %in% elements_options) {
      return(drug_all(save_table = save_table))
    }
    parsed_list <- list()
    for (option in elements_options) {
      parsed_element <- switch(
        option,
        "drugs" = drug(save_table, save_csv, csv_path, override_csv),
        "affected_organisms_drug" = drug_affected_organisms(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "ahfs_codes_drug" = drug_ahfs_codes(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "articles_drug" = drug_articles(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "atc_codes_drug" = drug_atc_codes(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "books_drug" = drug_books(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "carriers_drug" = carriers(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "actions_carrier_drug" = carriers_actions(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "articles_carrier_drug" = carriers_articles(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "links_carrier_drug" = carriers_links(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "polypeptides_carrier_drugs" = carriers_polypeptide(
          save_table, save_csv, csv_path, override_csv
        ),
        "carr_poly_ext_identity" =
          carriers_polypeptide_ext_identity(
            save_table,
            save_csv,
            csv_path,
            override_csv
          ),
        "carr_polypeptides_go" =
          carriers_polypeptidepeptides_go(
            save_table,
            save_csv,
            csv_path,
            override_csv
          ),
        "carr_polypeptides_pfams" =
          carriers_polypeptidepeptides_pfams(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "carr_polypeptides_syn" =
          carriers_polypeptidepeptides_syn(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "textbooks_carrier_drug" = carriers_textbooks(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "categories_drug" = carriers(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "classifications_drug" = drug_classification(
          save_table, save_csv,
          csv_path,
          override_csv
        ),
        "dosages_drug" = drug_dosages(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "enzymes_drug" = enzymes(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "actions_enzyme_drug" = enzymes_actions(
          save_table, save_csv,
          csv_path,
          override_csv
        ),
        "articles_enzyme_drug" = enzymes_articles(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "links_enzyme_drug" = enzymes_links(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "polypeptides_enzyme_drug" =
          enzymes_polypeptide(
            save_table, save_csv, csv_path,
            override_csv
          ),
        "enzy_poly_ext_identity" =
          enzymes_polypeptide_ext_ident(
            save_table,
            save_csv,
            csv_path,
            override_csv
          ),
        "enzy_poly_go" =
          enzymes_polypeptide_go(
            save_table, save_csv,
            csv_path,
            override_csv
          ),
        "pfams_polypeptides_enzyme_drug" =
          enzymes_polypeptide_pfams(
            save_table, save_csv, csv_path,
            override_csv
          ),
        "enzy_poly_syn" =
          enzymes_polypeptide_syn(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "textbooks_enzyme_drug" = enzymes_textbooks(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "experimental_properties_drug" =
          drug_exp_prop(
            save_table, save_csv, csv_path,
            override_csv
          ),
        "external_identifiers_drug" = drug_ex_identity(
          save_table, save_csv, csv_path, override_csv
        ),
        "external_links_drug" = drug_external_links(
          save_table, save_csv,
          csv_path,
          override_csv
        ),
        "food_interactions_drug" = drug_food_interactions(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "groups_drugs" = drug_groups(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "interactions_drug" = drug_interactions(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "links_drug" = drug_interactions(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "manufacturers_drug" = drug_manufacturers(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "mixtures_drug" = drug_mixtures(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "packagers_drug" = drug_packagers(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "patents_drugs" = drug_patents(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "pathways_drug" = drug_pathway(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "drugs_pathway_drug" = drug_pathway_drugs(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "enzymes_pathway_drug" = drug_pathway_enzyme(
          save_table, save_csv,
          csv_path,
          override_csv
        ),
        "pdb_entries_drug" = drug_pdb_entries(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "prices_drug" = drug_prices(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "products_drug" = drug_products(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "reactions_drugs" = drug_reactions(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "enzymes_reactions_drug" = drug_reactions_enzymes(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "sequences_drug" = drug_sequences(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "snp_adverse_reactions" =
          drug_snp_adverse_reactions (
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "snp_effects_drug" = drug_snp_effects(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "syn_drug" = drug_syn(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "targ_drug" = targets(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "actions_target_drug" = targets_actions(
          save_table, save_csv,
          csv_path,
          override_csv
        ),
        "articles_target_drug" = targets_articles(
          save_table,
          save_csv, csv_path,
          override_csv
        ),
        "links_target_drug" = targets_links(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "polypeptide_target_drug" =
          targets_polypeptide(
            save_table, save_csv, csv_path,
            override_csv
          ),
        "targ_poly_ext_identity" =
          targets_polypeptide_ext_ident(
            save_table,
            save_csv,
            csv_path,
            override_csv
          ),
        "targ_poly_go" =
          targets_polypeptide_go(
            save_table,
            save_csv,
            csv_path,
            override_csv
          ),
        "pfams_polypeptide_target_drug" =
          targets_polypeptide_pfams(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "targ_poly_syn" =
          targets_polypeptide(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "textbooks_target_drug" = targets_textbooks(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "transporters_drug" = transporters(
          save_table, save_csv,
          csv_path, override_csv
        ),
        "actions_transporter_drug" =
          transporters_actions(
            save_table, save_csv, csv_path,
            override_csv
          ),
        "articles_transporter_drug" = targets_articles(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "links_transporter_drug" = transporters_links(
          save_table,
          save_csv,
          csv_path,
          override_csv
        ),
        "polypeptides_transporter_drug" =
          enzymes_polypeptide(
            save_table, save_csv, csv_path,
            override_csv
          ),
        "trans_poly_ex_identity" =
          transporters_polypep_ex_ident(
            save_table, save_csv, csv_path, override_csv
          ),
        "go_polypeptide_trans_drug" =
          transporters_polypeptide_go(
            save_table,
            save_csv,
            csv_path,
            override_csv
          ),
        "trans_poly_pfams" =
          transporters_polypeptide_pfams(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "trans_poly_syn" =
          transporters_polypeptide_syn(
            save_table,
            save_csv, csv_path,
            override_csv
          ),
        "textbooks_transporter_drug" = transporters_textbooks(
          save_table, save_csv, csv_path, override_csv
        ),
        "international_brands_drug" = drug_intern_brand(
          save_table, save_csv, csv_path, override_csv
        ),
        "salts_drug" = drug_salts(
          save_table, save_csv, csv_path,
          override_csv
        ),
        "culculated_properties_drug" = drug_calc_prop(
          save_table, save_csv, csv_path, override_csv
        )
      )
      parsed_list[[option]] <- parsed_element
      message(paste("parsed", option))
    }
    return(parsed_list)
  }

#' returns \code{drug_element} valid options.
#'
#' @return list of \code{drug_element} valid options
#' @family common
#' @examples
#' \dontrun{
#' drug_element_options()
#' }
#' @export
drug_element_options <- function() {
  elements_options <-
    c(
      "all",
      "drugs",
      "groups_drug",
      "articles_drug",
      "books_drug",
      "links_drug",
      "syn_drug",
      "products_drug",
      "culculated_properties_drug",
      "mixtures_drug",
      "packagers_drug",
      "categories_drug",
      "affected_organisms_drug",
      "dosages_drug",
      "ahfs_codes_drug",
      "pdb_entries_drug",
      "patents_drug",
      "food_interactions_drug",
      "interactions_drug",
      "experimental_properties_drug",
      "external_identifiers_drug",
      "external_links_drug",
      "snp_effects_drug",
      "snp_adverse_reactions",
      "atc_codes_drug",
      "actions_carrier_drug",
      "articles_carrier_drug",
      "textbooks_carrier_drug",
      "links_carrier_drug",
      "polypeptides_carrier_drug",
      "carr_poly_ext_identity",
      "carr_polypeptides_syn",
      "carr_polypeptides_pfams",
      "carr_polypeptides_go",
      "carriers_drug",
      "classifications_drug",
      "actions_enzyme_drug",
      "articles_enzyme_drug",
      "textbooks_enzyme_drug",
      "links_enzyme_drug",
      "polypeptides_enzyme_drug",
      "enzy_poly_ext_identity",
      "enzy_poly_syn",
      "pfams_polypeptides_enzyme_drug",
      "enzy_poly_go",
      "enzymes_drug",
      "manufacturers_drug",
      "enzymes_pathway_drug",
      "drugs_pathway_drug",
      "pathways_drug",
      "prices_drug",
      "reactions_drug",
      "enzymes_reactions_drug",
      "sequences_drug",
      "targ_poly_ext_identity",
      "targ_poly_syn",
      "pfams_polypeptide_target_drug",
      "targ_poly_go",
      "actions_target_drug",
      "articles_target_drug",
      "textbooks_target_drug",
      "links_target_drug",
      "polypeptide_target_drug",
      "targ_drug",
      "actions_transporter_drug",
      "articles_transporter_drug",
      "textbooks_transporter_drug",
      "links_transporter_drug",
      "polypeptides_transporter_drug",
      "trans_poly_ex_identity",
      "trans_poly_syn",
      "trans_poly_pfams",
      "go_polypeptide_trans_drug",
      "transporters_drug",
      "international_brands_drug",
      "salts_drug"
    )
  return(elements_options)
}
