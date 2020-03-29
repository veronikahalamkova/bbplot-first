library(tidyverse)
library(ggplot2)

pacman::p_load('dplyr', 'tidyr',
               
               'ggplot2',  'ggalt',
               
               'forcats', 'R.utils', 'png', 
               
               'grid', 'ggpubr', 'scales',
               
               'bbplot')


tourism_ordered <- SriLanka_tourism %>% mutate(month = factor(month, 
                                                levels = c("Jan", "Feb", "Mar", "Apr", 
                                                           "May", "Jun", "Jul", "Aug", 
                                                           "Sep", "Oct", "Nov", "Dec"),
                                                ordered = TRUE))


tourism_plot <- ggplot(data=tourism_ordered, aes(x=month, y=value, group=year, color=year)) +
  geom_line(size=2) +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  scale_colour_manual(values = c("#FAAB18", "#1380A1")) +
  labs(title="Tourism near recovery after terror attacks",
       subtitle = "Number of tourist arrivals in Sri Lanka per month") +
  bbc_style() +
  geom_label(aes(x = "Jan", y = 150000, label = "Easter bombings\non 21st April 2019"), 
               hjust = 0, 
               vjust = 0.5, 
               colour = "#555555", 
               fill = "white", 
               label.size = NA, 
               family="Helvetica", 
               size = 6) +
  geom_curve(aes(x = "Feb", y = 170000, xend = "Mar", yend = 198000), 
             colour = "#555555", 
             curvature = -0.2,
             size=0.8) +
  geom_label(aes(x = "Sep", y = 60000, label = "Free visa scheme introduced\non 1st August 2019"), 
             hjust = 0, 
             vjust = 0.5, 
             colour = "#555555", 
             fill = "white", 
             label.size = NA, 
             family="Helvetica", 
             size = 6) +
  geom_curve(aes(x = "Aug", y = 120000, xend = "Sep", yend = 65000), 
             colour = "#555555", 
             curvature = 0.2,
             size=0.8) +
  theme(legend.position = c(0.9,0.1),
        legend.direction = "horizontal")

  finalise_plot(plot_name = tourism_plot,
                source = "Source: Sri Lanka Tourism Development Authority",
                save_filepath = "tourism_linegraph_finalised.png",
                width_pixels = 1000,
                height_pixels = 600)
