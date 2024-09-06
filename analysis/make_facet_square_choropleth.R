# The easiest, laziest idea I had for a visualization.

library(statebins)
# library(cdcfluview)
library(hrbrthemes)
library(tidyverse)
library(patchwork)
library(here)
library(ggplot2)

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
  ) %>%
  mutate(
    part_disp = case_when(
      part %in% "front" ~ "Front",
      part %in% "side_rear" ~ "Rear/Side"
    )
  ) 

gg_tints <- 
  ggplot(
    dft_state_long,
    aes(state = state,
        fill = tint_pct)
  ) + 
  geom_statebins(
    lbl_size = 1.5,
    radius = grid::unit(0, "pt")
  ) + 
  coord_equal() +
  scale_fill_distiller(
    name = "Visible Light Transmission (%)", 
    palette = "Greys",
    guide = guide_legend(
      title.position = "top",
      label.position = "bottom", 
      keywidth = grid::unit(0.3, "inch"),
      keyheight = grid::unit(0.3/2.5, "inch")
    )
    #legend.text = element_text(hjust = 0.5, vjust = 1, angle = 90)
  ) +
  facet_wrap(vars(part_disp), ncol = 1) +
  # theme_statebins()
  theme_bw() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )
#  theme_statebins()
  
gg_tints


ggsave(
  gg_tints,
  filename = here('output', 'gg_square_choro.svg'),
  width = 3.5, 
  height = 5
)

ggsave(
  gg_tints,
  filename = here('..', 'ap-site', 'static', 'posts', 'window_tints_square_choro.svg'),
  width = 3.5, 
  height = 5
)
