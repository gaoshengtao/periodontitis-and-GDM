##Script to Figure S10B-D.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("openxlsx","pheatmap",'lvplot')
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

df <- read.xlsx("../data/Figure6C&FigureS10B-D_DHA recover the dominance of S. salivarius.xlsx",sheet = 1)


#----------------------------------
#  Figure S10B
#----------------------------------

# prevotella intermedia
ggplot(df, aes(x=Group,y=PI_change,fill=Group))+
  geom_boxplot(width=0.5)+geom_point()+
  theme_bw()+
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),
              test = 't.test',
              test.args = 'less')+
  scale_fill_manual(values = c('GDM+DHA'='#bbbaba',
                               'GDM'='#438cb8'))+
  theme(legend.position = 'none')+
  ylab('P. intermedia change (Log10(copies)/μL)')

ggsave('../plots/FigureS10B_prevotella intermedia change.pdf')


#----------------------------------
#  Figure S10C
#----------------------------------

# PG

ggplot(df, aes(x=Group,y=PG_change,fill=Group))+
  geom_boxplot(width=0.5)+geom_point()+
  theme_bw()+
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),
              test = 't.test',
              test.args = 'less')+
  scale_fill_manual(values = c('GDM+DHA'='#bbbaba',
                               'GDM'='#438cb8'))+
  theme(legend.position = 'none')+
  ylab('P. gingivalis change (Log10(copies)/μL)')

ggsave('../plots/FigureS10C_Porphyromonas gingivalis change.pdf')


#----------------------------------
#  Figure S10D
#----------------------------------

# ST 绝对量

ggplot(df, aes(x=Group,y=ST_copies,fill=Group))+
  geom_boxplot(width=0.5)+geom_point()+
  theme_bw()+
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),
              test = 't.test',
              test.args = 'greater')+
  scale_fill_manual(values = c('GDM+DHA'='#bbbaba',
                               'GDM'='#438cb8'))+
  theme(legend.position = 'none')+
  ylab('S. salivarius abundance (Log10(copies)/μL)')

ggsave('../plots/FigureS10D_Streptococcus copies.pdf')
