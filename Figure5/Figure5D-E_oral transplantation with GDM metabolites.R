##Script to Figure 5D-E.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","ggrepel","dplyr","colorspace")
bioconductor_packages=c()

for(package in cran_packages){
  if(!require(package, character.only=T,quietly = T, warn.conflicts = F)){
    install.packages(as.character(package))
    library(package, character.only=T,quietly = T, warn.conflicts = F)
  }
}

if (!require("BiocManager", quietly = T, warn.conflicts = F)) install.packages("BiocManager")

for(package in bioconductor_packages){
  if(!require(package, character.only=T,quietly = T, warn.conflicts = F)){
    BiocManager::install(as.character(package))
    library(package, character.only=T,quietly = T, warn.conflicts = F)
  }
}


#----------------------------------
# Load dates
#----------------------------------

df <-  read.xlsx("../data/Figure5D-E&FigureS7_oral transplantation with GDM metabolites.xlsx",sheet = 1)

#----------------------------------
# Figure 5E
#----------------------------------
# IL-17
ggplot(df, aes(x=Group,y=`IL-17(pg/ml)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(0.2, 0.4), breaks = c(0.2,0.3,0.4))+
  scale_fill_manual(values = c('Anti'='#bcbaba',
                               'Fructose'='#8992bf',
                               'Oxoglutaric'='#803f94'))+
  scale_color_manual(values = c('Anti'=colorspace::darken('#bcbaba',0.5),
                                'Fructose'=colorspace::darken('#8992bf',0.5),
                                'Oxoglutaric'=colorspace::darken('#803f94',0.5)
  ))+
  ggsignif::geom_signif(comparisons = list(c('Anti','Fructose'),
                                           c('Anti','Oxoglutaric'),
                                           c('Fructose','Oxoglutaric')),
                        step_increase = 0.1)

ggsave('../plots/Figure5E_IL-17.pdf')



# IL-1β
ggplot(df, aes(x=Group,y=`IL-1β(pg/ml)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(0.2, 0.4), breaks = c(0.2,0.3,0.4))+
  scale_fill_manual(values = c('Anti'='#bcbaba',
                               'Fructose'='#8992bf',
                               'Oxoglutaric'='#803f94'))+
  scale_color_manual(values = c('Anti'=colorspace::darken('#bcbaba',0.5),
                                'Fructose'=colorspace::darken('#8992bf',0.5),
                                'Oxoglutaric'=colorspace::darken('#803f94',0.5)
  ))+
  ggsignif::geom_signif(comparisons = list(c('Anti','Fructose'),
                                           c('Anti','Oxoglutaric'),
                                           c('Fructose','Oxoglutaric')),
                        step_increase = 0.1)

ggsave('../plots/Figure5E_IL-1β.pdf')

