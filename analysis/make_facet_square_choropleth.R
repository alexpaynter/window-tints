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
    lbl_size = 2,
    radius = grid::unit(0, "pt")
  ) + 
  coord_equal() +
  scale_fill_distiller(
    name = "Visible Light Transmission (%)", 
    palette = "Greys",
    guide = guide_legend(theme = theme(
      legend.direction = "horizontal",
      legend.title.position = "top",
      legend.text.position = "bottom",
      #legend.text = element_text(hjust = 0.5, vjust = 1, angle = 90)
    ))
  ) +
  facet_wrap(vars(part_disp), nrow = 1) +
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
  width = 8,
  height = 4
)
ggsave(
  gg_tints,
  filename = here('output', 'gg_square_choro.pdf'),
  width = 8,
  height = 4
)
  