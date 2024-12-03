##Script to Figure S9B-G.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("ggplot2","tibble","openxlsx","dplyr",'ggsignif',"colorspace")
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

df_RA_saliva <-  read.xlsx("../data/FigureS9B-G_saliva and oral bacteria culture in vitro.xlsx",sheet = 1)

df_cell_count <-  read.xlsx("../data/FigureS9B-G_saliva and oral bacteria culture in vitro.xlsx",sheet = 2)

df_RA_bacteria <-  read.xlsx("../data/FigureS9B-G_saliva and oral bacteria culture in vitro.xlsx",sheet = 3)

df_DHA_change <-  read.xlsx("../data/FigureS9B-G_saliva and oral bacteria culture in vitro.xlsx",sheet = 4)


#----------------------------------
# Figure SB-C
#----------------------------------

ggplot(df_RA_saliva,aes(x=Group,y=Relative_abundance,color=Group, fill=Group))+
  geom_boxplot(outlier.shape=NA, size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('DHA'='#4385af',
                               'CON'='#bcbaba'))+
  scale_color_manual(values = c('DHA'=darken('#4385af',0.5),
                                'CON'=darken('#bcbaba',0.5)))+
  facet_wrap(~Genus,scales = 'free')+
  geom_signif(comparisons = list(c('CON','DHA')), tip_length = 0,test.args = 'great',test = 't.test')

ggsave('../plots/FigureS9B-C_relative abundance of saliva bacteria.pdf')


#----------------------------------
# Figure S9D
#----------------------------------

ggplot(df_cell_count, aes(Group,Cell_count, color=Group, fill=Group))+
  geom_boxplot(outlier.shape=NA, size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('DHA'='#4385af',
                               'CON'='#bcbaba'))+
  scale_color_manual(values = c('DHA'=darken('#4385af',0.5),
                                'CON'=darken('#bcbaba',0.5)))+
  geom_signif(comparisons = list(c('CON','DHA')), tip_length = 0,test.args = 'great',test = 't.test')

ggsave('../plots/FigureS9D_cell count.pdf')


#----------------------------------
# Figure S9E-F
#----------------------------------

ggplot(df_RA_bacteria,aes(x=Group,y=Relative_abundance,color=Group, fill=Group))+
  geom_boxplot(outlier.shape=NA, size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c('DHA'='#4385af',
                               'CON'='#bcbaba'))+
  scale_color_manual(values = c('DHA'=darken('#4385af',0.5),
                                'CON'=darken('#bcbaba',0.5)))+
  facet_wrap(~Genus,scales = 'free')+
  geom_signif(comparisons = list(c('CON','DHA')), tip_length = 0,test.args = 'great',test = 't.test')

ggsave('../plots/FigureS9E-F_relative abundance of bacteria culture in vitro.pdf')


#----------------------------------
# Figure S9G
#----------------------------------

ggplot(df_DHA_change,aes(x=reorder(Genus,desc(DHA_change)),
                      y=-DHA_change,fill=Genus,colour = Genus))+
  geom_boxplot(outlier.shape=NA, size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  # scale_y_continuous(limits=c(5, 15), breaks=c(5,10,15), expand = c(0, 0))+
  scale_fill_manual(values = c("PG"='#3b549c',
                               'Strep'='#7cc9ea',
                               "Prev"='#b86660'))+
  scale_color_manual(values = c('PG'=darken('#4385af',0.5),
                                'Strep'=darken('#7cc9ea',0.5),
                                'Prev'=darken('#b86660',0.5)))+
  ggsignif::geom_signif(comparisons = list(c("PG",'Strep'),
                                           c('PG','Prev'),
                                           c('Prev','Strep')),
                        tip_length = 0, step_increase = 0.1)+
  ylab('DHA decreased after bacterias innoculated (%)')



ggsave('../plots/FigureS9D_DHA change after bacterial innoculation.pdf')


