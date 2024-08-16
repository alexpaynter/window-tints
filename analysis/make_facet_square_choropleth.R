# The easiest, laziest idea I had for a visualization.

library(statebins)
# library(cdcfluview)
library(hrbrthemes)
library(tidyverse)
library(patchwork)

dft_state <- readr::read_rds(
  here('data', 'state_tint.rds')
)

dft_state <- dft_state |>
  mutate(
    abs_diff_side_rear = abs(side - rear),
    side_rear = pmax(side, rear)
  )
# How many states even have different side and rear numbers?
dft_state |> filter(abs_diff_side_rear > 0)

dft_state_long <- dft_state %>%
  select(state, front, side_rear) %>%
  pivot_longer(
    cols = -state,
    names_to = "part",
    values_to = "tint_pct"
  )

# Facetting didn't work with this package, so we repeat.
gg_front <-
  statebins(
    dft_state,
    value_col = "front", 
    name = "Visible light transmission (%)",
    ggplot2_scale_function = ggplot2::scale_fill_distiller,
    palette = "Greys"
  ) +
  labs(title = "Front") +
  theme_statebins() 

gg_back <- 
  statebins(
    dft_state,
    value_col = "side_rear", 
    name = "Visible light transmission (%)",
    ggplot2_scale_function = ggplot2::scale_fill_distiller,
    palette = "Greys"
  ) +
  labs(title = "Side/Rear") +
  theme_statebins() 


gg_comb <- gg_front + gg_back & theme(legend.position = 'bottom')
gg_comb <- gg_comb + plot_layout(guides = "collect")

gg_tints <- 
  ggplot(
    dft_state_long,
    aes(state = state,
        fill = tint_pct)
  ) + 
  geom_statebins(
    lbl_size = 3,
    radius = grid::unit(0, "pt")
  ) + 
  coord_equal() +
  scale_fill_distiller(palette = "Greys") +
  facet_wrap(vars(part), nrow = 1) +
  theme_statebins()

gg_tints
  
  
  
  
  
  
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


# gg_comb <- ggpubr::ggarrange(
#   gg_front,
#   gg_back,
#   nrow = 1,
#   common.legend = T,
#   legend = "bottom"
# )

ggsave(
  gg_comb,
  filename = here('output', 'gg_square_choro.pdf'),
  width = 8,
  height = 4
)
  
)