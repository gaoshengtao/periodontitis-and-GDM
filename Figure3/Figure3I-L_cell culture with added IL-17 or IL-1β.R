##Script to Figure 3I-L.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","colorspace","dplyr")
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

df_RT <-  read.xlsx("../data/Figure3I-L_cell culture with added IL-17 or IL-1β.xlsx",sheet = 1)

df_WB <-  read.xlsx("../data/Figure3I-L_cell culture with added IL-17 or IL-1β.xlsx",sheet = 2)


#----------------------------------
# Figure3J
#----------------------------------

# mouse STC-1

ggplot(df_RT %>% subset(Cell_lines=='STC-1'), aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.5)+geom_point()+
  ylab('Relative mRNA expression of GLP-1 in STC')+theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  facet_wrap(~Index)+
  geom_signif(comparisons = list(c('CON','80'),
                                 c('CON','160')),
              step_increase = 0.2, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/Figure3J_STC-1.pdf')


#----------------------------------
# Figure3K
#----------------------------------

# human NCL-H716

ggplot(df_RT %>% subset(Cell_lines=='NCL-H716'), aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.5)+geom_point()+
  ylab('Relative mRNA expression of GLP-1 in STC')+theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  facet_wrap(~Index)+
  geom_signif(comparisons = list(c('CON','80'),
                                 c('CON','160')),
              step_increase = 0.2, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/Figure3K_NCL-H716.pdf')


#----------------------------------
# Figure3L
#----------------------------------

# WB
ggplot(df_WB, aes(Group, `GLP-1/β-actin`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              test = 't.test',
              step_increase = 0.1,
              tip_length = 0,
              test.args = 'great')

ggsave('../plots/Figure3L_NCL-H716_WB.pdf')



