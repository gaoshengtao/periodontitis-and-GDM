##Script to Figure 2A-E.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx")
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
# microCT
CT <-  read.xlsx("../data/Figure2A-E&FigureS2B-D_oral transplantation with human saliva.xlsx",sheet = 2)

# blood indexes
blood_indexes <-  read.xlsx("../data/Figure2A-E&FigureS2B-D_oral transplantation with human saliva.xlsx",sheet = 1)


#----------------------------------
# Figure 2B
#----------------------------------

# GDM vs CON
ggplot(CT, aes(x=Group,y=`BV/TV`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0, step_increase = 0.05,test = 't.test',test.args = c('great'))+
  ylab('BV/TV')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2B_BVTV.pdf')

ggplot(CT, aes(x=Group,y=`Lingual(mm)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('CEJ ABC distance(Lingal, mm)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2B_Lingal.pdf')

ggplot(CT, aes(x=Group,y=`Buccal(mm)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('CEJ ABC distance(Buccal, mm)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2B_Buccal.pdf')


#----------------------------------
# Figure 2C
#----------------------------------

#IL-17(pg/ml)
ggplot(blood_indexes, aes(x=Group,y=`IL-17(pg/ml)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('IL-17(pg/ml)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2C_IL-17.pdf')

#IL-1β(pg/ml)
ggplot(blood_indexes, aes(x=Group,y=`IL-1β(pg/ml)`, fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('IL-1β(pg/ml)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2C_IL-1β.pdf')

#----------------------------------
# Figure 2D
#----------------------------------

# RBGT 7d
ggplot(blood_indexes, aes(x=Group,y=`Glucose7d(mmol/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('1st week glucose(mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2D_RGBT7D.pdf')


# RGBT 14d
ggplot(blood_indexes, aes(x=Group,y=`Glucose14d(mmol/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('2st week glucose(mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2D_RGBT14D.pdf')

#OGTT0h
ggplot(blood_indexes, aes(x=Group,y=`OGTT0h(mmol/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('OGTT 0h glucose (mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2D_OGTT0h.pdf')

#OGTT1h
ggplot(blood_indexes, aes(x=Group,y=`OGTT1h(mmol/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('great'))+
  ylab('OGTT 0h glucose (mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2D_OGTT1h.pdf')

#OGTT2h
ggplot(blood_indexes, aes(x=Group,y=`OGTT2h(mmol/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))+
  ylab('OGTT 0h glucose (mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2D_OGTT2h.pdf')

#----------------------------------
# Figure 2E
#----------------------------------

##GLP-1
ggplot(blood_indexes, aes(x=Group,y=`GLP-1(pmol/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('great'))+
  ylab('OGTT 0h glucose (mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2E_GLP-1.pdf')

#INS
ggplot(blood_indexes, aes(x=Group,y=`INS(mIU/L)`, fill=Group))+
  geom_boxplot(width=0.6)+
  geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('great'))+
  ylab('OGTT 0h glucose (mmol/L)')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/Figure2E_INS.pdf')
