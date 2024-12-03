#! /bin/bash

# kneaddata去除宿主及质控
for filename in ./Rawdata/*R1.raw.fastq.gz 

do 

base=$(basename $filename R1.raw.fastq.gz)

echo $base

kneaddata -t 100 \
--input /home/wanglab/students/gaoshengtao/GDM_mate_CQ/Rawdata/${base}R1.raw.fastq.gz \
--input /home/wanglab/students/gaoshengtao/GDM_mate_CQ/Rawdata/${base}R2.raw.fastq.gz \
--output /home/wanglab/students/gaoshengtao/GDM_mate_CQ/cleandata_kneaddata \
--reference-db ~/database/kneaddata \
--trimmomatic /home/wanglab/apps/anaconda3/envs/humann3/share/trimmomatic-0.39-2/ \
--run-fastqc-start \
--run-fastqc-end \
--remove-intermediate-output 

done

# BWA进行宏基因组定量

# 构建索引
bwa index "/home/wanglab/students/gaoshengtao/GDM_mate_CQ/species_genome/all_genes.fasta"

# bbmap rename
for filename in ./cleandata_kneaddata/*.R1.raw_kneaddata_paired_1.fastq

do 

base=$(basename $filename .R1.raw_kneaddata_paired_1.fastq); 

bbrename.sh in=./cleandata_kneaddata/${base}.R1.raw_kneaddata_paired_1.fastq in2=./cleandata_kneaddata/${base}.R1.raw_kneaddata_paired_2.fastq out=./cleandata_kneaddata/${base}.R1.raw_kneaddata_paired_1_renamed.fastq out2=./cleandata_kneaddata/${base}.R1.raw_kneaddata_paired_2_renamed.fastq

done

 
# bwa 比对
for filename in ./cleandata_kneaddata/*.R1.raw_kneaddata_paired_1_renamed.fastq

do 

base=$(basename $filename .R1.raw_kneaddata_paired_1_renamed.fastq); 

bwa mem -t 104 ./species_genome/all_genes.fasta ./cleandata_kneaddata/${base}.R1.raw_kneaddata_paired_1_renamed.fastq ./cleandata_kneaddata/${base}.R1.raw_kneaddata_paired_2_renamed.fastq -o ./species_genome/BWA_sam/${base}.sam

done

bwa mem -t 104 ./species_genome/all_genes.fasta ./cleandata_kneaddata/L1HGD070137-G_3_855.R1.raw_kneaddata_paired_1_renamed.fastq ./cleandata_kneaddata/L1HGD070137-G_3_855.R1.raw_kneaddata_paired_2_renamed.fastq -o ./species_genome/BWA_sam/L1HGD070137-G_3_855.sam

# Samtools转换sam文件为bam文件 1.3版本前 单个样本举例，多样本for循环
source /home/wanglab/apps/anaconda3/bin/activate samtools

for filename in ./species_genome/BWA_sam/*.sam

do 
base=$(basename $filename .sam)

samtools view -bS ./species_genome/BWA_sam/${base}.sam > ./species_genome/BWA_sam/${base}.bam

done &

samtools view -bS ./species_genome/BWA_sam/L1HGD070137-G_3_855.sam > ./species_genome/BWA_sam/L1HGD070137-G_3_855.bam

# 排序
for filename in ./species_genome/BWA_sam/*.bam

do 

base=$(basename $filename .bam)

samtools sort ./species_genome/BWA_sam/${base}.bam > ./species_genome/BWA_sam/${base}_sort.bam

done

# 建索引

for filename in *_sort.bam

do 

base=$(basename $filename _sort.bam)

samtools index ${base}_sort.bam

done
 
# 获取每个ORF比对的read数
for filename in *_sort.bam

do 

base=$(basename $filename _sort.bam)

samtools idxstats ${base}_sort.bam > ${base}_mapped.txt 

done

