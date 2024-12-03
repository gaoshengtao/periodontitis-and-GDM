##Script to Figure S5A-H.

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

df_RBGT <-  read.xlsx("../data/Figure4G&FigureS5_oral transplantation in male female pregnant mice.xlsx",sheet = 1)

df_OGTT <- read.xlsx("../data/Figure4G&FigureS5_oral transplantation in male female pregnant mice.xlsx",sheet = 2)

df_Blood <- read.xlsx("../data/Figure4G&FigureS5_oral transplantation in male female pregnant mice.xlsx",sheet = 3)

df_RT <- read.xlsx("../data/Figure4G&FigureS5_oral transplantation in male female pregnant mice.xlsx",sheet = 4)

#----------------------------------
# Figure S5A
#----------------------------------

# RBGT7d
ggplot(data=df_RBGT %>% subset(Day=='7d'),aes(x=Group,y=`Glucose(mmol/L)`,fill=Group,color=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')


ggsave('../plots/FigureS5A_RBGT7d.pdf')


# OGTT1h
ggplot(df_OGTT, aes(x=Group,y=`OGTT1h(mmol/L)`, color=Group, fill=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')
  

ggsave('../plots/FigureS5A_OGTT1h.pdf')

# OGTT2h
ggplot(df_OGTT, aes(x=Group,y=`OGTT2h(mmol/L)`, color=Group, fill=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')


ggsave('../plots/FigureS5A_OGTT2h.pdf')


#----------------------------------
# Figure S5B
#----------------------------------

# GLP-1 (pmol/L)
ggplot(df_Blood, aes(x=Group,y=`GLP-1(pmol/L)`, color=Group, fill=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')

ggsave('../plots/FigureS5B_GLP-1.pdf')


#----------------------------------
# Figure S5C
#----------------------------------
# INS(mIU/L)
ggplot(df_Blood, aes(x=Group,y=`INS(mIU/L)`, color=Group, fill=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')

ggsave('../plots/FigureS5C_INS.pdf')


#----------------------------------
# Figure S5D
#----------------------------------
# IL17(pg/ml)
ggplot(df_Blood, aes(x=Group,y=`IL-17(pg/ml)`, color=Group, fill=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS5D_IL-17.pdf')


#----------------------------------
# Figure S5E
#----------------------------------
# IL-1β
ggplot(df_Blood, aes(x=Group,y=`IL-1β(ng/L)`, color=Group, fill=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('POM+SOM'='#4385af',
                               'POM'='#bcbaba'))+
  scale_color_manual(values = c('POM+SOM'=darken('#4385af',0.5),
                                'POM'=darken('#bcbaba',0.5)))+
  facet_wrap(~Mice)+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS5E_IL-1β.pdf')



#----------------------------------
# Figure S5F
#----------------------------------

#RT GLP-1
ggplot(data=df_RT %>% subset(Target=='GLP-1'),aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.2)+geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM+SOM'='#bbbaba',
                               'POM'='#438cb8'))+
  facet_wrap(~Mice)+
  ylab('GLP-1 relative expression')

ggsave('../plots/FigureS5F_RT_GLP-1.pdf')



#----------------------------------
# Figure S5G
#----------------------------------

#RT GLP-1
ggplot(data=df_RT %>% subset(Target=='G6PC'),aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.2)+geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM+SOM'='#bbbaba',
                               'POM'='#438cb8'))+
  facet_wrap(~Mice)+
  ylab('G6PC relative expression')

ggsave('../plots/FigureS5G_RT_G6PC.pdf')


#----------------------------------
# Figure S5G
#----------------------------------

#RT G6PC
ggplot(data=df_RT %>% subset(Target=='G6PC'),aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.2)+geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM+SOM'='#bbbaba',
                               'POM'='#438cb8'))+
  facet_wrap(~Mice)+
  ylab('G6PC relative expression')

ggsave('../plots/FigureS5G_RT_G6PC.pdf')


#----------------------------------
# Figure S5H
#----------------------------------

#RT PCK
ggplot(data=df_RT %>% subset(Target=='PCK'),aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.2)+geom_point()+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test')+
  scale_fill_manual(values = c('POM+SOM'='#bbbaba',
                               'POM'='#438cb8'))+
  facet_wrap(~Mice)+
  ylab('PCK relative expression')

ggsave('../plots/FigureS5H_RT_PCK.pdf')
