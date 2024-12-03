##Script to Figure 3A-D.

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

df_blood <-  read.xlsx("../data/Figure3A-C&FigureS3A-G_intraperitoneal injection of IL-17 or IL-1β_blood.xlsx",sheet = 1)

df_WB <-  read.xlsx("../data/Figure3D_intraperitoneal injection of IL-17 or IL-1β_WB.xlsx",sheet = 1)

#----------------------------------
# Figure 3B
#----------------------------------

# fasting glucose of IL-17
ggplot(data = df_blood %>% subset(IL!='IL-1β'), aes(x=Group, y=`Glucose(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  geom_signif(comparisons = list(c('CON','IL-17_0.1'),
                                 c('CON','IL-17_0.5'),
                                 c('CON','IL-17_1')),
              step_increase = 0.08, tip_length = 0, map_signif_level=F,test = 't.test',test.args = 'less')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  ylab('Fasting glucose (mmol/L)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17_0.1'='#f4a9a4',
                               'IL-17_0.5'='#d8726a',
                               'IL-17_1'='#c4504b'))

ggsave('../plots/Figure3B_intraperitoneal injection of IL-17.pdf')


#----------------------------------
# Figure 3C
#----------------------------------
ggplot(data = df_blood %>% subset(IL!='IL-17'), aes(x=Group, y=`Glucose(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  geom_signif(comparisons = list(c('CON','IL-1β_0.1'),
                                 c('CON','IL-1β_0.5'),
                                 c('CON','IL-1β_1')),
              step_increase = 0.08, tip_length = 0, map_signif_level=F,test = 't.test',test.args = 'less')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  ylab('Fasting glucose (mmol/L)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-1β_0.1'='#7abcdd',
                               'IL-1β_0.5'='#438cb8',
                               'IL-1β_1'='#1d6d96'))

ggsave('../plots/Figure3C_intraperitoneal injection of IL-1β.pdf')



#----------------------------------
# Figure 3D
#----------------------------------

ggplot(data = df_WB, aes(x=Group, y=GLP1_relative_abundance,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+theme_bw()+
  ggsignif::geom_signif(comparisons = list(c('CON','IL-17'),
                                           c('CON','IL-1β')),
                        step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'great')+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-1β'='#438cb8',
                               'IL-17'='#d8726a'))

