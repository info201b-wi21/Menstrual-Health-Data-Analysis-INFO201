library('tidyr')

source('analysis.R')

my_server <- function(input, output) {
  
  #
  output$analysis_q1 <- renderPlot({
    q1_data <- preg_comp_by_state_df %>% 
      filter(Complications == input$comp)
    
    plot <- ggplot(data=q1_data, mapping=aes(x=States, y=value)) +
      geom_col(width=1, position="dodge") +
      labs(title = "Distribution of Pregnancy Complications by State",
           x = "States",
           y = "% Women Reporting") + 
      scale_fill_brewer(palette="Dark2") +
      theme(axis.text.x = element_text(angle = 90))
    
    plot
  })
  
  # Plot for analysis question 2
  output$analysis_q2 <-renderPlot({
    
    q2_data <- menstrual_budget_df %>% 
      select(States,input$year)
    
    plot <- ggplot(data=q2_data, aes(x="", y=pull(q2_data,input$year), fill=States)) +
      geom_bar(stat = 'identity') +
      coord_polar('y', start=0) +
      theme_void() +
      labs(
        title = paste('Distribution of State Menstrual Health Budget in ', input$year)
      )
    plot
  })
}
