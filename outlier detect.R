outlier_detect <- function(data){

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

  upper_outlier_condition <- if(any(data %>% na.omit() > upper_outlier) == TRUE){

    message("upper outlier: TRUE")

    print(data %>%
            as.data.frame %>%
            dplyr::filter(data > summarised_data[5]) %>%
            dplyr::filter(. > upper_outlier) %>%
            arrange(`.`) %>%
            dplyr::pull() %>%
            as.numeric())

  } else {

    message("upper outlier: FALSE")

  }

  lower_outlier_condition <- if(any(data %>% na.omit() < lower_outlier) == TRUE) {

    message("lower outlier: TRUE")

    print(data %>%
            as.data.frame %>%
            dplyr::filter(data < summarised_data[2]) %>%
            dplyr::filter(. < lower_outlier) %>%
            arrange(`.`) %>%
            dplyr::pull() %>%
            as.numeric())

  } else {

    message("lower outlier: FALSE")

  }
}
