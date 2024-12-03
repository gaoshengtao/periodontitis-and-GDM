##Script to Figure 1A-F.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("tidyverse","openxlsx","VennDiagram", "phyloseq", "igraph", "markovchain","phateR","viridis")
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


df_metadata <- read.xlsx("../data/Figure1A_metadata for cohorts.xlsx",sheet = 1)

df_1b_RAplot <- read.xlsx("../data/Figure1B_relative abundance of bacteria in Cdis.xlsx",sheet = 1)

df_1c_log2fc <- read.xlsx("../data/Figure1C_change of oral microbiota from T1 to T3.xlsx")

df_1e_mosaic <- read.xlsx("../data/Figure1E_mosaic.xlsx")

df_1f_phate <- read.xlsx("../data/Figure1F_PHATE analysis.xlsx",rowNames = T)

df_1f_BC_dis <- read.xlsx("../data/Figure1F_Bray-Curtis distance.xlsx")


#----------------------------------
# Figure 1A
#----------------------------------
# bar plot

fig1a_sum <- table(df_metadata$Group,df_metadata$Week) %>% as.data.frame()

ggplot(fig1a_sum, aes(Var1,Freq,group = Var2, color=Var2,fill = Var2))+
  geom_col()

# venn plot
fig1a_venn <- df_metadata[df_metadata$Group=='GDM' & df_metadata$Cohorts == "Cdis",c('Subject','Fasting_Glucose','OGTT1h_Glucose','OGTT2h_Glucose')]

# 绘制三个集合的Venn图
venn.diagram(
  x = list(
    Fasting_yes = fig1a_venn[fig1a_venn$Fasting_Glucose>=5.1 & !is.na(fig1a_venn$Fasting_Glucose),]$Subject,
    OGTT1h_yes = fig1a_venn[fig1a_venn$OGTT1h_Glucose>=10 & !is.na(fig1a_venn$OGTT1h_Glucose),]$Subject,
    OGTT2h_yes = fig1a_venn[fig1a_venn$OGTT2h_Glucose>=8.5 & !is.na(fig1a_venn$OGTT2h_Glucose),]$Subject
  ),
  category.names = c("Fasting_yes", "OGTT1h_yes", "OGTT2h_yes"),
  filename = '../plots/Figure1A.png'
)

#----------------------------------
# Figure 1B
#----------------------------------
ggplot(data = df_1b_RAplot, aes(SampleID,Abundance,fill = Genus))+  
  geom_bar(stat = "identity", position = "fill") +    
  labs(y = "Relative Abundance",  
       fill = "Category") + 
  theme_minimal()+
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

ggsave("../plots/Figure1B_relative abundance of bacteria in Cdis.pdf")


#----------------------------------
# Figure 1C
#----------------------------------
ggplot(df_1c_log2fc, aes(x=Trimester, y=Log2FC, color=Genus, group=Genus))+
  theme_minimal()+
  geom_vline(xintercept ='Trimester1')+
  geom_vline(xintercept ='Trimester2')+
  geom_vline(xintercept ='Trimester3')+
  theme(legend.position = 'none',
        axis.title = element_blank(),
        axis.text = element_blank())+
  geom_line(linewidth=2, alpha=0.5)+geom_point(size=5, alpha=0.8)+
  scale_color_manual(values = c(
    'g__TM7x' = '#E82903',
    'g__Prevotella'='#F93E12',
    'g__Porphyromonas'='#F95731',
    'g__Actinomyces'='#FA7151',
    'g__Granulicatella' ='#FB8B70',
    'g__Rothia' ='#FCA490',
    'g__Neisseria' ='#FDBEB0',
    'g__Veillonella' ='#FDD8CF',
    'g__Streptococcus' ='#8B9EB9',
    'g__Gemella' ='#284B7E'
  ))

ggsave("../plots/Figure1C.pdf")


#----------------------------------
# Figure 1D
#----------------------------------

# Sanky was ploted using the data deposited in './Figure 1D sanky plot.xlsx' in a online tool: http://sankey-diagram-generator.acquireprocure.com/

#  Markov chain diagrams 


#set function to filter samples
samdat.prune_prev <- function(samdat) {
  GAP_MIN <- 1
  GAP_MAX <- 1500
  samdf <- data.frame(samdat)
  subjects <- unique(samdf$Subject)
  csub <- split(samdf, samdf$Subject)
  for(sub in subjects) {
    cc <- csub[[sub]]
    cc <- cc[order(cc$Week),]
    cc$PrevID <- c(NA, cc$SampleID[-nrow(cc)])
    del <- cc$Week - c(-999, cc$Week[-nrow(cc)])
    keep <- del>=GAP_MIN & del<=GAP_MAX
    if(sum(keep) == 0) {
      csub[[sub]] <- NULL
    } else {
      cc <- cc[keep,]
      csub[[sub]] <- cc
    }
  }
  return(do.call(rbind, csub))
}

##calculate transition probability


samdf <- df_metadata
samdf$Type <- ifelse(samdf$Type=='SOM',1,2)
# samdf$Trimester <- ifelse(samdf$Trimester=='Trimester1',1,
#                           ifelse(samdf$Trimester=='Trimester2',2,3))
rownames(samdf) <- samdf$SampleID
samdf$Week <- as.numeric(samdf$Week)

