# bbplot-first
Learning to use bbplot (BBC style for ggplot charts) via the [BBC Visual and Data Journalism cookbook](https://bbc.github.io/rcookbook/)

## How to plot a line graph with annotations

I plotted tourist arrivals to Sri Lanka per month after the Easter 2019 terror attacks compared to a year earlier.

Here's what it looks like:

![Final bbplot line graph](https://github.com/veronikahalamkova/bbplot-first/blob/master/bbplot_sl.png)

(The custom-made annotations are my fav part!)

And this is how I did it:

```
# Load all the packages
library(tidyverse)

pacman::p_load('dplyr', 'tidyr',
               
               'ggplot2',  'ggalt',
               
               'forcats', 'R.utils', 'png', 
               
               'grid', 'ggpubr', 'scales',
               
               'bbplot')

# Name and reorder months of the year
tourism_ordered <- SriLanka_tourism %>% mutate(month = factor(month, 
                                                levels = c("Jan", "Feb", "Mar", "Apr", 
                                                           "May", "Jun", "Jul", "Aug", 
                                                           "Sep", "Oct", "Nov", "Dec"),
                                                ordered = TRUE))

#Here goes the final plot
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
        
# DONT'T FORGET TO FINALIZE - also time to include data source
  finalise_plot(plot_name = tourism_plot,
                source = "Source: Sri Lanka Tourism Development Authority",
                save_filepath = "tourism_linegraph_finalised.png",
                width_pixels = 1000,
                height_pixels = 600)
```
