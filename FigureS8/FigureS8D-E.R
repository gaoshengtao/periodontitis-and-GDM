##Script to Figure S8D-E.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","ggrepel","dplyr","RColorBrewer", "pheatmap")
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

df_ordination_met <-  read.xlsx("../data/FigureS8D_mmvec of metabolites and microbiome.xlsx",sheet = 1)

df_ordination_genus <- read.xlsx("../data/FigureS8D_mmvec of metabolites and microbiome.xlsx",sheet = 2)

df_exp_prop <- read.xlsx("../data/FigureS8D_mmvec of metabolites and microbiome.xlsx",sheet = 3)

df_corr_cof_matrix <- read.xlsx("../data/FigureS8E_metabolites and microbiome correlation.xlsx",sheet = 1, rowNames = T)
  
df_corr_p_matrix <- read.xlsx("../data/FigureS8E_metabolites and microbiome correlation.xlsx",sheet = 1, rowNames = T)

#----------------------------------
# Figure S8D
#----------------------------------

ggplot()+
  geom_point(aes(x=Axis1, y=Axis2, color=Color, size=abs(Log2FC)), data = df_ordination_met)+
  geom_segment(aes(xend=Axis1/80, yend=Axis2/80, x=0, y=0, color=Type), data = df_ordination_genus, arrow = arrow(length = unit(0.2,"cm")))+
  geom_text_repel(aes(x=Axis1/80, y=Axis2/80, label=Genus, color=Type), data = df_ordination_genus, size=2)+
  geom_text_repel(aes(x=Axis1, y=Axis2, label=Metabolite,color=Color), data = df_ordination_met[df_ordination_met$label!='n.s.',], size=2)+
  theme_bw()+xlab(paste0('Axis1','(',round(df_exp_prop$Axis1*100,2),'%)'))+ylab(paste0('Axis2','(',round(df_exp_prop$Axis2*100,2),'%)'))+
  theme(legend.position='none')+
  scale_color_manual(values = c('Up'='#f5aa9c','Down'='#9dce95','SOM'='#9dce95','POM'='#f5aa9c','n.s.'='#e5e5e5'))+
  scale_size_continuous(range=c(0,10))+
  xlim(-0.3,0.3)+
  ylim(-0.25,0.25)

ggsave('../plots/FigureS8D_mmvec.pdf')


#----------------------------------
# Figure S8E
#----------------------------------

genus_order <- c('g__Streptococcus','g__Gemella',	'g__Veillonella',	'g__Prevotella',
                 'g__Neisseria',	'g__Rothia',	'g__Porphyromonas',	'g__Actinomyces',	
                 'g__Granulicatella',	'g__TM7x')

pheatmap(df_corr_cof_matrix[,genus_order],cluster_rows = F, cluster_cols = F,
                   display_numbers =df_corr_p_matrix[,genus_order],
                   filename = '../plots/FigureS8E_correlation between metabolites and microbiome.pdf')

dev.off()





