##Script to Figure S3H-J.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","ggsignif","openxlsx","colorspace","dplyr")
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

df_volcano <-  read.xlsx("../data/FigureS3H_volvano plot.xlsx",sheet = 1)

df_intersected_IL1β <-  read.xlsx("../data/FigureS3I_intersected genes between STC-1 and NCL-H716 treated with IL-1β.xlsx",sheet = 1)

df_GLP1_exp_NCL <- read.xlsx("../data/FigureS3J_GLP-1 expression in NCL-H716.xlsx",sheet = 1)

#----------------------------------
# Figure S3H
#----------------------------------

ggplot(df_volcano, aes(Log2FC,log10p.adj, colour = Color, shape = Group))+
  geom_point()+
  scale_color_manual(values = c('Up'='#c76d66','Down'='#368d39','NS'='#ececec'))+
  theme_bw()+
  theme(legend.position = 'none')+
  scale_shape_manual(values = c("NCL_IL17"=0,
                                "NCL_IL1b"=2,
                                "STC_IL17"=15,
                                "STC_IL1b"=17))
  
ggsave('../plots/FigureS3H.pdf')

#----------------------------------
# Figure S3I
#----------------------------------

ggplot(df_intersected_IL1β, aes(x = Group, y = Gene.name, size = abs(Log2FC), color = Color)) +  
  geom_point(alpha = 1) +  # 设置点的透明度，使重叠的点更易于区分  
  # scale_size_area(max_size = 2) +  # 设置点的大小范围，这里以面积为基准
  scale_color_manual(values = c('Up'="#cf6f68", 'Down'="#349239")) +  # 手动设置颜色，这里只是示例  
  theme_minimal() +  # 使用简洁的主题  
  theme(legend.position = "right",panel.grid.major = element_blank(), panel.grid.minor = element_blank())

ggsave('../plots/FigureS3I_intersected genes between STC-1 and NCL-H716 treated with IL-1β.pdf')


#----------------------------------
# Figure S3J
#----------------------------------

ggplot(data = df_GLP1_exp_NCL, aes(Content,TPM, fill=Content))+
  geom_boxplot(width=0.5)+
  ggsignif::geom_signif(comparisons = list(c('CON','160')), test = 't.test',test.args = 'great')+
  theme_bw()+
  ylab('Expression of GLP-1 transcripts in NCL-H716 (TPM)')+
  scale_fill_manual(values = c('CON'='#bbbaba',
                               '160'='#438cb8'))+
  theme(legend.position = 'none',
        axis.title.x = element_blank())+
  facet_wrap(~IL,scales = 'free')

ggsave('../plots/FigureS3J.pdf')






