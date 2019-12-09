#' @name clean_wiki_names
#' @title clean_wiki_names
#' @importFrom dplyr %>%
#' @param wiki_table A dataframe for which the column names will be cleaned
#' @param ... passes arguments to janitor::clean_names()
#' @return Cleaned dataframe
#' @export

clean_wiki_names <- function(wiki_table, ...) {
  # remove footnotes (which are in brackets) from column names
  names(wiki_table) <- stringr::str_remove_all(names(wiki_table), "\\[.*]")
  # remove "(s)" from column names
  names(wiki_table) <- stringr::str_remove_all(names(wiki_table), "\\(s\\)")
  # remove special characters from column names
  names(wiki_table) <- stringr::str_replace_all(names(wiki_table), "[^a-zA-Z0-9 ]", "_")
  # convert to snake case
  wiki_table <- wiki_table %>% janitor::clean_names(...)

  return(wiki_table)
}


#' @name add_na
#' @title add_na
#' @param wiki_table A dataframe
#' @param to_na A character string that when solitary in a dataframe cell is to be converted to NA. Default is "".
#' @param special_to_na A boolean denoting whether solitary special characters in dataframe cells are to be converted to NA. Default is TRUE.
#' @return Cleaned dataframe
#' @export

add_na <- function(wiki_table, to_na = "", special_to_na = TRUE){
  #converts specified characters to NA
  wiki_table <- as.data.frame(map(wiki_table, function(x){is.na(x) <- which(x %in% c("", to_na));x}))

  if(special_to_na){
    #converts solitary special characters to NA
    wiki_table <- as.data.frame(map(wiki_table, function(x){is.na(x) <- which(stringr::str_detect(x, "\\A[^a-zA-Z0-9]{1}$"));x}))
  }

  return(wiki_table)
}


#' @name clean_rows
#' @title clean_rows
#' @importFrom dplyr %>%
#' @param wiki_table A dataframe for which the rows will be cleaned
#' @return Cleaned dataframe
#' @export

clean_rows <- function(wiki_table){
  # wiki_table <- wiki_table %>%
  #   dplyr::mutate_all(as.character)
  #
  # i <- 1
  #
  # while(i <= nrow(wiki_table)){
  #   if(colnames(wiki_table) == wiki_table[i,]){
  #     wiki_table <- wiki_table[-c(i),]
  #     i <- i-1
  #   }
  #   i <- i+1
  # }
  return(wiki_table)
}