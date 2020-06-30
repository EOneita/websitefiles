library(tidyverse)
library(readxl)

glottolog_Australia <- read_tsv("practice_datasets/Glottolog_all_languoids_Heti_enhanced.tsv") %>% 
  filter(Macroarea == "Australia") %>%   
  filter(level == "language") %>%  
  filter(Family_name != "Bookkeeping") 

#plot directly with pipes
ggplot(data = glottolog_Australia, mapping = aes(x = Longitude, y = Latitude, color = endangerment_status)) + 
  geom_point() + 
  coord_fixed() +
  theme_classic()

#plot with pipes, assign and then plot
Australia_lgs <- ggplot(data = glottolog_Australia, mapping = aes(x = Longitude, y = Latitude, color = endangerment_status)) + 
  geom_point() + 
  coord_fixed() +
  theme_classic()

plot(Australia_lgs)

#an older way
p <- ggplot(data = glottolog_Australia, mapping = aes(x = Longitude, y = Latitude, color = endangerment_status))
p <- p + geom_point()
p <- p + coord_fixed()
p <- p + theme_classic()

plot(p)

#jitter
ggplot(data = glottolog_Australia, mapping = aes(x = Longitude, y = Latitude, color = endangerment_status)) + 
  geom_jitter() + 
  coord_fixed() +
  theme_classic()

#barplots
glottolog_Australia %>% 
  ggplot() +
  geom_bar(aes(x = Family_name)) 

glottolog_Australia %>% 
  ggplot() +
  geom_bar(aes(x = Family_name)) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1, vjust = 0.5))
  
glottolog_au_fam_count <- glottolog_Australia %>% 
  group_by(Family_name) %>% 
  summarise(n = n())

#summarising
glottolog_au_fam_count %>%
  ggplot() +
  geom_bar(aes(x = Family_name, y = n), stat = "identity")

#reordering x axis
glottolog_au_fam_count$Family_name <- fct_reorder(glottolog_au_fam_count$Family_name, glottolog_au_fam_count$n)

glottolog_au_fam_count %>%
  ggplot() +
  geom_bar(aes(x = Family_name, y = n), stat = "identity") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1, vjust = 0.5))

#stacked barplots
glottolog_Australia %>% 
  filter(!is.na(Family_name)) %>% 
  ggplot(aes(x = Family_name, y = endangerment_status, fill = endangerment_status)) +
  geom_bar(stat = "identity") + 
  theme_classic() +
  coord_flip() +
  theme(axis.text.x = element_blank())


#piechart
glottolog_Australia %>% 
  filter(!is.na(Family_name)) %>% 
  filter(!is.na(endangerment_status)) %>% 
  ggplot(aes(x = Macroarea, y = endangerment_status, fill = endangerment_status)) +
  geom_bar(stat = "identity") + 
  theme_classic() +
  coord_flip() +
  theme(axis.text.x = element_blank()) +
  coord_polar("y", start=0)

#more stacked barplot and summarising
informants <- read_xlsx("practice_datasets/Savaii_informants_Skirgard.xlsx", sheet = 1)

informants %>% 
  spread(key = variable, value = value) -> informants_spread

informants_spread %>% 
  gather(key = variable, value = value, -Speaker_ID) -> informants_gathered

informants_gathered_diff <- anti_join(informants, informants_gathered) 

nrow(informants_gathered_diff) -> rows

if(rows == 0){cat("Hurray, they're identical!")} else{cat("Ohn o!")}

informants_sheet_2 <- read_xlsx("practice_datasets/Savaii_informants_Skirgard.xlsx", sheet = 2)

informants_binned_by_age <- informants_spread %>% 
  mutate(Age = as.numeric(Age)) %>% 
  mutate(Age_range = cut(Age, c(12, 25, 40, 79), include.lowest = T)) %>% 
  mutate(Age_range = str_remove_all(Age_range, "\\(|\\[|\\]")) %>% 
  mutate(Age_range = str_replace_all(Age_range, ",", "-"))

informants_summarised <-  informants_binned_by_age %>% 
  group_by(Village, Gender, Age_range) %>% 
  summarise(n = n())  

informants_summarised_complete <- informants_summarised %>%
  ungroup() %>% 
  complete(Village, Gender, Age_range, fill = list(n = 0))

informants_summarised_complete %>% 
  filter(Gender == "M") %>% 
  ggplot(mapping = aes(x = Village, y = n, fill = Age_range)) +
  geom_bar(stat = "identity") +
  theme_classic()

informants_summarised_complete %>% 
  filter(Gender == "F") %>% 
  ggplot(mapping = aes(x = Village, y = n, fill = Age_range)) +
  geom_bar(stat = "identity") +
  theme_classic()

informants_summarised_complete %>% 
  ggplot(mapping = aes(x = Village, y = n, fill = Age_range)) +
  geom_bar(stat = "identity") +
  facet_wrap("Gender") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1, vjust = 0.5)) 

informants_summarised_complete %>% 
  ggplot(mapping = aes(x = Age_range, y = n, fill = Age_range)) +
  geom_bar(stat = "identity") +
  facet_wrap("Village") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1, vjust = 0.5), 
        legend.position = "None") 

