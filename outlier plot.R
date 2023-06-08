outlier_plot <- function(data){

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

    data2 <- data %>%
      as.data.frame() %>%
      mutate(vetor = "vector")

    colnames(data2) <- c("Values", "Vector")

    data2 <- data2 %>%
      mutate(Classification = case_when(Values %in% upper_outliers ~ "Upper Outliers",
                                        Values %in% lower_outliers ~ "Lower Outliers",
                                        .default = "Normal Values"),
             Classification = Classification %>% fct_relevel("Upper Outliers", "Normal Values", "Lower Outliers"))

    data2 %>%
      ggplot(aes(Vector, Values, fill = Classification))+
      geom_jitter(shape = 21, size = 5, color = "black")+
      labs(title = str_glue("Upper outliers detected: {upper_paste} \n\n Lower outliers detected: {lower_outliers}"),
           x = NULL)+
      scale_fill_manual(values = c("#FFBF53", "#3D3D3D", "#67FF69"))+
      theme(plot.title = ggtext::element_markdown(color = "black", size = 15, hjust = 0.75, ),
            axis.text = element_text(color = "black", size = 10),
            axis.title = element_text(color = "black", size = 10),
            panel.grid = element_line(color = "grey75", linetype = "dashed", linewidth = 0.7),
            panel.grid.minor = element_blank(),
            axis.line = element_blank(),
            plot.background = element_rect(fill = "white", color = "white"),
            panel.background = element_rect(fill ="white"),
            panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
            legend.key = element_rect(color = "white", fill = "white"),
            strip.background = element_rect(colour="black",fill="gray90"),
            strip.text.x = element_text(size = 13))

  } else if(upper_outliers %>% length() > 0 & lower_outliers %>% length() == 0){

    data2 <- data %>%
      as.data.frame() %>%
      mutate(vetor = "vector")

    colnames(data2) <- c("Values", "Vector")

    data2 <- data2 %>%
      mutate(Classification = case_when(Values %in% upper_outliers ~ "Upper Outliers",
                                        .default = "Normal Values"),
             Classification = Classification %>% fct_relevel("Upper Outliers", "Normal Values"))

    data2 %>%
      ggplot(aes(Vector, Values, fill = Classification))+
      geom_jitter(shape = 21, size = 5, color = "black")+
      labs(title = str_glue("Upper outliers detected: {upper_paste}"),
           x = NULL)+
      scale_fill_manual(values = c("#FFBF53", "#3D3D3D"))+
      theme(plot.title = ggtext::element_markdown(color = "black", size = 15, hjust = 0.75, ),
            axis.text = element_text(color = "black", size = 10),
            axis.title = element_text(color = "black", size = 10),
            panel.grid = element_line(color = "grey75", linetype = "dashed", linewidth = 0.7),
            panel.grid.minor = element_blank(),
            axis.line = element_blank(),
            plot.background = element_rect(fill = "white", color = "white"),
            panel.background = element_rect(fill ="white"),
            panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
            legend.key = element_rect(color = "white", fill = "white"),
            strip.background = element_rect(colour="black",fill="gray90"),
            strip.text.x = element_text(size = 13))

  } else if(upper_outliers %>% length() == 0 & lower_outliers %>% length() > 0){

    data2 <- data %>%
      as.data.frame() %>%
      mutate(vetor = "vector")

    colnames(data2) <- c("Values", "Vector")

    data2 <- data2 %>%
      mutate(Classification = case_when(Values %in% lower_outliers ~ "Lower Outliers",
                                        .default = "Normal Values"),
             Classification = Classification %>% fct_relevel("Normal Values", "Lower Outliers"))

    data2 %>%
      ggplot(aes(Vector, Values, fill = Classification))+
      geom_jitter(shape = 21, size = 5, color = "black")+
      labs(title = str_glue("Lower outliers detected: {lower_paste}"),
           x = NULL)+
      scale_fill_manual(values = c("#3D3D3D", "#67FF69"))+
      theme(plot.title = ggtext::element_markdown(color = "black", size = 15, hjust = 0.75, ),
            axis.text = element_text(color = "black", size = 10),
            axis.title = element_text(color = "black", size = 10),
            panel.grid = element_line(color = "grey75", linetype = "dashed", linewidth = 0.7),
            panel.grid.minor = element_blank(),
            axis.line = element_blank(),
            plot.background = element_rect(fill = "white", color = "white"),
            panel.background = element_rect(fill ="white"),
            panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
            legend.key = element_rect(color = "white", fill = "white"),
            strip.background = element_rect(colour="black",fill="gray90"),
            strip.text.x = element_text(size = 13))

  } else {

    data2 <- data %>%
      as.data.frame() %>%
      mutate(vetor = "vector")

    colnames(data2) <- c("Values", "Vector")

    data2 %>%
      ggplot(aes(Vector, Values))+
      geom_jitter(shape = 21, size = 5, color = "black", fill = "#FFBF53")+
      labs(title = "No outliers has been detected",
           x = NULL)+
      theme(plot.title = ggtext::element_markdown(color = "black", size = 15, hjust = 0.75, ),
            axis.text = element_text(color = "black", size = 10),
            axis.title = element_text(color = "black", size = 10),
            panel.grid = element_line(color = "grey75", linetype = "dashed", linewidth = 0.7),
            panel.grid.minor = element_blank(),
            axis.line = element_blank(),
            plot.background = element_rect(fill = "white", color = "white"),
            panel.background = element_rect(fill ="white"),
            panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
            legend.key = element_rect(color = "white", fill = "white"),
            strip.background = element_rect(colour="black",fill="gray90"),
            strip.text.x = element_text(size = 13))

  }

}
