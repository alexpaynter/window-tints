install.packages('statebins')

library(statebins)
# remotes::install_github("hrbrmstr/cdcfluview")
library(cdcfluview)
library(hrbrthemes)
library(tidyverse)



adat <- read_csv(
  system.file('extdata', 'wapostates.csv', 
              package = 'statebins')
)

mutate(
  adat, 
  share = cut(avgshare94_00, breaks = 4, labels = c("0-1", "1-2", "2-3", "3-4"))
) %>% 
  # Making it clear that we only need two columns:
  select(state, share) %>%
  # Showing what happens when we remove an obvious state:
  filter(!(state %in% "Maine")) %>%
  statebins(
    value_col = "share", 
    ggplot2_scale_function = scale_fill_brewer,
    name = "Share of workforce with jobs lost or threatened by trade"
  ) +
  labs(title = "1994-2000") +
  theme_statebins()

flu <- ili_weekly_activity_indicators(2017)

# Can't read this - too much text.  Just show me 5:
flu <- flu |> 
  filter(weekend %in% sample(unique(flu$weekend), 2))

ggplot(flu, aes(state=statename, fill=activity_level)) +
  geom_statebins(
    lbl_size = 3,
    radius = grid::unit(0, "pt")
  ) +
  coord_equal() +
  viridis::scale_fill_viridis(
    name = "ILI Activity Level  ", limits=c(0,10), breaks=0:10, option = "magma", direction = -1
  ) +
  facet_wrap(~weekend) +
  theme_statebins() + 
  labs(title="2017-18 Flu Season ILI Activity Level") +
  theme(plot.title=element_text(size=16, hjust=0)) +
  theme(plot.margin = margin(30,30,30,30))
