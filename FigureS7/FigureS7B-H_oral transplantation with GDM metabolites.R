##Script to Figure S7B-H.

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
# Figure S7B
#----------------------------------

# BV/TV
ggplot(data=df,aes(x=Group,y=`BV/TV`,fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 14), breaks = c(5,8,11,14))+
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

ggsave('../plots/FigureS7B_BVTV.pdf')


#----------------------------------
# Figure S7C
#----------------------------------

# Lingual CEJ-ABC distance
ggplot(data=df,aes(x=Group,y=`Lingual(mm)`,fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(0.2, 0.4), breaks = c(0.2,0.3,0.4))+
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

ggsave('../plots/FigureS7C_Lingual.pdf')


# Buccal CEJ-ABC distance
ggplot(data=df,aes(x=Group,y=`Buccal(mm)`,fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(0.2, 0.4), breaks = c(0.2,0.3,0.4))+
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

ggsave('../plots/FigureS7_Buccal.pdf')


#----------------------------------
# Figure S7D
#----------------------------------
# GLP-1
ggplot(df, aes(x=Group,y=`GLP-1(pmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0, fill="white")+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
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


ggsave('../plots/FigureS7D_GLP-1.pdf')


#----------------------------------
# Figure S7E
#----------------------------------
# INS
ggplot(df, aes(x=Group,y=`INS(mIU/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0, fill='white')+
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

ggsave('../plots/FigureS7E_INS.pdf')


#----------------------------------
# Figure S7F
#----------------------------------
# RBGT7d
ggplot(df, aes(x=Group,y=`Glucose7d(mmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(5, 14), breaks = c(5,8,11,14))+
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


ggsave('../plots/FigureS7F_Glucose7d.pdf')



# RBGT17d
ggplot(df, aes(x=Group,y=`Glucose14d(mmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(5, 14), breaks = c(5,8,11,14))+
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


ggsave('../plots/FigureS7F_Glucose14d.pdf')

# OGTT0h
ggplot(df, aes(x=Group,y=`OGTT0h(mmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(5, 14), breaks = c(5,8,11,14))+
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


ggsave('../plots/FigureS7F_OGTT0h.pdf')

# OGTT1h
ggplot(df, aes(x=Group,y=`OGTT1h(mmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(5, 14), breaks = c(5,8,11,14))+
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


ggsave('../plots/FigureS7F_OGTT1h.pdf')


# OGTT2h
ggplot(df, aes(x=Group,y=`OGTT2h(mmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0,fill='white')+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(5, 14), breaks = c(5,8,11,14))+
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


ggsave('../plots/FigureS7F_OGTT2h.pdf')



#----------------------------------
# Figure S7G
#----------------------------------

# GHb
ggplot(df, aes(x=Group,y=`GHb(mmol/L)`, fill=Group,color=Group))+
  geom_boxplot(size=2) +
  geom_jitter(shape=21, size=4, width=0.1, height=0, fill="white")+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
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

ggsave('../plots/FigureS7G_GHb.pdf')



#----------------------------------
# Figure S7H
#----------------------------------
# CRP
ggplot(df, aes(x=Group,y=`CRP(g/L)`, fill=Group,color=Group))+
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

ggsave('../plots/FigureS7H_CRP.pdf')



