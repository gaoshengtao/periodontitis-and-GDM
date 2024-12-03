##Script to Figure 4H-J.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","colorspace","dplyr","lvplot")
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

df_RBGT <-  read.xlsx("../data/Figure4H-J&FigureS6A-E_oral transplantation with single bacterium.xlsx",sheet = 1)

df_Blood <- read.xlsx("../data/Figure4H-J&FigureS6A-E_oral transplantation with single bacterium.xlsx",sheet = 2)

#----------------------------------
# Figure 4I
#----------------------------------

##### 血糖############
# Prevotella分开
ggplot(data = df_RBGT,aes(x=Group,y=`Glucose(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  geom_signif(comparisons = list(c('CON','Prev_Prev'),
                                 c('CON','Prev_Strep'),
                                 c('CON','PG_Strep'),
                                 c('Prev_Prev','Prev_Strep'),
                                 c('Prev_Prev','PG_Strep')),
  step_increase = 0.05, tip_length = 0,test = 't.test')+
  theme(legend.position = '',
        axis.title.x=element_blank())+
  facet_wrap(~Day,nrow = 1,ncol = 5)+
  ylab('Glucose (mmol/L)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#438cb8',
                               'Prev_Strep'='#cf6f67',
                               'PG_Strep'='#73aa48'))

ggsave('../plots/Figure4I_RBGT after bacterial transplantation.pdf')


#----------------------------------
# Figure 4J
#----------------------------------

##IL-17
ggplot(data = df_Blood,aes(x=Group,y=`IL-17(pg/ml)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','PG_Strep'),
                                 c('CON','Prev_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  ylab('IL-17(pg/ml)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#438cb8',
                               'Prev_Strep'='#cf6f67',
                               'PG_Strep'='#73aa48'))

ggsave('../plots/Figure4J_IL-17.pdf')

##IL-1β
ggplot(data = df_Blood,aes(x=Group,y=`IL-1β(pg/ml)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','PG_Strep'),
                                 c('CON','Prev_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  ylab('IL-1β(pg/ml)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#438cb8',
                               'Prev_Strep'='#cf6f67',
                               'PG_Strep'='#73aa48'))

ggsave('../plots/Figure4J_IL-1β.pdf')

