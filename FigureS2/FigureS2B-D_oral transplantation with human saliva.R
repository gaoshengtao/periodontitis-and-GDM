##Script to Figure S2B-D.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","lvplot")
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
# Load datas
#----------------------------------

# blood indexes
blood_indexes <-  read.xlsx("../data/Figure2A-E&FigureS2B-D_oral transplantation with human saliva.xlsx",sheet = 1)

#----------------------------------
# Figure S2B
#----------------------------------

##IL-6(pg/ml)
ggplot(blood_indexes, aes(x=Group,y=`IL-6(pg/ml)`, fill=Group,color=Group))+
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
  scale_y_continuous(limits=c(50, 120))+
  scale_fill_manual(values = c('CON'='#bcbaba',
                               'GDM'='#c76c66'))+
  scale_color_manual(values = c('CON'=colorspace::darken('#bcbaba',0.5),
                                'GDM'=colorspace::darken('#c76c66',0.5)))+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))

ggsave('../plots/FigureS2B_IL-6.pdf')


#CRP
ggplot(blood_indexes, aes(x=Group,y=`CRP(μg/L)`/10, fill=Group,color=Group))+
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
  scale_y_continuous(limits=c(25, 140),breaks = c(40,80,120))+
  scale_fill_manual(values = c('CON'='#bcbaba',
                               'GDM'='#c76c66'))+
  scale_color_manual(values = c('CON'=colorspace::darken('#bcbaba',0.5),
                                'GDM'=colorspace::darken('#c76c66',0.5)))+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))

ggsave('../plots/FigureS2C_CRP.pdf')


##TNF-α(ng/L)
ggplot(blood_indexes, aes(x=Group,y=`TNF-α(ng/L)`, fill=Group,color=Group))+
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
  # scale_y_continuous(limits=c(0, 600))+
  scale_fill_manual(values = c('CON'='#bcbaba',
                               'GDM'='#c76c66'))+
  scale_color_manual(values = c('CON'=colorspace::darken('#bcbaba',0.5),
                                'GDM'=colorspace::darken('#c76c66',0.5)))+
  geom_signif(comparisons = list(c('CON','GDM')),
              tip_length = 0.01, step_increase = 0.05,test = 't.test',test.args = c('less'))

ggsave('../plots/FigureS2D_TNF-α.pdf')


