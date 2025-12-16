library(hexSticker)

imgurl <- "C:/Users/zxu567/Documents/R/sia.project.1.wi.shiny/test/app/www/SiA_logo_square_icon_transp.png"

sticker(
  imgurl,
  package  = "SiA-WD",
  p_size   = 28,
  p_color  = "#f15a29",       # SiA orange
  s_x      = 1,
  s_y      = 0.75,
  s_width  = 0.6,
  p_y      = 1.25,            # << moves text UP, near center
  h_fill   = "#FFFFFF",       # white background
  h_color  = "#1c75bc",       # SiA blue border
  white_around_sticker = TRUE,
  filename = "inst/figures/imgfile.png"
)

