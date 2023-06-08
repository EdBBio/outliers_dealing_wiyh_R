outlier_percent <- function(data){

  if(require("tidyverse") == TRUE){

    library(tidyverse)

  } else {

    install.packages("tidyverse")

    library(tidyverse)

  }

  summarised_data <- summary(data)

  interquartil_space <- (summarised_data[5] - summarised_data[2]) * 1.5

  upper_outlier <- summarised_data[5] + interquartil_space

  lower_outlier <- summarised_data[2] - interquartil_space

  upper_outliers <- data %>%
    as.data.frame %>%
    dplyr::filter(data > summarised_data[5]) %>%
    dplyr::filter(. > upper_outlier) %>%
    arrange(`.`) %>%
    dplyr::pull() %>%
    as.numeric()


  lower_outliers <- data %>%
    as.data.frame %>%
    dplyr::filter(data < summarised_data[2]) %>%
    dplyr::filter(. < lower_outlier) %>%
    arrange(`.`) %>%
    dplyr::pull() %>%
    as.numeric()

  upper_paste <- paste0(upper_outliers, collapse = ", ")

  lower_paste <- paste0(lower_outliers, collapse = ", ")

  if(upper_outliers %>% length() > 0 & lower_outliers %>% length() > 0){

    message("percentage of upper oultiers values count by vector count")

    str_glue("{(upper_outliers %>% length() / data %>% length()) * 100}%") %>% print()

    message("percentage of lower oultiers values count by vector count")

    str_glue("{(lower_outliers %>% length() / data %>% length()) * 100}%") %>% print()

  } else if(upper_outliers %>% length() > 0 & lower_outliers %>% length() == 0){

    message("percentage of upper oultiers values count by vector count")

    str_glue("{(upper_outliers %>% length() / data %>% length()) * 100}%") %>% print()

  } else if(upper_outliers %>% length() == 0 & lower_outliers %>% length() > 0){

    message("percentage of lower oultiers values count by vector count")

    str_glue("{(lower_outliers %>% length() / data %>% length()) * 100}%") %>% print()

  } else {

    message("No outliers has been detected")

  }

}