samdf$Type <- factor(samdf$Type)
CSTs <- levels(samdf$Type)
nstates <- nlevels(samdf$Type)
samdf_prev <- samdat.prune_prev(samdf)
rownames(samdf_prev) <- samdf_prev$Sample_ID
samdf_prev$PrevCST <- samdf[samdf_prev$PrevID,"Type"]
samdf_prev$CurCST <- samdf_prev$Type
ttab <- table(samdf_prev$PrevCST, samdf_prev$CurCST) # prevstate=row, curstate=col
trans <- matrix(ttab, nrow=nstates)
trans <- trans/rowSums(trans)  # Normalize row sums to 1
CSTtrans <- trans
colnames(CSTtrans) <- CSTs
rownames(CSTtrans) <- CSTs
t_persist <- -1/log(diag(CSTtrans))

##plot markov chain
mcPreg <- new("markovchain", states=CSTs,
              transitionMatrix = trans, name="PregCST")
netMC <- markovchain:::.getNet(mcPreg, round = TRUE)
wts <- E(netMC)$weight/100
edgel <- get.edgelist(netMC)
elcat <- paste(edgel[,1], edgel[,2])
elrev <- paste(edgel[,2], edgel[,1])
edge.curved <- sapply(elcat, function(x) x %in% elrev)
default.par <- par(no.readonly = TRUE)
plotMC <- function(object, ...) {
  netMC <- markovchain:::.getNet(object, round = TRUE)
  plot.igraph(x = netMC, ...)  
}
vert.sz <- 2*sapply(states(mcPreg), 
                    function(x) nrow(unique(sample_data(samdf)[sample_data(samdf)$Type==x,"Subject"])))
vert.sz <- log(vert.sz)*5
vert.font.clrs <- c("white", "white", "white", "white")
edge.loop.angle = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14, 0, 0, 0, 0, 0)-0.45
layout <- matrix(c(0.6,0.95, 0.43,1, 0.3,0.66, 0.55,0.3), nrow=4, ncol=2, byrow=T)
#layout(matrix(c(1,1,2,2), 2, 2, byrow = TRUE), heights=c(1,10))
par(mar=c(0,1,1,1)+0.1)
edge.arrow.size=1
edge.arrow.width=1
edge.width = (6*wts + 0.1)
edge.labels <- as.character(E(netMC)$weight/100)
edge.labels[edge.labels<0.2] <- NA  # labels only for self-loops

pdf(file = '../plots/Figure1D_markov_chain_GDM.pdf')

##plot
plotMC(mcPreg, edge.arrow.size=edge.arrow.size, edge.arrow.width = edge.arrow.width,
       edge.label = edge.labels, edge.label.font=2, edge.label.cex=1.3, edge.label.color="black",
       edge.width=edge.width, edge.curved=edge.curved, 
       vertex.size=(vert.sz),
       vertex.label.font = 2, vertex.label.cex = 2,
       vertex.label.color = vert.font.clrs, vertex.frame.color = NA, 
       vertex.color = c("#DFAD9F","#86A4CF"),
       layout = layout, edge.loop.angle = edge.loop.angle)

dev.off()

#----------------------------------
# Figure 1E
#----------------------------------


ggplot()+
  geom_rect(aes(ymin = ymin, ymax = ymax, xmin = xmin, xmax = xmax, fill = Type),df_1e_mosaic,colour = "black") + 
  geom_text(aes(x = xtext, y = ytext,  label = paste0(value,'%')),df_1e_mosaic ,size = 4)+
  geom_text(aes(x = xtext, y = -3, label = segment),df_1e_mosaic ,size = 4)+
  geom_text(aes(x = 102, y = seq(25,100,50), label = c("SOM","POM")), size = 4,hjust = 0)+
  scale_x_continuous(breaks=seq(0,100,25),limits=c(0,110))+
  scale_fill_manual(values = c('POM'='#dfad9f','SOM'='#86a4cf'))+
  theme_void()+
  theme(legend.position="none")

ggsave('../plots/Figure1E_mosaic.pdf')


#----------------------------------
# Figure 1F
#----------------------------------

# PHATE analysis

Cdis_val_PHATE <- phate(df_1f_phate)

ggplot(Cdis_val_PHATE) +
  geom_point(aes(PHATE1, PHATE2)) +
  labs(color="Mpo")

ggsave('../plots/Figure1F_PHATE analysis.pdf')

# Bray-Curtis distance between POM and SOM from Cval and Cdis
ggplot(df_1f_BC_dis,aes(x=reorder(Group,Distance,FUN = median),
               y=Distance, fill=Group))+
  xlab('BC distance')+
  lvplot::geom_lv(k=5, outlier.shape = NA)+
  geom_boxplot(outlier.shape=NA, coef=0, fill="#00000000", size=2,) +
  geom_jitter(shape=21, size=4, fill="white", width=0.1, height=0)+
  theme_bw()+
  theme(legend.position = 'none',
        legend.background =element_blank(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        # axis.text = element_blank(),
        axis.title.y = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_blank())+
  coord_flip()

ggsave('../plots/Figure1F_Bray-Curtis distance.pdf')
