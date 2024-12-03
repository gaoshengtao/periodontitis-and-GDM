##Script to Figure S3A-G.

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

#----------------------------------
# Figure S3A
#----------------------------------

#INS
ggplot(data = df_blood, aes(x=IL, y=`INS(mIU/L)`,fill=IL))+
  geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank()) +
  scale_y_continuous(limits=c(1.5,6)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'great')


ggsave('../FigureS3A_INS.pdf')


#----------------------------------
# Figure S3B
#----------------------------------

#GLP1
ggplot(data = df_blood, aes(x=IL, y=`GLP-1(pmol/L)`,fill=IL))+
geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank()) +
  scale_y_continuous(limits=c(2,3.5)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../FigureS3B_GLP-1.pdf')


#----------------------------------
# Figure S3C
#----------------------------------
#EPI

ggplot(data = df_blood, aes(x=IL, y=`EPI(pg/ml)`,fill=IL))+
  geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank()) +
  scale_y_continuous(limits=c(130,200)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'less')


ggsave('../plots/FigureS3C_EPI.pdf')



#----------------------------------
# Figure S3D
#----------------------------------
#Cortisol

ggplot(data = df_blood, aes(x=IL, y=`Cortisol(μg/L)`,fill=IL))+
  geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank()) +
  # scale_y_continuous(limits=c(130,200)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'less')

ggsave('../plots/FigureS3D_Cortisol.pdf')



#----------------------------------
# Figure S3E
#----------------------------------
#CAT
ggplot(data = df_blood, aes(x=IL, y=`CAT(units/ml)`,fill=IL))+
  geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        # axis.text = element_blank(),
        axis.title.x = element_blank()) +
  # scale_y_continuous(limits=c(130,200)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS3E_CAT.pdf')



#----------------------------------
# Figure S3F
#----------------------------------
#SOD
ggplot(data = df_blood, aes(x=IL, y=`SOD(units/ml)`,fill=IL))+
  geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank()) +
  # scale_y_continuous(limits=c(0.4,2)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('../plots/FigureS3F_SOD.pdf')



#----------------------------------
# Figure S3G
#----------------------------------
#Gpx
ggplot(data = df_blood, aes(x=IL, y=`Gpx(min/ml)`,fill=IL))+
  geom_boxplot(width=0.7, size=1, aes(color=IL))+
  geom_jitter(shape=21, size=4, aes(color=IL), fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bbbaba',0.5),
                                'IL-17'=darken('#c4504b',0.5),
                                'IL-1β'=darken('#1d6d96',0.5))) +
  theme_bw()+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank()) +
  scale_y_continuous(limits=c(15,50)) +
  scale_fill_manual(values = c('CON'='#bbbaba',
                               'IL-17'='#c4504b',
                               'IL-1β'='#1d6d96'))+
  geom_signif(comparisons = list(c('CON','IL-17'),
                                 c('CON','IL-1β')),
              step_increase = 0.08, tip_length = 0, test = 't.test',test.args = 'great')

ggsave('./IL腹腔注射_Gpx.pdf',width = 2, height = 4)

