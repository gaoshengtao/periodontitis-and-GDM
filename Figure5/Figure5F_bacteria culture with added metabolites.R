##Script to Figure 5F.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("tidyverse","ggsignif","openxlsx","pheatmap")
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

df_growth_curves <-  read.xlsx("../data/Figure5F_100x_bacteria culture with added metabolites.xlsx",sheet = 1)

df_AUC_changes <- read.xlsx("../data/Figure5F_100x_bacteria culture with added metabolites.xlsx",sheet = 2) %>% column_to_rownames(var = "Metabolites")


#----------------------------------
# Figure5F
#----------------------------------

col_sp = "#d6251f"
col_con = "#525252"


ggplot(data = df_growth_curves) + 
  geom_line(aes(x=Time, y=OD600,group=Metabolites_rep,color=Metabolites),alpha=0.7, linewidth=0.5)+
  theme_classic()+
  theme(panel.grid=element_blank(),
        panel.border=element_blank(),
        panel.background=element_blank(),
        # axis.text=element_blank(),
        axis.title=element_blank(),
        legend.position="none"
  )+
  scale_y_continuous(expand = c(0,0),limits = c(0,2))+
  scale_x_continuous(expand = c(0,0),limits = c(0,50))+
  # scale_y_continuous(expand = c(0,0),limits = c(0,1.6)) +
  # scale_x_continuous(expand = c(0,0),limits = c(0,50))+
  scale_color_manual(values = c(
    "CON"=col_con,
    "Fructose"=col_sp,
    "Glycerate"= col_sp,
    "Ketovaline"= col_sp,
    "Oxoglutarate"= col_sp,
    "(S)-OMV"= col_sp,
    "DPAn−6" = col_sp,
    "EPA"= col_sp,
    "Pyruvate" = col_sp,
    "DHA"= col_sp,
    "Glutamine"= col_sp
  )) +
  facet_wrap(~Genus+Batch)

ggsave("../plots/Figure5F_100x_bacteria culture with added metabolites_growth curves.pdf")


# AUC changes

color1 = colorRampPalette(rev(c("#fddbc7","#FFFFFF")))(3)
color2 = colorRampPalette(rev(c("#FFFFFF","#2166ac")))(22)


pheatmap(df_AUC_changes, scale = 'none', cluster_rows = F, cluster_cols = F, color = c(color2, color1),
         filename = "../plots/Figure5F_100x_bacteria culture with added metabolites_AUC.pdf")

dev.off()
