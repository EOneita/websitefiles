#USFWS Analysis
#Packages used
require(ggplot2)
require(ggthemes)
require(viridis)
require(ggsci)
require(palettetown)

#Creating a confidence interval chart for methods: Figure X.X
ggplot(conf, aes(x=Site, 
                               y=`Percentage Prevalence`, 
                               colour=Site)) + 
  geom_errorbar(aes(ymin=`Lower CI`, 
                    ymax=`Upper CI`), 
                width=.1, size = 1.5) +
  geom_point(size = 3) +
  theme_minimal() +
  theme(text = element_text(size = 20),
        plot.title = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "gray90")) +
  scale_y_continuous(limits = c(-10, 20)) +
  scale_color_poke(pokemon = 'Bulbasaur', spread = 5) +
  geom_hline(yintercept = 0, linetype="dotted", 
             color = "black", size=1.5) +
  facet_wrap(~Technique) +
  ylab("Prevalence Estimate (%)")
  

