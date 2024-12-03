##Script to Figure 4A-F.

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

df_IOD <-  read.xlsx("../data/Figure4A-F&FigureS4A-G_oral transplantation with SOM bacteria.xlsx",sheet = 1)

df <-  read.xlsx("../data/Figure4A-F&FigureS4A-G_oral transplantation with SOM bacteria.xlsx",sheet = 2)

df_WB <-  read.xlsx("../data/Figure4A-F&FigureS4A-G_oral transplantation with SOM bacteria.xlsx",sheet = 3)

#----------------------------------
# Figure 4C
#----------------------------------

# IL-17
ggplot(data = df_IOD %>% subset(IL=='IL-17'),aes(Group,IOD,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  theme_bw()+theme(legend.position = 'none',axis.title.x = element_blank())+
  ylab('IL-17 IOD')+
  geom_signif(comparisons = list(c('POM+SOM','POM')),tip_length = 0,test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM'='#438cb8','POM+SOM'='#bbbaba'))


ggsave('../plots/Figure4C_IL-17.pdf')

# IL-1b
ggplot(data = df_IOD %>% subset(IL=='IL-1β'), aes(Group,IOD,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  theme_bw()+theme(legend.position = 'none',axis.title.x = element_blank())+
  ylab('IL-1β IOD')+
  geom_signif(comparisons = list(c('POM+SOM','POM')),tip_length = 0,test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM'='#438cb8','POM+SOM'='#bbbaba'))

ggsave('../plots/Figure4C_IL-1β.pdf')

#----------------------------------
# Figure 4E
#----------------------------------
# GLP-1
ggplot(data=df,aes(x=Group,y=`GLP-1(pmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  ylab('GLP−1 (pmol/L)')+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM+SOM'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure4E_GLP-1.pdf')


#----------------------------------
# Figure 4F
#----------------------------------
ggplot(data=df_WB,aes(x=Group,y=GLP1_relative_abundance,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_jitter(width = 0.1)+
  theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  ylab('GLP−1 (pmol/L)')+
  geom_signif(comparisons = list(c('POM','POM+SOM')),
              step_increase = 0.05, tip_length = 0, test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('POM+SOM'='#bbbaba',
                               'POM'='#438cb8'))

ggsave('../plots/Figure4F_GLP-1_WB.pdf')
