library("tidyverse")

# Percentage of Women Complication During Pregnancy Data Set
preg_comp_df <- read.csv("https://raw.githubusercontent.com/info201b-wi21/project-franchezcalayog/main/data/Percentage_Women_complication_Pregnancy_delivery_post-delivery_vaginal_discharge_menstrual_DLHS4.csv?token=ASLYGZ6BNUFHNDYR2FSFJKDAHRQ6M")

# Changing column names to be more readable in preg_comp_df
preg_comp_df <- preg_comp_df %>% 
  rename(
    any_preg_comp = Percentage.of.Women.who.had...Any.Pregnancy.complication7,
    any_delivery_comp = Percentage.of.Women.who.had...Any.Delivery.complication7,
    any_post_delivery_comp = Percentage.of.Women.who.had...Any.Post.delivery.complication7,
    vag_discharge_comp = Percentage.of.Women.who.had...Problem.of.vaginal.discharge.during.last.three.months,
    menstrual_related_comp = Percentage.of.Women.who.had...Menstrual.related.problems.during.last.three.months..
    )

# Menstrual Hygiene Scheme Budget 2016-2020 Data Set
menstrual_budget_df <- read.csv("https://raw.githubusercontent.com/info201b-wi21/project-franchezcalayog/main/data/Menstrual_Budget.csv?token=ASLYGZ62ND77PLVCXOBOLJTAH4HGO")

# Changing column names to be more readable in menstrual_budget_df
menstrual_budget_df <- menstrual_budget_df %>% 
  rename(
    state_no = S.No,
    state = State.UT,
    "2016-17" = X2016.17,
    "2017-18" = X2017.18,
    "2018-19" = X2018.19,
    "2019-20" = X2019.20
  )
