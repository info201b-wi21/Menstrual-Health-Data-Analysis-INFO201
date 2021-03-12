library('tidyr')
library('shiny')

source('analysis.R')

my_server <- function(input, output) {
  
  ## PLOT FOR ANALYSIS QUESTION 3
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
      ) +
      theme(text = element_text(size = 17))
    return(mens_budget_reactive_plot)
  })
  
  output$reactive_description_q3 <- renderText({
    preg_budget_filtered_df <- preg_budget_df %>% 
      filter(budget<=input$menstrual_budget_slider)
    paste("When the max budget is ", input$menstrual_budget_slider, ", there is an 
          average complication percentage of ", round(mean(preg_budget_filtered_df$mens_comp), 2), "%.")
  })
  
  ##PLOT FOR ANALYSIS QUESTION 4
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
      ) +
      theme(text = element_text(size = 17))
    return(overall_budget_reactive_plot)
  })
  
  output$reactive_description_q4 <- renderText({
    big_filtered_preg_budget_df <- preg_budget_df %>% 
      filter(budget<=input$overall_budget_slider)
    paste("When the max budget is ", input$overall_budget_slider, ", there is an 
          average complication percentage of ", round(mean(big_filtered_preg_budget_df$preg_comp), 2), "%.")
    })

  
  ## PLOT FOR ANALYSIS QUESTION 1
  
  output$analysis_q1 <- renderPlot({
    q1_data <- preg_comp_by_state_df %>% 
      filter(Complications == input$comp)
    
    plot <- ggplot(data=q1_data, mapping=aes(x=States, y=value, fill=States)) +
      geom_col(width=1, position="dodge", color="black") +
      theme(legend.position= "none") +
      labs(title = "Distribution of Pregnancy Complications by State",
           x = "States",
           y = "% Women Reporting") + 
      theme(axis.text.x = element_text(angle = 90)) +
      theme(text = element_text(size = 17))
    
    return(plot)
  })
  
  output$reactive_description_q1 <- renderText({
    q1_data <- preg_comp_by_state_df %>% 
      filter(Complications == input$comp)
    comp_type <-
      switch(input$comp,
             'any_delivery_comp' = 'any delivery complication',
             'any_post_delivery_comp' = 'any post delivery complication',
             'preg_comp' = 'any pregnancy complication',
             'vag_discharge_comp' = 'any vaginal complication',
             'menstrual_related_comp' = 'any menstrual complication')
    paste("For ", comp_type, ", the maximum percentage of complications is ", 
          max(q1_data$value), "% of women.", sep='')
  })
  
  
  ## PLOT FOR ANALYSIS QUESTION 2
  output$analysis_q2 <-renderPlot({
    
    q2_data <- menstrual_budget_df %>% 
      select(States,input$year)
    
    plot <- ggplot(data=q2_data, aes(x="", y=pull(q2_data,input$year), fill=States)) +
      geom_bar(stat = 'identity', color="black") +
      coord_polar('y', start=0) +
      theme_void() +
      labs(
        title = paste('Distribution of State Menstrual Health Budget in ', input$year)
      ) +
      theme(text = element_text(size = 17))
    return(plot)
  })
  
  output$reactive_description_q2 <- renderText({
    q2_data <- menstrual_budget_df %>% 
      filter(get(input$year) == max(get(input$year))) %>% 
      select(States)

    
    
    paste('For the year of ', input$year, ', the state that spent the most',
          ' on menstrual health was ', q2_data$States, '.', sep='')
  })
  
}
