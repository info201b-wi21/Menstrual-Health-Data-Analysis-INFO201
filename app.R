library('shiny')
library('dplyr')
library('ggplot2')

source('my_ui.R')
source('my_server.R')

shinyApp(ui = my_ui, server = my_server)
