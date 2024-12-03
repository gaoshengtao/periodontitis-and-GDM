##Script to Figure S6A-E.

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

df_Blood <- read.xlsx("../data/Figure4H-J&FigureS6A-E_oral transplantation with single bacterium.xlsx",sheet = 2)

#----------------------------------
# Figure S6A
#----------------------------------

# GLP-1
ggplot(data = df_Blood,aes(x=Group,y=`GLP-1(pmol/L)`, fill=Group, shape=Group))+
  geom_boxplot(width=0.7, size=1, aes(color=Group), outlier.shape = NA)+
  geom_jitter(size=4, aes(color=Group), fill="white", width=0.1, height=0)+
  scale_shape_manual(values=c('CON'=22,
                              'Prev'=21,
                              'Prev_Strep'=23,
                              'PG_Strep'=24))+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.2),
                                'Prev'=darken('#cf6f68',0.2),
                                'Prev_Strep'=darken('#7dd2f6',0.2),
                                'PG_Strep'=darken('#3e58a6',0.2))) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#cf6f68',
                               'Prev_Strep'='#7dd2f6',
                               'PG_Strep'='#3e58a6'))+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','Prev_Strep'),
                                 c('CON','PG_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())

ggsave('../plots/FigureS6A_GLP-1.pdf')


#----------------------------------
# Figure S6B
#----------------------------------

# INS
ggplot(data = df_Blood,aes(x=Group,y=`INS(mIU/L)`, fill=Group, shape=Group))+
  geom_boxplot(width=0.7, size=1, aes(color=Group), outlier.shape = NA)+
  geom_jitter(size=4, aes(color=Group), fill="white", width=0.1, height=0)+
  scale_shape_manual(values=c('CON'=22,
                              'Prev'=21,
                              'Prev_Strep'=23,
                              'PG_Strep'=24))+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.2),
                                'Prev'=darken('#cf6f68',0.2),
                                'Prev_Strep'=darken('#7dd2f6',0.2),
                                'PG_Strep'=darken('#3e58a6',0.2))) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#cf6f68',
                               'Prev_Strep'='#7dd2f6',
                               'PG_Strep'='#3e58a6'))+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','Prev_Strep'),
                                 c('CON','PG_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())

ggsave('../plots/FigureS6B_INS.pdf')


#----------------------------------
# Figure S6C
#----------------------------------

# CAT

ggplot(data = df_Blood,aes(x=Group,y=`CAT(Units/ml)`, fill=Group, shape=Group))+
  geom_boxplot(width=0.7, size=1, aes(color=Group), outlier.shape = NA)+
  geom_jitter(size=4, aes(color=Group), fill="white", width=0.1, height=0)+
  scale_shape_manual(values=c('CON'=22,
                              'Prev'=21,
                              'Prev_Strep'=23,
                              'PG_Strep'=24))+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.2),
                                'Prev'=darken('#cf6f68',0.2),
                                'Prev_Strep'=darken('#7dd2f6',0.2),
                                'PG_Strep'=darken('#3e58a6',0.2))) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#cf6f68',
                               'Prev_Strep'='#7dd2f6',
                               'PG_Strep'='#3e58a6'))+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','Prev_Strep'),
                                 c('CON','PG_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())


ggsave('../plots/FigureSC_CAT.pdf')


#----------------------------------
# Figure S6D
#----------------------------------
#SOD
ggplot(data = df_Blood,aes(x=Group,y=`SOD(units/ml)`, fill=Group, shape=Group))+
  geom_boxplot(width=0.7, size=1, aes(color=Group), outlier.shape = NA)+
  geom_jitter(size=4, aes(color=Group), fill="white", width=0.1, height=0)+
  scale_shape_manual(values=c('CON'=22,
                              'Prev'=21,
                              'Prev_Strep'=23,
                              'PG_Strep'=24))+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.2),
                                'Prev'=darken('#cf6f68',0.2),
                                'Prev_Strep'=darken('#7dd2f6',0.2),
                                'PG_Strep'=darken('#3e58a6',0.2))) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#cf6f68',
                               'Prev_Strep'='#7dd2f6',
                               'PG_Strep'='#3e58a6'))+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','Prev_Strep'),
                                 c('CON','PG_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())

ggsave('../plots/FigureS6D_SOD.pdf')


#----------------------------------
# Figure S6D
#----------------------------------
##GPx
ggplot(data = df_Blood,aes(x=Group,y=`Gpx(min/ml)`, fill=Group, shape=Group))+
  geom_boxplot(width=0.7, size=1, aes(color=Group), outlier.shape = NA)+
  geom_jitter(size=4, aes(color=Group), fill="white", width=0.1, height=0)+
  scale_shape_manual(values=c('CON'=22,
                              'Prev'=21,
                              'Prev_Strep'=23,
                              'PG_Strep'=24))+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.2),
                                'Prev'=darken('#cf6f68',0.2),
                                'Prev_Strep'=darken('#7dd2f6',0.2),
                                'PG_Strep'=darken('#3e58a6',0.2))) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'Prev'='#cf6f68',
                               'Prev_Strep'='#7dd2f6',
                               'PG_Strep'='#3e58a6'))+
  geom_signif(comparisons = list(c('CON','Prev'),
                                 c('Prev','Prev_Strep'),
                                 c('Prev','PG_Strep'),
                                 c('CON','Prev_Strep'),
                                 c('CON','PG_Strep')),
              step_increase = 0.05, tip_length = 0,test = 't.test')+
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())

ggsave('../plots/FigureS6E_GPx.pdf')

