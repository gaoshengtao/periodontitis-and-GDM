##Script to Figure 6B&6D-F.

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

df_glucose_matrix <-  read.xlsx("../data/Figure6B&6D&6F_Fasting glucose change after DHA applivation.xlsx",sheet = 2)

df_week0_glucose <- read.xlsx("../data/Figure6E_fasting glucose in week 0.xlsx",sheet = 1)


#----------------------------------
#  Figure 6B
#----------------------------------

ggplot(df_glucose_PD_change, aes(x=Group,y=PD_change,color=Group, fill=Group))+
  geom_boxplot(size=1.5, width=0.2, position = position_dodge(width = 0.5), outlier.colour = NA) + 
  geom_jitter(shape=21, size=2, fill="white", width=0.1, height=0)+
  ggdist::stat_halfeye(alpha = 0.3, width=0.3, adjust=0.5, justification=-0.6, .width=0, point_color=NA) + 
  scale_color_manual(values = c('GDM+DHA'=darken('#438cb8',0.5),'GDM'=darken('#bbbaba',0.5))) +
  scale_fill_manual(values = c('GDM+DHA'='#438cb8','GDM'='#bbbaba')) +
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),test = 't.test',test.args = 'less')+
  theme_bw() + theme(legend.position = "none", axis.title.x=element_blank(), axis.text=element_blank())

ggsave("../plots/Figure6B_periodontal probing depth change.pdf")

#----------------------------------
#  Figure 6D
#----------------------------------


pheatmap(df_glucose_matrix[,3:9],cluster_rows = F, cluster_cols = F, annotation_row = df_glucose_matrix[,1:2], show_rownames = F,
         filename = "../plots/Figure6D_fasting glucose change.pdf")

dev.off()
#----------------------------------
#  Figure 6E
#----------------------------------

ggplot(df_week0_glucose, aes(x=Group,y=Glucose,color=Group,fill=Group))+
  lvplot::geom_lv(k=7, outlier.shape = NA) + theme_bw()+
  geom_jitter(shape=19, size=2, fill="white", width=0.1, height=0) +
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000") +
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),
              test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('GDM+DHA'='#438cb8',
                               'GDM'='#bbbaba'))+
  scale_color_manual(values = c('GDM+DHA'=darken('#438cb8',0.5),
                                'GDM'=darken('#bbbaba',0.5)))+
  scale_y_continuous(limits=c(3.5,7), expand = c(0, 0))+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())

ggsave('../plots/Figure6E_fasting glucose in week 0.pdf')


#----------------------------------
#  Figure 6F
#----------------------------------

ggplot(df_glucose_PD_change, aes(x=Group,y=Glucose_change,color=Group,fill=Group))+
  lvplot::geom_lv(k=7, outlier.shape = NA) + theme_bw()+
  geom_jitter(shape=19, size=2, fill="white", width=0.1, height=0) +
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000") +
  geom_signif(comparisons = list(c('GDM+DHA','GDM')),
              test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('GDM+DHA'='#438cb8',
                               'GDM'='#bbbaba'))+
  scale_color_manual(values = c('GDM+DHA'=darken('#438cb8',0.5),
                                'GDM'=darken('#bbbaba',0.5)))+
  theme(legend.position = 'none',
        axis.text = element_blank(),
        axis.title.x = element_blank())

ggsave("../plots/Figure6F_glucose change.pdf")
