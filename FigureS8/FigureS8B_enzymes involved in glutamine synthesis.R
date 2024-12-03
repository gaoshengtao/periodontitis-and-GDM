##Script to Figure S8B.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("openxlsx","ggplot2")
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

df <-  read.xlsx("../data/FigureS8B_abundance of enzymes involved in glutamine systhesis.xlsx",sheet = 1)

#----------------------------------
# FigureS8B
#----------------------------------

# The differential analysis of these enzymes were conducted using LEfSe. the LEfSe results were deposited 
# in 2nd sheet of FigureS8B_abundance of enzymes involved in glutamine systhesis.xlsx

ggplot(df, aes(x=Group,y=`Abundance(TPM)`,fill=Group))+
  geom_boxplot()+geom_jitter(width = 0.1)+
  facet_wrap(~Enzyme, scales = 'free')

ggsave("../plots/FigureS8B_abundance of enzymes involved in glutamine systhesis.pdf")
  