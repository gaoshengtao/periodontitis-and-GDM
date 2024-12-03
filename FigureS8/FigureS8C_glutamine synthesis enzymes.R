##Script to Figure S8C.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("openxlsx","pheatmap")
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

df_heatmap <-  read.xlsx("../data/FigureS8C_gene copies of glutamine synthesis enzymes.xlsx",sheet = 1, rowNames = T)

df_annotation <- read.xlsx("../data/FigureS8C_gene copies of glutamine synthesis enzymes.xlsx",sheet = 2, rowNames = T)


#----------------------------------
#  Figure S8C
#----------------------------------

# heatmap
pheatmap(df_heatmap, cluster_rows = F, cluster_cols = F, show_rownames = F, show_colnames = T,
         annotation_row = df_annotation, filename = "../plots/FigureS8C_gene copies of glutamine synthesis enzymes.pdf")


dev.off()
# pie plots

# The source data for pie plots were deposited in FigureS8C_enzymes abundance contributed by oral bacteria.xlsx






