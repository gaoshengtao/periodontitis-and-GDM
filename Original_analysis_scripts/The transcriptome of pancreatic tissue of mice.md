# 4.kallisto不比对直接定量

<http://pachterlab.github.io/kallisto/manual.html>

```
# 建立索引 工作目录：/home/wanglab/students/gaoshengtao/mice/
kallisto index Mus_musculus.GRCm39.cdna.all.fa.gz -i kallisto_mice.index &

# 对每个样品的基因丰度进行定量 工作目录：
for filename in LBFC20220302-49/230613_A00402_0477_AHKYCTDSX5/*.R1.fastq.gz 

do

base=$(basename $filename .R1.fastq.gz)

echo $base 

kallisto quant -i "/home/wanglab/students/gaoshengtao/mice/kallisto_mice.index" \
         -t 24 \
         -o ./kallisto/${base} \
         LBFC20220302-49/230613_A00402_0477_AHKYCTDSX5/${base}.R1.fastq.gz \
         LBFC20220302-49/230613_A00402_0477_AHKYCTDSX5/${base}.R1.fastq.gz 

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
