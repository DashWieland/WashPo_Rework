library(ggplot2)
library(tidyverse)

poll <- tibble::tribble(
       ~Candidate, ~Mean, ~NoPref, 
  "No Preference",  0.54, T,
          "Biden",  0.13, F,
        "Sanders",  0.09, F,
      "Buttigieg",  0.05, F,
         "Harris",  0.04, F,
         "Warren",  0.04, F,
       "O'Rourke",  0.03, F
  )

ggplot(poll,
       aes(
         x = fct_reorder(Candidate, Mean),
         y = Mean,
         fill = NoPref
       )) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values=c('tomato', 'skyblue4')) + 
  geom_errorbar(aes(ymin = pmax(Mean - 0.055, 0),
                    ymax = Mean + 0.055),
                width = .2,
                position = position_dodge(.9)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) + 
  geom_label(aes(label = scales::percent(Mean),
                 fill = NoPref),
             color = "white") +
  coord_flip() +
  labs(title = "Preference for Democratic presidential nomination",
       subtitle = "Note: Candidates with 1 percent support or less not shown.",
       caption = "Washington Post-ABC News poll April 22-25, 2019, sample size 427 \nDemocrats and Democratic-leaning Independents contacted by phone",
       x = "Candidate",
       y = NULL) + 
  theme(legend.position = "none", 
        panel.grid.major = element_line(linetype = "blank"),
        panel.grid.minor = element_line(linetype = "blank"),
        panel.background = element_rect(fill = "gray97"),
        plot.background = element_rect(fill = "gray97"))

ggsave("poll.png")
