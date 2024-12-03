##Script to Figure 4G.

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

#----------------------------------
# Figure 4G
#----------------------------------


# RBGT 14d
ggplot(data=df_RBGT %>% subset(Day=='14d'),aes(x=Group,y=`Glucose(mmol/L)`,fill=Group, color=Group))+
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


ggsave('../plots/Figure4G_RBGT14d.pdf')


# OGTT0h
ggplot(data=df_OGTT,aes(x=Group,y=`OGTT0h(mmol/L)`,fill=Group, color=Group))+
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


ggsave('../plots/Figure4G_OGTT0h.pdf')
