# NCL_human

<http://pachterlab.github.io/kallisto/manual.html>

```
# 建立索引 工作目录：/home/wanglab/students/gaoshengtao/human/
kallisto index Homo_sapiens.GRCh38.cdna.all.fa.gz -i kallisto.index &

# 对每个样品的基因丰度进行定量 工作目录：/home/wanglab/students/gaoshengtao/GDM_cell/

for filename in ./rawdata/NCL_human/*.R1.fastq.gz

do

base=$(basename $filename .R1.fastq.gz)

echo $base 

kallisto quant -i "/home/wanglab/students/gaoshengtao/human/kallisto.index" \
         -t 10 \
         -o ./kallisto_human/${base} \
         ./rawdata/NCL_human/${base}.R1.fastq.gz \
         ./rawdata/NCL_human/${base}.R2.fastq.gz

```
# 合并结果
```
for file in *
do
  sed -e "s/tpm/${file}/g" ./${file}/abundance.tsv > ./tmp
  mv ./tmp ./${file}
done

# 合并所有样品
paste */tmp > Combined-counts.tab
```
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# STC_mouse

<http://pachterlab.github.io/kallisto/manual.html>

```
# 建立索引 工作目录：/home/wanglab/students/gaoshengtao/mice/
kallisto index Mus_musculus.GRCm39.cdna.all.fa.gz -i kallisto_mice.index &

# 对每个样品的基因丰度进行定量 工作目录：/home/wanglab/students/gaoshengtao/GDM_cell/

for filename in ./rawdata/STC_mouse/*.R1.fastq.gz

do

base=$(basename $filename .R1.fastq.gz)

echo $base 

kallisto quant -i "/home/wanglab/students/gaoshengtao/mice/kallisto_mice.index" \
         -t 10 \
         -o ./kallisto_mouse/${base} \
         ./rawdata/STC_mouse/${base}.R1.fastq.gz \
         ./rawdata/STC_mouse/${base}.R2.fastq.gz

```
# 合并结果
```
for file in *
do
  sed -e "s/tpm/${file}/g" ./${file}/abundance.tsv > ./tmp
  mv ./tmp ./${file}
done

# 合并所有样品
paste */tmp > Combined-counts.tab