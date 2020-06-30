# Please run this script first to make sure you have all the necessary packages 
# installed for running the rest of the scripts in this R project

if (!suppressPackageStartupMessages(require("pacman"))) { install.packages("pacman") }

pacman::p_load(
	tidyverse,
	reshape2,
	broom,
	glue,
	forcats,
	magrittr,
	stringr,
	purrr,
	stringi,
	readxl,

	MASS,

	#plotting graphs
	scales,
	RColorBrewer,
	ggpubr,
	ggplot2,
	gridExtra,
	scales,
	ggmap,
	viridis,
	plot3D,
	rlang,
	naniar,
	devtools,
	
	#making maps
	mapdata,
	maptools,
	maps
)

# shut up, tidyverse:
options(tidyverse.quiet = TRUE)
options(warn.conflicts = FALSE)
options(stringsAsFactors = FALSE)

#Done!
source("feedback.R")
feedback()