##Script to oral microbiota type analysis.

#----------------------------------
# Load packages (and install if they are not installed yet)
#----------------------------------
cran_packages=c("cluster","clusterSim","ade4","vegan","openxlsx")
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

source('trans.R')

otu_table_Cdis <- read.xlsx("../data/ASV tables of oral microbiota of cohorts.xlsx",startRow = 5, sheet =1)
otu_table_Cint <- read.xlsx("../data/ASV tables of oral microbiota of cohorts.xlsx",startRow = 5, sheet =2)
otu_table_Cval <- read.xlsx("../data/ASV tables of oral microbiota of cohorts.xlsx",startRow = 5, sheet =3)

metadata_Cdis <- read.xlsx("../data/metadata for cohorts.xlsx",startRow = 5, sheet =1)
metadata_Cint <- read.xlsx("../data/metadata for cohorts.xlsx",startRow = 5, sheet =2)
metadata_Cval <- read.xlsx("../data/metadata for cohorts.xlsx",startRow = 5, sheet =3)

metadata <- data.frame(SampleID=c(metadata_Cdis$SampleID,metadata_Cval$SampleID,metadata_Cint$SampleID),
                       Group=c(metadata_Cdis$Group,metadata_Cval$Group,metadata_Cint$Group),
                       Type_original=c(metadata_Cdis$Type,metadata_Cval$Type,metadata_Cint$Type),
                       Source=c(rep('Cdis',length(metadata_Cdis$SampleID)),rep('Cval',length(metadata_Cval$SampleID)),rep('Cint',length(metadata_Cint$SampleID)))
                       )
set.seed(18)
genus_Cdis <- trans(otu_table_Cdis) #%>% column_to_rownames(var = 'Genus')
genus_Cval <- trans(otu_table_Cval) #%>% column_to_rownames(var = 'Genus')
genus_Cint <- trans(otu_table_Cint) #%>% column_to_rownames(var = 'Genus')

#交集
genus_name <- intersect(intersect(genus_Cdis$Genus,genus_Cval$Genus),genus_Cint$Genus)
genus <- data.frame(Genus=genus_name)

#并集
genus_name <- c(genus_Cdis$Genus,genus_Cval$Genus,genus_Cint$Genus)
genus_name <- genus_name[!duplicated(genus_name)]
genus <- data.frame(Genus=genus_name)



genus <- left_join(genus,genus_Cdis,by="Genus")
genus <- left_join(genus,genus_Cval,by="Genus")
genus <- left_join(genus,genus_Cint,by="Genus")

# genus <- merge(genus_Cval,genus_Cint, by='Genus')
# genus <- merge(genus,genus_Cdis, by='Genus')

genus <- genus %>% column_to_rownames(var = 'Genus')
genus[is.na(genus)] <- 0

## 写函数
## JSD计算样品距离，PAM聚类样品，CH指数估计聚类数，比较Silhouette系数评估聚类质量。
dist.JSD <- function(inMatrix, pseudocount=0.000001, ...)
{
  ## 函数：JSD计算样品距离
  KLD <- function(x,y) sum(x *log(x/y))
  JSD<- function(x,y) sqrt(0.5 * KLD(x, (x+y)/2) + 0.5 * KLD(y, (x+y)/2))
  matrixColSize <- length(colnames(inMatrix))
  matrixRowSize <- length(rownames(inMatrix))
  colnames <- colnames(inMatrix)
  resultsMatrix <- matrix(0, matrixColSize, matrixColSize)
  
  inMatrix = apply(inMatrix,1:2,function(x) ifelse (x==0,pseudocount,x))
  
  for(i in 1:matrixColSize)
  {
    for(j in 1:matrixColSize)
    { 
      resultsMatrix[i,j]=JSD(as.vector(inMatrix[,i]), as.vector(inMatrix[,j]))
    }
  }
  colnames -> colnames(resultsMatrix) -> rownames(resultsMatrix)
  as.dist(resultsMatrix)->resultsMatrix
  attr(resultsMatrix, "method") <- "dist"
  return(resultsMatrix) 
}

pam.clustering = function(x, k)
{ 
  ## 函数：PAM聚类样品
  # x is a distance matrix and k the number of clusters
  require(cluster)
  cluster = as.vector(pam(as.dist(x), k, diss=TRUE)$clustering)
  return(cluster)
}


## 2. 选择CH指数最大的K值作为最佳聚类数
data.dist = dist.JSD(genus)

# data.cluster=pam.clustering(data.dist, k=3) # k=3 为例 
# nclusters = index.G1(t(data), data.cluster, d = data.dist, centrotypes = "medoids") # 查看CH指数
nclusters = NULL

for(k in 1:20) { 
  if(k==1)
  {
    nclusters[k] = NA 
  }
  else
  {
    data.cluster_temp = pam.clustering(data.dist, k)
    nclusters[k] = index.G1(t(genus), data.cluster_temp,  d = data.dist, centrotypes = "medoids")
  }
}

plot(nclusters, type="h", xlab="k clusters", ylab="CH index", main="Optimal number of clusters") # 查看K与CH值得关系

nclusters[1] = 0
k_best = which(nclusters == max(nclusters), arr.ind = TRUE)

## 3. PAM根据JSD距离对样品聚类(分成K个组)
data.cluster=pam.clustering(data.dist, k = k_best)

## 4. silhouette评估聚类质量，-1=<S(i)=<1，越接近1越好
mean(silhouette(data.cluster, data.dist)[, 3])

#plot 2
obs.pcoa=dudi.pco(data.dist, scannf=F, nf=3)

s.class(obs.pcoa$li, fac=as.factor(data.cluster), grid=F,sub="Principal coordiante analysis", col=c(1,2,3,4))

Type <- data.frame(SampleID=colnames(genus), Type=data.cluster)

Type$Type <- ifelse(Type$Type==1,'SOM','POM')

write.csv(Type, '../data/Type.csv')


