library('tidyr')
library('shiny')

source('analysis.R')

my_server <- function(input, output) {
  
  output$mens_budget_plot <- renderPlot({
    preg_budget_filtered_df <- preg_budget_df %>% 
      filter(budget<=input$menstrual_budget_slider)
    mens_budget_reactive_plot <- ggplot(data=preg_budget_filtered_df, 
                                        mapping=(aes_string(x="budget", 
                                                            y="mens_comp"))) +
      geom_point(size=2) +
      geom_text(
        label=preg_budget_filtered_df$State,
        nudge_y=-.5
      ) +
      labs(
        title = 'Menstrual Complications Against Budget',
        x = 'Budget',
        y = 'Percent Complications'
      )
    return(mens_budget_reactive_plot)
  })
  output$overall_budget_plot <- renderPlot({
    big_filtered_preg_budget_df <- preg_budget_df %>% 
      filter(budget<=input$overall_budget_slider)
    overall_budget_reactive_plot <- ggplot(data=big_filtered_preg_budget_df, 
                                           mapping=(aes_string(x="budget", y="preg_comp"))) +
      geom_point(size=2) +
      geom_text(
        label=big_filtered_preg_budget_df$State,
        nudge_y=-.5
      ) +
      labs(
        title = 'Overall Pregnancy Complications Against Budget',
        x = 'Budget',
        y = 'Percent Complications'
      )
    return(overall_budget_reactive_plot)
  })
}
