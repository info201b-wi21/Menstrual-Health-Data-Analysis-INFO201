library("tidyverse")

# Percentage of Women Complication During Pregnancy Data Set
preg_comp_df <- read.csv("data/Percentage_Women_complication_Pregnancy_delivery_post-delivery_vaginal_discharge_menstrual_DLHS4.csv")

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
menstrual_budget_df <- read.csv("data/Menstrual_Budget.csv")

# Changing column names to be more readable in menstrual_budget_df
menstrual_budget_df <- menstrual_budget_df %>% 
  rename(
    state_no = S.No,
    States = State.UT,
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

columns = list(
  '2016-17' = 0,
  '2017-18' = 0,
  '2018-19' = 0,
  '2019-20' = 0
)

menstrual_budget_df <- menstrual_budget_df %>% 
  replace_na(columns)

# Summary statistics

### MENSTRUAL BUDGET SUMMARY STATISTICS 

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

total_budgets_df <- menstrual_budget_df %>%
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

### PREGNANCY COMPLICATIONS SUMMARY STATISTICS 

menstrual_comp_summary <- summary(preg_comp_df$menstrual_related_comp)
preg_comp_summary <- summary(preg_comp_df$preg_comp)
delivery_comp_summary <- summary(preg_comp_df$any_delivery_comp)
post_delivery_comp_summary <- summary(preg_comp_df$any_post_delivery_comp)
vag_discharge_comp_summary <- summary(preg_comp_df$vag_discharge_comp)


preg_comp_by_state_df <- preg_comp_df %>% 
  filter(Districts=="Total") %>% 
  group_by(`States`) %>% 
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
# font size adapted from https://stackoverflow.com/questions/3290330/facet-label-font-size 
preg_comp_bar_graph <- ggplot(data=preg_comp_by_state_df, mapping=aes(x="", y=value, fill=Complications) ) +
  geom_col(width=1, position="dodge") +
  labs(title = "Distribution of Pregnancy Complications by State",
       x = "States",
       y = "% Women Reporting") + 
  scale_fill_brewer(palette="Dark2", labels= c("any_delivery_comp" = "Any Delivery Complication",
                                               "any_post_delivery_comp" = "Any Post-delivery Complication",
                                               "menstrual_related_comp" = "Menstrual-Related Complication",
                                               "preg_comp" = "Any Pregnancy Complications",
                                               "vag_discharge_comp" = "Vaginal Discharge Complications")) +
  facet_wrap(~States) +  theme(strip.text.x = element_text(size = 3))



mens_comp_state_df <- preg_comp_df %>%
  group_by(States) %>%
  summarize(menstrual_related_comp = sum(menstrual_related_comp))

mens_comp_state_plot <- ggplot(data = mens_comp_state_df) +
  geom_point(mapping = aes(x = States, y = menstrual_related_comp), color = "red") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Menstrual Related Complications During Pregnancy by State",
       x = "States",
       y = "Menstrual Complications")


mens_budget_line_df <- menstrual_budget_df %>%
  filter(`2016-17` != 0,
         `2017-18` != 0,
         `2018-19` != 0,
         `2019-20` != 0) %>%
  pivot_longer(cols = c("2016-17", "2017-18", "2018-19", "2019-20"),
                        names_to = "year")

mens_budget_line_plot <- ggplot(data = mens_budget_line_df) +
  geom_path(mapping = aes(x = year, y = value, color = States)) +
  geom_point(mapping = aes(x = year, y = value, color = States)) +
  labs(x = "Year",
       y = "Total",
       title = "Menstrual Budget for States with Complete Data")



###############################################
# Analysis Question 1                         #
###############################################

# How do state's total spending budget
# impact the number of menstrual related pregnancy
# complications

preggo_totals <- preg_comp_df %>% 
  filter(Districts == 'Total')

preg_budget_df <- menstrual_budget_df %>% 
  inner_join(preggo_totals, by = 'States') %>% 
  summarize(
    State = States,
    budget = `2016-17`,
    mens_comp = menstrual_related_comp,
    preg_comp = preg_comp
  )

preg_budget_plot <- ggplot(data=preg_budget_df, mapping=(aes(x=budget, y=mens_comp))) +
  geom_point(size=2) +
  geom_text(
    label=preg_budget_df$State,
    nudge_y=-.5
    ) +
  labs(
    title = 'Menstrual Complications Against Budget',
    x = 'Budget',
    y = 'Percent Complications'
  )

###############################################
# Analysis Question 3                         #
###############################################
budget_2019_20 <- menstrual_budget_df %>% 
  filter(`2019-20` != 0)

budget_2019_20_plot <- ggplot(budget_2019_20, aes(x='', y=`2019-20`, fill=States)) +
  geom_bar(stat = 'identity') +
  coord_polar('y', start=0) +
  theme_void() +
  labs(
    title = 'Distribution of State Menstrual Health Budget in 2019-2020'
  )

###############################################
# Analysis Question 4                         #
###############################################
preg_comp_budget_plot <- ggplot(data=preg_budget_df, mapping=(aes(x=budget, y=preg_comp))) +
  geom_point(size=2) +
  geom_text(
    label=preg_budget_df$State,
    nudge_y=-.5
  ) +
  labs(
    title = 'Overall Pregnancy Complications Against Budget',
    x = 'Budget',
    y = 'Percent Complications'
  )
