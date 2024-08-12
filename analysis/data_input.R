library(tibble)
library(readr)
library(here)

# Just doing a manual input - it's only 50 states.
# Source: https://www.raynofilm.com/blog/automotive-window-tint-laws-by-state

dft_state <- tibble::tribble(
  # side = back side.  All numbers are percentages.
  # allowing any tint is coded as 0 (complete dark).
  ~state, ~front, ~side, ~rear,
  'AL', 32, 32, 32,
  'AK', 70, 40, 40,
  'AZ', 33, 0, 0,
  'AR', 25, 25, 10,
  'CA', 70, 0, 0,
  'CO', 27, 27, 27,
  'CT', 35, 35, 0,
  'DE', 70, 0, 0,
  'FL', 28, 15, 15,
  'GA', 32, 32, 32,
  'HI', 35, 35, 35,
  'ID', 35, 20, 35,
  'IL', 35, 35, 35,
  'IN', 30, 30, 30,
  'IA', 70, 0, 0,
  'KS', 35, 35, 35,
  'KY', 35, 18, 18,
  'LA', 40, 25, 12,
  'ME', 35, 0, 0,
  'MD', 35, 35, 35,
  'MA', 35, 35, 35,
  # michigan only lets tint 4" from top in front, 
  #   so most of the window is required to have no tint
  'MI', 100, 0, 0,
  'MN', 50, 50, 50,
  'MS', 28, 28, 28,
  'MO', 35, 0, 0,
  'MT', 24, 14, 14,
  'NE', 35, 20, 20,
  'NV', 35, 0, 0,
  'NH', 100, 35, 35,
  'NJ', 100, 0, 0,
  'NM', 20, 20, 20,
  'NY', 70, 70, 0,
  'NC', 35, 35, 35,
  'ND', 50, 0, 0,
  'OH', 50, 0, 0,
  'OK', 25, 25, 25,
  'OR', 35, 35, 35,
  'PA', 70, 70, 70,
  'RI', 70, 70, 70,
  'SC', 27, 27, 27,
  'SD', 35, 20, 20,
  'TN', 35, 35, 35,
  'TX', 25, 25, 0,
  'UT', 43, 0, 0,
  'VT', 100, 0, 0,
  'VA', 50, 35, 35,
  'WA', 24, 24, 24,
  # DC allows 35% for "multi-purpose vehicles" and 50 for cars.
  # Why driving an SUV gets you special window tint privilege 
  # is unclear, but that's the number I used. 
  'DC', 70, 35, 35,
  'WV', 35, 35, 35,
  'WI', 50, 35, 35,
  'WY', 28, 28, 28
)

readr::write_rds(
  dft_state,
  here('data', 'state_tint.rds')
)
