##Script to Figure S2F-H.

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
# Load dates
#----------------------------------

df <-  read.xlsx("../data/Figure2F-I&FigureS2F-H_oral transplantation with POM bacteria.xlsx",sheet = 1)


#----------------------------------
# Figure 2I
#----------------------------------

# BV/TV

ggplot(df, aes(x=Group,y=`BV/TV`, fill=Group,color=Group))+
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
  scale_y_continuous(limits=c(0.1, 0.6))+
  scale_fill_manual(values = c('PBS+ABX'='#bcbaba',
                               'POM'='#c76c66'))+
  scale_color_manual(values = c('PBS+ABX'=colorspace::darken('#bcbaba',0.5),
                                'POM'=colorspace::darken('#c76c66',0.5)))+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('less'))

ggsave('../plots/FigureS2F_BVTV.pdf')


# Lingual CEJ-ABC distance
ggplot(df, aes(x=Group,y=`Lingual(mm)`, fill=Group,color=Group))+
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
  scale_y_continuous(limits=c(0.15, 0.6))+
  scale_fill_manual(values = c('PBS+ABX'='#bcbaba',
                               'POM'='#c76c66'))+
  scale_color_manual(values = c('PBS+ABX'=colorspace::darken('#bcbaba',0.5),
                                'POM'=colorspace::darken('#c76c66',0.5)))+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('great'))

ggsave('../plots/FigureS2F_Lingual.pdf')


# Buccal CEJ-ABC distance
ggplot(df, aes(x=Group,y=`Buccal(mm)`, fill=Group,color=Group))+
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
  scale_y_continuous(limits=c(0.15, 0.55))+
  scale_fill_manual(values = c('PBS+ABX'='#bcbaba',
                               'POM'='#c76c66'))+
  scale_color_manual(values = c('PBS+ABX'=colorspace::darken('#bcbaba',0.5),
                                'POM'=colorspace::darken('#c76c66',0.5)))+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('great'))

ggsave('../plots/FigureS2F_Buccal.pdf')



