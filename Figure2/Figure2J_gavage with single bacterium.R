##Script to Figure 2J.

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

df <-  read.xlsx("../data/Figure2J_gavage with single bacertium.xlsx",sheet = 1)

# RBGT7d
ggplot(data = df,aes(x=Group,y=`Glucose7d(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  geom_signif(comparisons = list(c('CON','Prevotella'),
                                 c('CON','Streptococcus'),
                                 c('CON','PG'),
                                 c('PG','Streptococcus'),
                                 c('Prevotella','Streptococcus')
                                 ),
              step_increase = 0.05, tip_length = 0, test = 't.test')+
  theme_bw()+
  theme(legend.position = '',
        axis.title.x=element_blank())+
  ylab('Glucose7d(mmol/L)')

ggsave('../plots/Figure2J_Glucose7d.pdf')

# RGBT14d
ggplot(data = df,aes(x=Group,y=`Glucose14d(mmol/L)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_point()+
  geom_signif(comparisons = list(c('CON','Prevotella'),
                                 c('CON','Streptococcus'),
                                 c('CON','PG'),
                                 c('PG','Streptococcus'),
                                 c('Prevotella','Streptococcus')),
              step_increase = 0.05, tip_length = 0, test = 't.test')+
  theme_bw()+
  theme(legend.position = '',
        axis.title.x=element_blank())+
  ylab('Glucose14d(mmol/L)')


ggsave('../plots/Figure2J_Glucose14d.pdf')
