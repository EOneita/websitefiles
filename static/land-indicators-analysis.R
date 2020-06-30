# Understanding land use in the Greater Mekong Region (data from 2012)

# Import the dataset: land.indicators.2012.csv

str(land.indicators.2012) #check the dataset to see what the variables are like

#Ok. Looking at this dataset, I think I want to visualize whether there is a significant difference in land use, between countries. We will visulaize the two datasets.


#I'll make a ggplot of each dataset.

require(tidyverse)
require(scales)
ggplot(land.indicators.2012.km, aes(x = Country, y = Amount, fill = Country)) +
  geom_bar(stat = "identity") + 
  theme_bw() +
  scale_fill_viridis_d() +
  facet_wrap(~Land.Use.Type) + 
  scale_y_continuous(name="Country", labels = comma) +
  ggtitle("Land Use Types Between Countries (km2)") +
  theme(text = element_text(size = 20)) 

ggplot(land.indicators.2012.percent, aes(x = Country, y = Amount, fill = Country)) +
  geom_bar(stat = "identity") + 
  theme_bw() +
  scale_fill_viridis_d() +
  facet_wrap(~Land.Use.Type) + 
  scale_y_continuous(name="Country", labels = comma) +
  ggtitle("Land Use Types Between Countries (%)") +
  theme(text = element_text(size = 20)) +
  scale_x_discrete(limits=c("Thailand","Vietnam","Cambodia", "Myanmar", "Laos"))
