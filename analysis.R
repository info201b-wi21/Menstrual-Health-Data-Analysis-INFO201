library("tidyverse")

# Percentage of Women Complication During Pregnancy Data Set
preg_comp_df <- read.csv("https://raw.githubusercontent.com/info201b-wi21/project-franchezcalayog/main/data/Percentage_Women_complication_Pregnancy_delivery_post-delivery_vaginal_discharge_menstrual_DLHS4.csv?token=ASLYGZ6BNUFHNDYR2FSFJKDAHRQ6M")

# Changing column names to be more readable in preg_comp_df
preg_comp_df <- preg_comp_df %>% 
  rename(
    preg_comp = Percentage.of.Women.who.had...Any.Pregnancy.complication7,
    any_delivery_comp = Percentage.of.Women.who.had...Any.Delivery.complication7,
    any_post_delivery_comp = Percentage.of.Women.who.had...Any.Post.delivery.complication7,
    vag_discharge_comp = Percentage.of.Women.who.had...Problem.of.vaginal.discharge.during.last.three.months,
    menstrual_related_comp = Percentage.of.Women.who.had...Menstrual.related.problems.during.last.three.months..
    )

# Menstrual Hygiene Scheme Budget 2016-2020 Data Set
menstrual_budget_df <- read.csv("https://raw.githubusercontent.com/info201b-wi21/project-franchezcalayog/main/data/Menstrual_Budget.csv?token=AOXKT2HVOERM36KHCF5HE4LAH4GQ6")

# Changing column names to be more readable in menstrual_budget_df
menstrual_budget_df <- menstrual_budget_df %>% 
  rename(
    state_no = S.No,
    state = State.UT,
    "2016-17" = X2016.17,
    "2017-18" = X2017.18,
    "2018-19" = X2018.19,
    "2019-20" = X2019.20
  ) %>% 
  filter(state_no != 'Total')

menstrual_budget_df$`2016-17` <- as.numeric(menstrual_budget_df$`2016-17`)
menstrual_budget_df$`2017-18` <- as.numeric(menstrual_budget_df$`2017-18`)
menstrual_budget_df$`2018-19` <- as.numeric(menstrual_budget_df$`2018-19`)
menstrual_budget_df$`2019-20` <- as.numeric(menstrual_budget_df$`2019-20`)

# Summary statistics
preg_comp_stats <- summary(preg_comp_df$menstrual_related_comp)
mens_budget_2016_17 <- summary(menstrual_budget_df$`2016-17`)
mens_budget_2017_18 <- summary(menstrual_budget_df$`2017-18`) 
mens_budget_2018_19 <- summary(menstrual_budget_df$`2018-19`)
mens_budget_2019_20 <- summary(menstrual_budget_df$`2019-20`)

# Standard Deviation
preg_comp_sd <- sd(preg_comp_df$menstrual_related_comp, na.rm = TRUE)
mens_budget_2016_17_sd <- sd(menstrual_budget_df$`2016-17`, na.rm = TRUE)
mens_budget_2017_18_sd <- sd(menstrual_budget_df$`2017-18`, na.rm = TRUE)
mens_budget_2018_19_sd <- sd(menstrual_budget_df$`2018-19`, na.rm = TRUE)
mens_budget_2019_20_sd <- sd(menstrual_budget_df$`2019-20`, na.rm = TRUE)

columns = list(
  '2016-17' = 0,
  '2017-18' = 0,
  '2018-19' = 0,
  '2019-20' = 0
)

total_budgets_df <- menstrual_budget_df %>% 
  replace_na(columns) %>% 
  summarize(
    '2016-17' = sum(`2016-17`),
    '2017-18' = sum(`2017-18`),
    '2018-19' = sum(`2018-19`),
    '2019-20' = sum(`2019-20`)
  ) %>% 
  pivot_longer(
    c('2016-17', '2017-18', '2018-19', '2019-20'),
    names_to = 'Year'
  ) %>% 
  rename('Total' = 'value')

total_budgets_plot <- ggplot(data = total_budgets_df) +
  geom_col(
    mapping = aes(x = Year, y = Total),
    fill = '#1588EC'
  ) +
  labs(
    title = 'Average Menstrual Budget per Fiscal Year'
  )

preg_comp_by_state_df <- preg_comp_df %>% 
  group_by(States) %>% 
  summarize(preg_comp=sum(preg_comp),
            any_delivery_comp=sum(any_delivery_comp),
            any_post_delivery_comp=sum(any_post_delivery_comp),
            vag_discharge_comp=sum(vag_discharge_comp),
            menstrual_related_comp=sum(menstrual_related_comp))

preg_comp_by_state_df <- preg_comp_by_state_df %>% pivot_longer(cols=c(any_delivery_comp,
                                                                       any_post_delivery_comp,
                                                                       preg_comp,
                                                                       vag_discharge_comp,
                                                                       menstrual_related_comp), 
                                                                names_to="Complications")
#scale_fill_discrete() adapted from https://www.datanovia.com/en/blog/ggplot-legend-title-position-and-labels/#rename-legend-labels-and-change-the-order-of-items
preg_comp_bar_graph <- ggplot(data=preg_comp_by_state_df ) +
  geom_col(mapping=aes(x=States, y=value, fill=Complications)) +
  coord_flip() +
  labs(title = "Distribution of Pregnancy Complications by State",
       x = "States",
       y = "Number of Cases") + scale_fill_brewer(palette="Dark2", labels= c("any_delivery_comp" = "Any Delivery Complication",
                                                                             "any_post_delivery_comp" = "Any Post-delivery Complication",
                                                                             "menstrual_related_comp" = "Menstrual-Related Complication",
                                                                             "preg_comp" = "Any Pregnancy Complications",
                                                                             "vag_discharge_comp" = "Vaginal Discharge Complications"))



