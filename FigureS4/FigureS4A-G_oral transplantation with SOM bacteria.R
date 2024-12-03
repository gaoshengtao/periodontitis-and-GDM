##Script to Figure S4A-G.

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

df <-  read.xlsx("../data/Figure4A-F&FigureS4A-G_oral transplantation with SOM bacteria.xlsx",sheet = 2)

#----------------------------------
# Figure S4B
#----------------------------------

## BV/TV
ggplot(data=df,aes(x=Group,y=`BV/TV`,fill=Group,color=Group))+
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
  # scale_y_continuous(limits=c(0, 600))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')

ggsave('../plots/FigureS4B_BVTV.pdf')


#----------------------------------
# Figure S4C
#----------------------------------

# Lingual
ggplot(data=df,aes(x=Group,y=`Lingual(mm)`,fill=Group))+
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
  # scale_y_continuous(limits=c(0.16, 0.5))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS4C_Lingual.pdf')

# Buccal
ggplot(data=df,aes(x=Group,y=`Buccal(mm)`,fill=Group))+
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
  # scale_y_continuous(limits=c(0.16, 0.5))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS4C_Buccal.pdf')

#----------------------------------
# Figure S4D
#----------------------------------
# IL-17
ggplot(data=df,aes(x=Group ,y=`IL-17(pg/ml)`,fill=Group,color=Group))+
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
  # scale_y_continuous(limits=c(0.16, 0.5))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS4D_IL-17.pdf')


#----------------------------------
# Figure S4E
#----------------------------------
# IL-1β

ggplot(data=df,aes(x=Group,y=`IL-1β(ng/L)`,fill=Group,color=Group))+
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
  # scale_y_continuous(limits=c(0.16, 0.5))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS4E_IL-1β.pdf')


#----------------------------------
# Figure S4F
#----------------------------------
# INS

ggplot(data=df,aes(x=Group,y=`INS(mIU/L)`,fill=Group,colour = Group))+
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
  # scale_y_continuous(limits=c(0.16, 0.5))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')

ggsave('../plots/FigureS4F_INS.pdf')


#----------------------------------
# Figure S4G
#----------------------------------

# Glucose7d
ggplot(data=df,aes(x=Group,y=`Glucose7d(mmol/L)`,fill=Group,color=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=1,) +
  geom_jitter(shape=21, size=2, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(4.8, 14.5),breaks = c(5,8,11,14))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  ggsignif::geom_signif(comparisons = list(c('POM','POM+SOM')),
                        test = 't.test',
                        test.args = 'great',
                        tip_length = 0)


ggsave('../plots/FigureS4F_Glucose7d.pdf')


# Glucose14d
ggplot(data=df,aes(x=Group,y=`Glucose14d(mmol/L)`,fill=Group,color=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=1,) +
  geom_jitter(shape=21, size=2, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(4.8, 14.5),breaks = c(5,8,11,14))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  ggsignif::geom_signif(comparisons = list(c('POM','POM+SOM')),
                        test = 't.test',
                        test.args = 'great',
                        tip_length = 0)


ggsave('../plots/FigureS4G_Glucose14d.pdf')


# OGTT0h
ggplot(data=df,aes(x=Group,y=`OGTT0h(mmol/L)`,fill=Group,color=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=1,) +
  geom_jitter(shape=21, size=2, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(4.8, 14.5),breaks = c(5,8,11,14))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  ggsignif::geom_signif(comparisons = list(c('POM','POM+SOM')),
                        test = 't.test',
                        test.args = 'great',
                        tip_length = 0)

ggsave('../plots/FigureS4G_OGTT0h.pdf')


# OGTT1h
ggplot(data=df,aes(x=Group,y=`OGTT1h(mmol/L)`,fill=Group,color=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=1,) +
  geom_jitter(shape=21, size=2, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(4.8, 14.5),breaks = c(5,8,11,14))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  ggsignif::geom_signif(comparisons = list(c('POM','POM+SOM')),
                        test = 't.test',
                        test.args = 'great',
                        tip_length = 0)

ggsave('../plots/FigureS4G_OGTT1h.pdf')



# OGTT2h
ggplot(data=df,aes(x=Group,y=`OGTT2h(mmol/L)`,fill=Group,color=Group))+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=1,) +
  geom_jitter(shape=21, size=2, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  scale_y_continuous(limits=c(4.8, 14.5),breaks = c(5,8,11,14))+
  scale_fill_manual(values = c('POM'='#bcb9b9',
                               'POM+SOM'='#417aa0'))+
  scale_color_manual(values = c('POM'=colorspace::darken('#bcb9b9',0.5),
                                'POM+SOM'=colorspace::darken('#417aa0',0.5)))+
  ggsignif::geom_signif(comparisons = list(c('POM','POM+SOM')),
                        test = 't.test',
                        test.args = 'great',
                        tip_length = 0)

ggsave('../plots/FigureS4G_OGTT2h.pdf')


