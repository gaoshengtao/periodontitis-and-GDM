##Script to Figure 5A-C.

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

df_RBGT <-  read.xlsx("../data/Figure4H-J&FigureS6A-E_oral transplantation with single bacterium.xlsx",sheet = 1)

df_volcano <- read.xlsx("../data/Figure5B_volvano plot.xlsx",sheet = 1)

df_top5 <- read.xlsx("../data/Figure5A_mebolites in saliva from late pregnancy.xlsx",sheet = 1)
  
df_class <- read.xlsx("../data/Figure5A_mebolites in saliva from late pregnancy.xlsx",sheet = 2)

df_pie <- read.xlsx("../data/Figure5A_mebolites in saliva from late pregnancy.xlsx",sheet = 3, rowNames = T) %>% as.matrix()

df_earlymet <-  read.xlsx("../data/Figure5A_mebolites in saliva from late pregnancy.xlsx",sheet = 4)

#----------------------------------
# Figure 5A
#----------------------------------

# Top5 compounds up or down in GDM vs CON
ggplot(data = df_top5, aes(x=Group, y=Abundance,fill=Group, color=Group))+
  geom_boxplot(width=0.7, size=1)+
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  scale_color_manual(values = c('CON'=darken('#bcbaba',0.5),
                                'GDM'=darken('#d28179',0.5)
  )) +
  theme_bw()+
  theme(legend.position = 'none',
        # axis.text = element_blank(),
        axis.title.x = element_blank()) +
  # scale_y_continuous(limits=c(0.4,2)) +
  scale_fill_manual(values = c('GDM'='#d28179',
                               'CON'='#bcbaba'))+
  facet_wrap(~Metabolite, scales = 'free')


ggsave('../plots/Figure5A_Top5 compounds up or down in GDM vs CON.pdf')


# Concentration of each class metabolites

ggplot(df_class)+
  geom_col(aes(x=Metabolite,y=Abundance,fill =Group,colour = Group),position = 'dodge')+
  theme_minimal()+
  coord_flip()+
  theme(axis.title.y = element_blank(),
        axis.text.y = element_text(angle = -45))+
  ylab('Abundance (μmol/L)')+
  scale_fill_manual(values = c('GDM'='#d28179',
                               'CON'='#bcbaba'))+
  scale_color_manual(values = c('GDM'=colorspace::darken('#d28179',0.5),
                                'CON'=colorspace::darken('#bcbaba',0.5)))


ggsave('../plots/Figure5A_Concentration of each class metabolites.pdf')


# percentage of compounds detected in each class
pdf(file = '../plots/Figure5A__mebolites in saliva from late pregnancy.pdf')

pie(sort(df_pie*100/sum(df_pie)), labels = rownames(df_pie))

dev.off()

#----------------------------------
# Figure 5B
#----------------------------------
#volcano plot

ggplot(df_volcano, aes(Log2FC,y=VIP,color=Color,label=Metabolite))+
  geom_point(aes(size=-log10(pvalue)))+
  # scale_color_gradient(low = "#bababa", high = "red", space = "Lab", name = "VIP") +  # 设置渐变颜色  
  theme_classic()+
  ggrepel::geom_text_repel()+
  theme(legend.position = 'none')+
  scale_color_manual(values = c('Up'='#b85e51',
                                'Down'='#6f9a63',
                                'NS'='#bcbaba'))

ggsave("../plots/Figure5B_volcano plot.pdf")


#----------------------------------
# Figure 5C
#----------------------------------

# Fructose
ggplot(df_earlymet,aes(x=Group,y=`Fructose(mg/ml)`,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_signif(comparisons = list(c('GDM','CON')),tip_length = 0,test = 't.test',test.args = 'great')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))+
  theme_bw()+ ylab('Fructose (mg/ml)')+
  theme(legend.position = 'none',
        axis.title.x = element_blank())

ggsave('../plots/Figure5C_fructose in early pregnancy.pdf')


#Glycerate
ggplot(df_earlymet,aes(x=Group,y=`Glycerate(mg/ml)`*100000,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_signif(comparisons = list(c('GDM','CON')),tip_length = 0,test = 't.test',test.args = 'great')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))+
  theme_bw()+ ylab('Glycerate (ng/ml)')+
  theme(legend.position = 'none',
        axis.title.x = element_blank())

ggsave('../plots/Figure5C_glycerate in early pregnancy.pdf')


#DHA
ggplot(df_earlymet,aes(x=Group,y=`DHA(mg/ml)`*1000,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_signif(comparisons = list(c('GDM','CON')),tip_length = 0,test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))+
  theme_bw()+ ylab('DHA (μg/ml)')+
  theme(legend.position = 'none',
        axis.title.x = element_blank())

ggsave('../plots/Figure5C_DHA in early pregnancy.pdf')

#Glutamine
ggplot(df_earlymet,aes(x=Group,y=`Glutamine(mg/ml)`*1000,fill=Group))+
  geom_boxplot(width=0.5)+
  geom_signif(comparisons = list(c('GDM','CON')),tip_length = 0,test = 't.test',test.args = 'less')+
  scale_fill_manual(values = c('GDM'='#438cb8',
                               'CON'='#bbbaba'))+
  theme_bw()+ ylab('DHA (μg/ml)')+
  theme(legend.position = 'none',
        axis.title.x = element_blank())

ggsave('../plots/Figure5C_glutamine in early pregnancy.pdf')
