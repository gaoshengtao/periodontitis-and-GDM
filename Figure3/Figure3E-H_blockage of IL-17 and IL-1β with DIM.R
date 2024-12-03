##Script to Figure 3E-H.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","dplyr")
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

df_glucose_median <-  read.xlsx("../data/Figure3E-H_blockage of IL-17 or IL-1β with DIM.xlsx",sheet = 1)

df_glucose_continuous <-  read.xlsx("../data/Figure3E-H_blockage of IL-17 or IL-1β with DIM.xlsx",sheet = 2)

df_blood <-  read.xlsx("../data/Figure3E-H_blockage of IL-17 or IL-1β with DIM.xlsx",sheet = 3)


#----------------------------------
# Figure 3F
#----------------------------------

ggplot(data = df_glucose_median,aes(x=Day,y=`Glucose(mmol/L)`, color=Group, group=Group))+
  geom_point(data = df_glucose_continuous, aes(x=Day, y=`Glucose(mmol/L)`,color=Group),alpha=0.5)+
  geom_line()+theme_bw()+
  geom_errorbar(aes(ymin = `Glucose(mmol/L)`-`Standard.error`, ymax = `Glucose(mmol/L)`+`Standard.error`), width = 0.2)+
  theme(legend.title = element_blank(),
        legend.key = element_blank(),
        axis.title.x = element_blank())+
  ylab('Glucose (mmol/L)')+
  scale_color_manual(values = c('CON'='#bbbaba',
                                'Prevotella'='#cf6f68',
                                'Prevotella_CON'='#cf6f68',
                                'Prevotella_DIM'='#349239'))

ggsave('../plots/Figure3F_Glucose.pdf')

#----------------------------------
# Figure 3G
#----------------------------------
#GLP-1
ggplot(data = df_blood,aes(x=Group,y=`GLP-1(pmol/L)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','Prevotella_DIM'),
                                 c('CON','Prevotella_CON'),
                                 c('Prevotella_DIM','Prevotella_CON')),
              step_increase = 0.05, tip_length = 0,test = 't.test',test.args = 'great')+
  ylab('GLP-1 (pmol/L)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                                'Prevotella_CON'='#438cb8',
                                'Prevotella_DIM'='#cf6f67'))


ggsave('../plots/Figure3G_GLP-1.pdf')


#----------------------------------
# Figure 3G
#----------------------------------
# INS
ggplot(data = df_blood,aes(x=Group,y=`INS(mIU/L)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','Prevotella_DIM'),
                                 c('CON','Prevotella_CON'),
                                 c('Prevotella_DIM','Prevotella_CON')),
              step_increase = 0.05, tip_length = 0,test = 't.test',test.args = 'great')+
  ylab('INS (mIU/L)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prevotella_CON'='#438cb8',
                               'Prevotella_DIM'='#cf6f67'))


ggsave('../plots/Figure3G_INS.pdf')

