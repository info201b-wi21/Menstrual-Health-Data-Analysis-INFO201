source('my_server.R')

my_ui <- fluidPage(
  h1('Menstrual Health and Sexual Education in India'),
  em('Group G2: Kriti Vajjhula, Franchezca Layog, Ian Chandramouli, & Harmeet Singh'),
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
             br(),
             
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
             br(),
             
             h3('Menstrual Hygiene Scheme Budget 2016-2020 Data Set'),
             a('Menstrual Hygiene Scheme Budget', href='https://data.gov.in/resources/stateut-wise-menstrual-hygiene-scheme-budget-approved-under-nhm-2016-17-2019-20-ministry'),
             p('The data was released by Rajya Sabha (Council of States), the upper house of the 
                Indian Parliament. The government is logically the entity responsible for proposing 
                the budget, and the data was therefore effectively generated by them. It was 
                released under the National Data Sharing and Accessibility Policy.
                This will help us identify the financial disparities in government menstrual
                health support programs by state, which can provide insight as to how attitudes 
                toward and the overall state of female menstrual health differ by state and region.')),
    tabPanel(title='Analysis Question 1',
             sidebarLayout(
               # Controls panel - Intro of Question & User interaction
               sidebarPanel(
                 selectInput(
                   inputId ="comp", 
                   label = "Complication Types:",
                   choices = c("Any Delivery Complication" = "any_delivery_comp",
                                "Any Post-delivery Complication" = "any_post_delivery_comp",
                                "Menstrual-Related Complication" = "menstrual_related_comp",
                                "Any Pregnancy Complications" = "preg_comp",
                                "Vaginal Discharge Complications" = "vag_discharge_comp"))
               ),
               
               # Main panel - Visualizations
               mainPanel(
                 plotOutput("analysis_q1")
               )
             )),
    tabPanel(title='Analysis Question 2',
             sidebarLayout(
               # Controls panel
               sidebarPanel(
               ),
               
               # Main panel
               mainPanel(
               )
             )),
    tabPanel(title='Analysis Question 3',
             sidebarLayout(
               # Controls panel
               sidebarPanel(
               ),
               
               # Main panel
               mainPanel(
               )
             )),
    tabPanel(title='Analysis Question 4',
             sidebarLayout(
               # Controls panel
               sidebarPanel(
               ),
               
               # Main panel
               mainPanel(
               )
             ))
  ),
)