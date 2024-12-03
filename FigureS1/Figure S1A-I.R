##Script to Figure S1A-I.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("tidyverse","ggsignif","pheatmap","openxlsx")
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

df_1a_abun_mat <- read.xlsx("../data/FigureS1A_genus abundance matrix.xlsx",sheet = 1) %>% column_to_rownames(var = "Genus")

df_1a_annotation <- read.xlsx("../data/FigureS1A_genus abundance matrix.xlsx",sheet = 2) %>% column_to_rownames(var = "SampleID")

df_1a_genus_average <- read.xlsx("../data/FigureS1A_genus abundance matrix.xlsx",sheet = 3) %>% column_to_rownames(var = "Genus")

df_1b_CH_index <- read.xlsx("../data/FigureS1B_CH_index.xlsx")

df_1cd_mdi_Cdis <- read.xlsx("../data/FigureS1C-D_αdiversity_mdi.xlsx")

df_1eto1g_subset_Cdis <- read.xlsx("../data/FigureS1E-G_subset of Cdis.xlsx")

df_1h_pathway <- read.xlsx("../data/FigureS1I_KEGG pathways enriched in GDM and CON.xlsx")

#----------------------------------
# Figure S1A
#----------------------------------

pheatmap(df_1a_abun_mat, scale = 'row',cluster_cols = F, cluster_rows = F,fontsize = 8, angle_col = 45, show_rownames = T, show_colnames = F,
         breaks =c(seq(0,0.001498406,by=0.0001),seq(0.00149850,1,by=0.0001)), 
         annotation_col = df_1a_annotation, 
         annotation_row = df_1a_genus_average,
         treeheight_row=6,
         color = colorRampPalette(c("white", "pink","firebrick3"))(10000),
         filename = '../plots/FigureS1A_abundance heatmap for Cdis.pdf',
         width = 6.5,height = 7)

dev.off()
#----------------------------------
# Figure S1B
#----------------------------------

ggplot(df_1b_CH_index, aes(k_clusters, CH_index))+
  geom_col()


ggsave("../plots/FigureS1B_optimal clusters numbers.pdf")

#----------------------------------
# Figure S1C
#----------------------------------

ggplot(df_1cd_mdi_Cdis,mapping=aes(x=Group_Trimester,y=MDI, fill=Group))+
  geom_boxplot(width=0.5)+
  scale_fill_manual(values = c("#bbbaba", "#438cb8"))+
  theme_bw() + ylab("Microbial Dysbiosis index") +
  geom_signif(comparisons = list(c('CON_Trimester1','GDM_Trimester1'),
                                 c('CON_Trimester2','GDM_Trimester2'),
                                 c('CON_Trimester3','GDM_Trimester3')), tip_length = 0, test = 't.test',test.args = c("less"),
              step_increase = 0.1)+
  theme(legend.position=c(0.5,0.5),
        axis.title.x = element_blank()) 

ggsave("../plots/FigureS1C_Microbial Dysbiosis index.pdf")


#----------------------------------
# Figure S1D
#----------------------------------

ggplot(df_1cd_mdi_Cdis,mapping=aes(x=Group_Trimester,y=Shannon, fill=Group))+
  geom_boxplot(width=0.5)+
  scale_fill_manual(values = c("#bbbaba", "#438cb8"))+
  theme_bw() + ylab("Shannon index") +
  geom_signif(comparisons = list(c('CON_Trimester1','GDM_Trimester1'),
                                 c('CON_Trimester2','GDM_Trimester2'),
                                 c('CON_Trimester3','GDM_Trimester3')), tip_length = 0, test = 't.test',test.args = c("less"),
              step_increase = 0.1)+
  theme(legend.position=c(0.5,0.5),
        axis.title.x = element_blank()) 

ggsave("../plots/FigureS1D_αdiversity.pdf")


#----------------------------------
# Figure S1E-G subset of CON and GDM
#----------------------------------

# FigureS1E 
ggplot(df_1eto1g_subset_Cdis, aes(x=Group, y=Age, fill=Group))+
  theme_bw()+geom_boxplot(width=0.5)+ 
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  scale_fill_manual(values = c( "#bbbaba", "#438cb8"))+
  scale_color_manual(values = c( "#bbbaba", "#438cb8"))+
  geom_signif(comparisons = list(c('CON','GDM')),test = 't.test',test.args = c("less"))+
  ylab("Age (years)")

ggsave("../plots/FigureS1E_subset age.pdf")

# FigureS1F
ggplot(df_1eto1g_subset_Cdis,mapping=aes(x=Group_Trimester,y=MDI, fill=Group))+
  geom_boxplot(width=0.5)+
  scale_fill_manual(values = c("#bbbaba", "#438cb8"))+
  theme_bw() + ylab("Subset Microbial Dysbiosis index") +
  geom_signif(comparisons = list(c('CON_Trimester1','GDM_Trimester1'),
                                 c('CON_Trimester2','GDM_Trimester2'),
                                 c('CON_Trimester3','GDM_Trimester3')), tip_length = 0, test = 't.test',test.args = c("less"))+
  theme(legend.position=c(0.5,0.5),
        axis.title.x = element_blank()) 

ggsave("../plots/FigureS1F_subset mdi.pdf")


# FigureS1G
ggplot(df_1eto1g_subset_Cdis,mapping=aes(x=Group_Trimester,y=Shannon, fill=Group))+
  geom_boxplot(width=0.5)+
  scale_fill_manual(values = c("#bbbaba", "#438cb8"))+
  theme_bw() + ylab("Subset Shannon index") +
  geom_signif(comparisons = list(c('CON_Trimester1','GDM_Trimester1'),
                                 c('CON_Trimester2','GDM_Trimester2'),
                                 c('CON_Trimester3','GDM_Trimester3')), tip_length = 0, test = 't.test',test.args = c("less"))+
  theme(legend.position=c(0.5,0.5),
        axis.title.x = element_blank()) 

ggsave("../plots/FigureS1G_subset shannon.pdf")


#----------------------------------
# Figure S1H
#----------------------------------

ggplot(df_1h_pathway,aes(x=Pathway,y=LDA_score,fill = Group))+
  geom_col()+
  theme_minimal()+
  coord_flip()+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))

ggsave('../plots/FigureS1H_KEGG pathway.pdf')


#----------------------------------
# Figure S1I
#----------------------------------

# The data for GO terms network construction were deposited in "./FigureS1/FigureS1I_nerwork of GO terms enriched in GDM and CON.xlsx"

