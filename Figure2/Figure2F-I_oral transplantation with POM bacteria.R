##Script to Figure 2F-I.

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

df <-  read.xlsx("../data/Figure2F-I&FigureS2F-H_oral transplantation with POM bacteria.xlsx",sheet = 1)


#----------------------------------
# Figure 2G
#----------------------------------

#Glucose7d
ggplot(data=df,aes(x=Group,y=`Glucose7d(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('great'))+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2G_Glucose7d.pdf')


# Glucose14d
ggplot(data=df,aes(x=Group,y=`Glucose14d(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('great'))+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2G_Glucose14d.pdf')

#OGTT0h
ggplot(data=df,aes(x=Group,y=`OGTT0h(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('great'))+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2G_OGTT0h.pdf')


# OGTT1h
ggplot(data=df,aes(x=Group,y=`OGTT1h(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('less'))+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2G_OGTT1h.pdf')


#OGTT2h
ggplot(data=df,aes(x=Group,y=`OGTT2h(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = c('great'))+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2G_OGTT2h.pdf')


#----------------------------------
# Figure 2H
#----------------------------------

# IL-17
ggplot(data=df,aes(x=Group,y=`IL-17(pg/ml)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2H_IL-17.pdf')


# IL-1b
ggplot(data=df,aes(x=Group,y=`IL-1β(pg/ml)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'great')+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2H_IL-1β.pdf')


#----------------------------------
# Figure 2I
#----------------------------------

# INS
ggplot(data=df,aes(x=Group,y=`INS(mIU/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2I_INS.pdf')



# GLP-1
ggplot(data=df,aes(x=Group,y=`GLP-1(pmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  geom_signif(comparisons = list(c('POM','PBS+ABX')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('PBS+ABX'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure2I_GLP-1.pdf')
