library(tidyverse)
library(reshape2)

sdf<--filter(
  
  
  

glottolog <- read_tsv("practice_datasets/Glottolog_all_languoids_Heti_enhanced.tsv")

#filtering
glottolog_filtered_1 <- glottolog %>% 
  filter(Countries == "LK") %>% 
  filter(level == "language")

glottolog_filtered_2 <- glottolog %>% 
  filter(str_detect(Countries, "LK")) %>% 
  filter(level == "language")

#gathering
glottolog_LK_long <- glottolog_filtered_2 %>% 
  dplyr::select(Name, endangerment_status, Pop_numeric) %T>% View() %>%  
  gather(variable, value, -Name) %>% 
  arrange(Name)

glottolog_LK_long_no_nas <- glottolog_LK_long %>% 
  filter(!is.na(value))

#spreading
glottolog_LK_long_no_nas %>% 
  spread(variable, value) %>% View()

#joining

Sahul <- read_tsv("practice_datasets/Sahul_structure_wide_imputed.tsv") %>% 
  dplyr::select(Glottocode = Language_ID, everything())

full_join(Sahul, Glottolog) -> joined_1
left_join(Sahul, Glottolog) -> joined_2
inner_join(Sahul, Glottolog) -> joined_3
full_join(Sahul, Glottolog, by = "Glottocode") -> joined_4
anti_join(Sahul, Glottolog) -> joined_5

Sahul %>%	
  full_join(glottolog)
Sahul %>%	
  left_join(glottolog)
Sahul %>%	
  inner_join(glottolog) %>%
  dplyr::select(Longitude, Language_name)
Sahul %>%	
  mutate("In_Sahul_" = "yes") %>%
  full_join(glottolog)








