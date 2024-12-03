##Script to Figure 6C.

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

df_glucose_PD_change <- read.xlsx("../data/Figure6B&6D&6F_Fasting glucose change after DHA applivation.xlsx",sheet = 1)



#----------------------------------
#  Figure 6C
#----------------------------------

# S. sallivarius vs P. intermedia

ggplot(df, aes(x=Group,y=STvsPI_change,color=Group, fill=Group)) +
  #geom_point(size = 4, alpha = 0.75, position = position_jitter(width=0.05)) +
  geom_boxplot(size=1.5, width=0.2, position = position_dodge(width = 0.5), outlier.colour = NA) + 
  ggdist::stat_halfeye(alpha = 0.3, width=0.3, adjust=0.5, justification=-0.6, .width=0, point_color=NA) + 
  ggdist::stat_dots(justification=-0.6, .width=0.1, scale=0.29)+
  scale_color_manual(values = c('GDM+DHA'=darken('#438cb8',0.5),'GDM'=darken('#bbbaba',0.5))) +
  scale_fill_manual(values = c('GDM+DHA'='#438cb8','GDM'='#bbbaba')) +
  scale_y_continuous(limits=c(-0.2,0.28), expand = c(0, 0))+
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),test = 't.test',test.args = 'greater')+
  theme_bw() + theme(legend.position = "none", axis.title.x=element_blank(), axis.text=element_blank())

ggsave('../plots/Figure6C_change of S. salivarius vs P. intermedia.pdf')


# S. salivarius vs P. gingivalis
ggplot(df, aes(x=Group,y=STvsPG_change,color=Group, fill=Group)) +
  #geom_point(size = 4, alpha = 0.75, position = position_jitter(width=0.05)) +
  geom_boxplot(size=1, width=0.2, position = position_dodge(width = 0.5), outlier.colour = NA) + 
  ggdist::stat_halfeye(alpha = 0.3, width=0.3, adjust=0.5, justification=-0.6, .width=0, point_color=NA) + 
  ggdist::stat_dots(justification=-0.6, .width=0.1, scale=0.35)+
  scale_color_manual(values = c('GDM+DHA'=darken('#438cb8',0.5),'GDM'=darken('#bbbaba',0.5))) +
  scale_fill_manual(values = c('GDM+DHA'='#438cb8','GDM'='#bbbaba')) +
  scale_y_continuous(limits=c(-0.4,0.65), expand = c(0, 0))+
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),test = 't.test',test.args = 'greater')+
  theme_bw() + theme(legend.position = "none", axis.title.x=element_blank(), axis.text=element_blank())

ggsave('../plots/Figure6C_change of S. salivarius vs P. gingivalis.pdf')

