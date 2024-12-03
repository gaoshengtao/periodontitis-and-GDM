##Script to Figure S8A.

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

df <-  read.xlsx("../data/FigureS8A_metabolites change after POM or SOM innoculation.xlsx",sheet = 1, rowNames = T)

#----------------------------------
# FigureS8A
#----------------------------------

pheatmap(df,cluster_rows = F, display_numbers = T, filename = "../plots/FigureS8A_metabolites change after POM or SOM innoculation.pdf")

dev.off()



