source('my_server.R')
library('shiny')
budget_range <- range(preg_budget_df$budget)
my_ui <- fluidPage(
  h1(strong('Menstrual Health and Sexual Education in India')),
  em('Group G2: Kriti Vajjhula, Franchezca Layog, Ian Chandramouli, & Harmeet Singh'),
  hr(),
  tabsetPanel(
    type='tabs',
    tabPanel(title='Home',
             h2('Problem Domain Description'),
             p('Millions of women in India face great challenges to managing their menstrual 
                health and practicing menstrual hygiene. This is due to a number of enabling 
                factors present in the country\'s distribution system for products, income 
                level, and social stigma. One of the largest factors is the lack of education 
                and awareness to young women in the process of menstruation and its physiological 
                basis pre-menarche (before a young girl\'s first menstrual cycle). Another key
                issue is the availability of products to all income levels. The pricing of 
                commercial products are expensive as well as inaccessible to women in rural areas,
                who account for a significant portion of the country\'s population. Sanitation
                routines, attitudes, and most importantly, facilities, are also very underdeveloped
                across the country and limit access to functioning toilets and disposal solutions. 
                This harms working women as well as school going young women, greatly increasing 
                the gender income gap in income as well as academia.
            
                Our group is interested in delving into the sociocultural root of this problem 
                and finding correlations, insights, and potential solutions for dismantling 
                these enabling factors. We will attempt to focus on the cause of these enabling 
                factors and finding connections in data between socioeconomic backgrounds, 
                income levels, religion, caste, etc.
                
                The first existing project we found is a country landscape analysis of menstrual health 
                in India. The report seeks to understand the current state of womens\' health 
                in India and includes research from interviews from adolescent girls from rural 
                and urban areas.'),
             p("To view our group's Exploratory Report, you can find it at the following link:"),
             a("Menstrual Health & Sexual Education In India", href="https://info201b-wi21.github.io/project-franchezcalayog/index.html"),
             
             h3('Sources From Previous Projects'),
             p('The first existing project we found is a country landscape analysis of menstrual health 
                in India. The report seeks to understand the current state of womens\' health 
                in India and includes research from interviews from adolescent girls from rural 
                and urban areas.'),
             a('Menstrual Health in India - Country Landscape Analysis', href='https://www.susana.org/en/knowledge-hub/resources-and-publications/library/details/2581'),
             br(),
             
             p('The second existing project we examined studies the effect of a community-based health 
                education intervention on change in behavior, routines, and awareness in the menstrual 
                hygiene of rural adolescent girls.'),
             a('The Effect of Community-Based Health Education Intervention on Management of Menstrual Hygiene among Rural Indian Adolescent Girls', href='https://www.longwoods.com/content/19303/world-health-population/the-effect-of-community-based-health-education-intervention-on-management-of-menstrual-hygiene-among'),
             hr(),
             
             h2('Data Description'),
             h3('Percentage of Women Complication During Pregnancy Data Set'),
             a('Percentage of Women Complication During Pregnancy', href='https://data.gov.in/resources/percentage-women-who-had-any-pregnancy-complication-any-delivery-complication-any-post'),
             p('This data set describes the percentage of women who had pregnancy complications 
                according to different reasons such as menstrual related problems or delivery complications.
                The data was obtained by the Ministry of Health and Family Welfare of India. 
                The data was collected via a nationwide survey in which Women answered a variety of questions.
                This data would hopefully answer the question as to which policies are effective 
                in women\'s menstrual healthcare. This dataset provides information about 
               individual districts which can be used jointly with another dataset to answer 
               our questions.'),
             
             h3('Menstrual Hygiene Scheme Budget 2016-2020 Data Set'),
             a('Menstrual Hygiene Scheme Budget', href='https://data.gov.in/resources/stateut-wise-menstrual-hygiene-scheme-budget-approved-under-nhm-2016-17-2019-20-ministry'),
             p('The data was released by Rajya Sabha (Council of States), the upper house of the 
                Indian Parliament. The government is logically the entity responsible for proposing 
                the budget, and the data was therefore effectively generated by them. It was 
                released under the National Data Sharing and Accessibility Policy.
                This will help us identify the financial disparities in government menstrual
                health support programs by state, which can provide insight as to how attitudes 
                toward and the overall state of female menstrual health differ by state and region.')),
    
    # Analysis Q1 Tab: Dis. of Pregnancy Complications by State
    tabPanel(title='Analysis Question 1',
             sidebarLayout(
               # Controls panel - Intro of Question & User interaction
               sidebarPanel(
                 h4(strong("Distribution of Pregnancy Complications by State")),
                 p("Users may investigate the distribution of different types of
                    pregnancy complications in various states on their own. Users must simply
                    click and select one of the pregnancy complication types from the drop 
                    down menu to see the corresponding visualization."),
                 hr(),
                 selectInput(
                   inputId ="comp", 
                   label = "Complication Types:",
                   choices = c("Any Delivery Complication" = "any_delivery_comp",
                                "Any Post-delivery Complication" = "any_post_delivery_comp",
                                "Menstrual-Related Complication" = "menstrual_related_comp",
                                "Any Pregnancy Complications" = "preg_comp",
                                "Vaginal Discharge Complications" = "vag_discharge_comp")
                 ),
                 hr(),
                 helpText(em("Note: When evaluating, when adding up the various
                              pregnancy complications they exceed 100%. This leads us to conclude that the complications are not 
                              mutually exclusive, implying that a woman could have post-delivery
                              complications while also experiencing menstrual-related complications. ")),
                 br(),
                 helpText(em("The results displayed by our plot do not show a fully accurate
                             picture of the real number of complications across India, 
                             rather an aggregation of percentages."))
                ),
               
               # Main panel - Visualizations
               mainPanel(
                 h3("What is the Distribution of Pregnancy Complications by State?"),
                 br(),
                 plotOutput("analysis_q1"),
                 p("The visualization shown above shows the breakdown of 
                   complications for each recorded state. There is a positive 
                   correlation between the length of the barsand the most populous 
                   states in India. This means that there are more numbers of complications 
                   of all types within states that have higher populations, such 
                   as West Bengal, Tamil Nadu, and Karnataka."),
                 br(),
                 textOutput('reactive_description_q1')
               )
             )
    ),
              
    tabPanel(title='Analysis Question 2',
             sidebarLayout(
               # Controls panel
               sidebarPanel(
                 h4(strong("Distribution of State Menstrual Health Budget")),
                 p("Users may investigate the menstrual budget data for a selected year 
                    and see how the quanitities of spending are broken down by state. Simply
                    click and select one of the years from the drop down menu to view the
                    distribution of spending from each state for that corresponding year"),
                 hr(),
                 selectInput(
                   inputId = "year",
                   label = "Select Year:",
                   choices = c("2016-17" = "2016-17", "2017-18" = "2017-18", 
                               "2018-19" = "2018-19", "2019-20" = "2019-20" )
                 ),
                 hr(),
                 helpText(em("Note: A stipulation of the data set is that
                              the graph does not accurately representative of the entire 
                              population of India. There is ambiguity as to whether 
                              some regions listed in the data set are states versus 
                              cities. Additionally, there is the exclusion of some states."))
               ),
                 
               # Main panel
               mainPanel(
                 h3("What does the distribution of the menstrual health budget look 
                    like across different states in the data set?"),
                 br(),
                 plotOutput("analysis_q2"),
                 p("Originally when our group did our investigation, we chose to analyze
                   the distribution of the health budgeth acorss the various states in the
                   data set in only the year 2019-20. This was the year with the least 
                   missing data. From that year, we noticed that The most prominent 
                   outlier is the state of Rajasthan because they provided the largest 
                   spending budget, but it was also the state's only entry in the 
                   data frame. In the end, we can not confidently answer our analysis 
                   question without more sufficient data from a wider sample of India's population."),
                 br(),
                 textOutput('reactive_description_q2')
               )
             )
    
    ),
    
    tabPanel(title='Analysis Question 3',
             sidebarLayout(
               # Controls panel
               sidebarPanel(
                 h4(strong("Menstrual Complications Against Budget")),
                 
                 p("Each point on this graph represents a state, showing the state's
                   budget and the percentage of women in that state who reported
                   experiencing menstrual health complications. Simply adjust the slider to
                   control which states are displayed on the graph. The state whose budgets are
                   at or below the position of the slider will be shown."),
                 
                 br(),
                 
                 sliderInput(inputId="menstrual_budget_slider", 
                             label="Choose Max Budget",
                             min= 0,
                             max = 700,
                             value = 400),
                 
                 br(),
                 
                 em("NOTE: There were many states for which there was no data, and only 11 of the 
                    states in India are displayed here as a result.")
               ),
               
               
               # Main panel
               mainPanel(
                 h4("How does the amount of each state's budget impact the percentage 
                    of menstrual related complications?"),
                 plotOutput(outputId="mens_budget_plot" ),
                 
                 br(),
                 
                 p("The visualization shown above shows each state's menstrual complications by
                   percentage plotted against the maximum budget indicated by the slider
                   input. There is a negative correlation of about -22%, meaning that the lower
                   the state budget value, the higher the percent of menstrual complications. This is
                   not a strong correlation, but this may be due to the fact that the sample size is fairly small, with only 
                   11 states being considered. Despite this, it is reasonable to infer that more financial
                   resources directed towards menstrual health will lead to better outcomes."),
                 textOutput(outputId = "reactive_description_q3")
               )
             )
    ),
   
    tabPanel(title='Analysis Question 4',
             sidebarLayout(
               # Controls panel
               sidebarPanel(
                 
                 h4(strong("Overall Pregnancy Complications Against Budget")),
                 
                 p("Each point on this graph represents a state, and the point's position
                   is determined by the state's budget and the percentage of women who 
                   reported experiencing any type of pregnancy complication. In order
                   to see which states are included under different budget levels, simply adjust 
                   the slider to display all states whose budget is at or below your chosen position."),
                 
                 br(),
                 
                 sliderInput(inputId="overall_budget_slider", label="Choose max budget to display",
                             min=0,
                             max=700,
                             value=400),
                 
                 br(),
                 
                 em("NOTE: As noted before, only 11 of the states in India were included in this data. 
                    Therefore, the sample size used to construct this visualization was fairly small. ")
               ),
               
               # Main panel
               mainPanel(
                 h4("How does each state's budget correlate to the overall percentage of pregnancy
                    complications?"),
                 plotOutput(outputId="overall_budget_plot"),
                 
                 br(),
                 
                 p("The visualization shown above shows each state's overall pregnancy complications
                   by percentage plotted against the maximum budget indicated by the slider input.
                   There is a negative correlation of about -42%, meaning that the lower the state 
                   budget value, the higher the percent value of overall pregnancy complications. As
                   noted before, this is not a particularly strong correlation but it is notably stronger
                   than the previous visualization which compared menstrual health budget to the rate of reported 
                   menstrual health complications alone."),
                 textOutput(outputId = "reactive_description_q4")
            
               )
             )
    )
  )
)