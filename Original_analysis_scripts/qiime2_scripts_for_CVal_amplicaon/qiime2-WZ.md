#====================
# 工作目录：/home/wanglab/students/gaoshengtao/GDM_16s_WZ/
#====================


# Step 1: Making a Sample-Sheet (sample-metadata.tsv) for the Project
# Step 2: Importing paired-end demultiplexed data
time qiime tools import \
--type 'SampleData[PairedEndSequencesWithQuality]' \
--input-path sample_manifest.txt \
--output-path paired-demux.qza \
--input-format PairedEndFastqManifestPhred33V2

# 去除引物
# 338F	ACTCCTACGGGAGGCAGCAG	806R	GGACTACHVGGGTWTCTAAT
time qiime cutadapt trim-paired \
--i-demultiplexed-sequences paired-demux.qza \
--p-front-f ACTCCTACGGGAGGCAGCAG \
--p-front-r GGACTACHVGGGTWTCTAAT  \
--o-trimmed-sequences trim_paired-demux.qza \
--verbose 
> primer_trimming.log

# 查看文件质量

time qiime demux summarize \
   --i-data trim_paired-demux.qza \
   --o-visualization demux_qulity_check.qzv
   
# Sequence quality control and feature table construction (using DADA2)

time qiime dada2 denoise-paired \
--i-demultiplexed-seqs trim_paired-demux.qza \
--p-trunc-len-f 230 \
--p-trunc-len-r 230 \
--o-table table \
--p-n-threads 0 \
--o-representative-sequences rep-seqs \
--o-denoising-stats denoising-stats

# 特征表统计

time qiime feature-table summarize \
--i-table table.qza \
--o-visualization table.qzv \
--m-sample-metadata-file sample_matedata.txt

# 代表序列统计

time qiime feature-table tabulate-seqs \
--i-data rep-seqs.qza \
--o-visualization raw.fq.list

# 比对代表性序列，构建系统发育树

time qiime phylogeny align-to-tree-mafft-fasttree \
--i-sequences rep-seqs.qza \
--o-alignment aligned-rep-seqs.qza \
--o-masked-alignment masked-aligned-rep-seqs.qza \
--o-tree unrooted-tree.qza \
--o-rooted-tree rooted-tree.qza \
--p-n-threads "auto" 

# ASV注释

qiime feature-classifier classify-sklearn \
   --i-classifier "/home/wanglab/students/gaoshengtao/silva/silva-138-ssu-nr99-338f-806r-classifier.qza" \
   --i-reads rep-seqs.qza \
   --o-classification taxonomy.qza
   
# 导出特征序列

qiime tools export \
--input-path rep-seqs.qza \
--output-path qiime2 

# 导出特征表

qiime tools export \
--input-path table.qza \
--output-path qiime2 

# biom格式转换

biom convert \
-i qiime2/feature-table.biom \
-o qiime2/otu_table.tsv \
--to-tsv 
   
# 导出无根进化树

qiime tools export \
--input-path unrooted-tree.qza \
--output-path qiime2
cd qiime2; mv tree.nwk unrooted_tree.nwk; cd ../

# 导出有根进化树

qiime tools export \
--input-path rooted-tree.qza \
--output-path qiime2
cd qiime2; mv tree.nwk rooted_tree.nwk; cd ..

# 导出注释文件

qiime tools export \
--input-path taxonomy.qza \
--output-path qiime2/

# 稀释曲线

qiime diversity alpha-rarefaction \
   --i-table table.qza \
   --i-phylogeny rooted-tree.qza \
   --p-max-depth 5000 \
   --m-metadata-file sample_matedata.txt \
   --o-visualization ./qiime2/alpha-rarefaction.qzv 
   
# 多样性分析

 qiime diversity core-metrics-phylogenetic \
   --i-phylogeny rooted-tree.qza \
   --i-table table.qza \
   --p-sampling-depth 4981 \
   --m-metadata-file sample_matedata.txt \
   --output-dir core-metrics-results
   
# picrust2_pipeline.py -h 功能注释

picrust2_pipeline.py \
   -i feature-table.biom \
   -s dna-sequences.fasta \
   -o q2-picrust2_output \
   -p 20 
   
