##Script to Figure S4H-K.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","tibble","openxlsx","dplyr",'ggsignif')
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

df_volcano <-  read.xlsx("../data/FigureS4H_volcano plot.xlsx",sheet = 1)

df_metabolism_PCoA <- read.xlsx("../data/FigureS4J_gut metabolism_PCoA.xlsx",sheet = 1)

df_liver_RNA_exp <- read.xlsx("../data/FigureS4K_gene expression in liver.xlsx",sheet = 1)

#----------------------------------
# Figure S4H
#----------------------------------

ggplot(data = df_volcano, aes(x=log2FoldChange,y=-log10(padj), color=Color,label=Label))+
  geom_point(aes(size=Size))+
  theme_bw()+
  scale_color_manual(values = c('n.s.'='#efefef',
                                'POM'='#bbbaba',
                                'POM+SOM'='#438cb8'))+
  ggrepel::geom_label_repel(color='black')+
  xlim(-6,8)+
  ylim(0,8)+
  theme(legend.position = c(0.1,0.7))

ggsave('../plots/FigureS4H_valcano plot.pdf')


#----------------------------------
# Figure S4I
#----------------------------------

# Results of GSEA analysis are deposited in FigureS4I_GESA.xlsx


#----------------------------------
# Figure S4J
#----------------------------------

ggplot(df_metabolism_PCoA, aes(x=PCoA1, y=PCoA2, color=Group))+
  geom_point(size=4)+
  labs(x="PCoA1(30%)", y="PCoA2(18%)")+
  stat_ellipse(type ="t", linetype = 1, level = 0.95)+
  scale_color_manual(values = c('POM'='#bcb9b9',
                                'POM+SOM'='#417aa0'))+
  theme_bw()+
  theme(legend.position = c(0.85,0.1))

ggsave("../plots/FigureS4J_gut metabolism_PCoA.pdf")

#----------------------------------
# Figure S4K
#----------------------------------

ggplot(df_liver_RNA_exp, aes(x=Group,y=RTresult,fill=Group))+
  geom_boxplot(width=0.5)+geom_point()+
  ylab('Relative mRNA expression of GLP-1 in STC')+theme_bw()+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  facet_wrap(~Gene)+
  geom_signif(comparisons = list(c('POM+SOM','POM')), tip_length = 0, test = 't.test',test.args = 'less')

ggsave("../plots/FigureS4K_PCK and G6PC expression in liver.pdf")

