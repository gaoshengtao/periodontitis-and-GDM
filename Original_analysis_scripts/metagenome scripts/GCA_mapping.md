# 下载酶号对应的KO号

```
for ec in ec:2.4.1.5 ec:2.6.1.2 ec:2.7.1.121 ec:1.2.4.1 ec:2.7.1.202 ec:6.3.5.6 ec:6.3.5.7

do 

echo $ec

wget -c https://rest.kegg.jp/link/ko/$ec
```

# 下载ko对应的基因

```
cat * | cut -f 2 > ko

cut -f 1 ../ko | while read id; do wget -c http://rest.kegg.jp/link/genes/$id; done

cat ko* > ../ko_genes

cat * | cut -f 2 > ../genes.list

```

# 分割基因名
# 使用如下shell脚本，将基因名分成小组，每个小组9个，尽快检索速度

```
awk '
{
if (NR % 9 == 1) {a=$1} 
else if (NR % 9 == 2) { a=a"+"$1}
else if (NR % 9 == 3) { a=a"+"$1}
else if (NR % 9 == 4) { a=a"+"$1}
else if (NR % 9 == 5) { a=a"+"$1}
else if (NR % 9 == 6) { a=a"+"$1}
else if (NR % 9 == 7) { a=a"+"$1}
else if (NR % 9 == 8) { a=a"+"$1}
else if (NR==FNR) {a=a"+"$1; print a}
else {a=a"+"$1; print a}
}' $1 > split_gene_list.temp1
final=`cat $1 | wc -l`
echo $final
declare -i rest=$final%9
tail -n $rest $1 | awk 'NR==1{a=$1}NR>1{a=(a"+"$1)}END{print a}' > split_gene_list.temp2
cat split_gene_list.temp1 split_gene_list.temp2 > $2
rm split_gene_list.temp1 split_gene_list.temp2
```

# 基因名分割脚本，使用方法如下：

```
sh ../split.sh genes.list  genes_split.list
```

# 使用分割好的基因名文件，进行基因序列下载，下载脚本如下：
###### 下载氨基酸序列可以将ntseq改为aaseq

```
awk '{print "wget --tries=0 --retry-on-http-error=403 --wait=1 -c -O kegg_genes"NR".fasta http://rest.kegg.jp/get/"$1"/ntseq"}' $1 > kegg_genes_wget_temp.sh
sh kegg_genes_wget_temp.sh
rm kegg_genes_wget_temp.sh
```

# 基因序列下载脚本，使用方法如下
```
sh ../kegg_wget.sh ../genes_split.list &
```
# 从中抓取目标菌属的基因序列
```
seqkit grep -n -f selected.txt kegg_genes.fasta -o selected_gene.fasta

```
# 对基因集去冗余
```
cd-hit-est -i selected_gene.fasta -o selected_genes90.fasta -M 0 -T 0 -d 0 -c 0.9
```

# 复制到本地
```
cut -f 1 path.txt | while read id; do cp $id /home/wanglab/students/gaoshengtao/GDM_mate/GCAmapping/genome/; done
```
# 缺失的重新下载

```
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/355/915/GCA_002355915.1_ASM235591v1/GCA_002355915.1_ASM235591v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/150/565/GCA_025150565.1_ASM2515056v1/GCA_025150565.1_ASM2515056v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/169/475/GCA_025169475.1_ASM2516947v1/GCA_025169475.1_ASM2516947v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/169/585/GCA_025169585.1_ASM2516958v1/GCA_025169585.1_ASM2516958v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/169/785/GCA_025169785.1_ASM2516978v1/GCA_025169785.1_ASM2516978v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/169/995/GCA_025169995.1_ASM2516999v1/GCA_025169995.1_ASM2516999v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/155/GCA_025170155.1_ASM2517015v1/GCA_025170155.1_ASM2517015v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/325/GCA_025170325.1_ASM2517032v1/GCA_025170325.1_ASM2517032v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/505/GCA_025170505.1_ASM2517050v1/GCA_025170505.1_ASM2517050v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/665/GCA_025170665.1_ASM2517066v1/GCA_025170665.1_ASM2517066v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/685/GCA_025170685.1_ASM2517068v1/GCA_025170685.1_ASM2517068v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/705/GCA_025170705.1_ASM2517070v1/GCA_025170705.1_ASM2517070v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/725/GCA_025170725.1_ASM2517072v1/GCA_025170725.1_ASM2517072v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/170/885/GCA_025170885.1_ASM2517088v1/GCA_025170885.1_ASM2517088v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/075/GCA_025171075.1_ASM2517107v1/GCA_025171075.1_ASM2517107v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/215/GCA_025171215.1_ASM2517121v1/GCA_025171215.1_ASM2517121v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/235/GCA_025171235.1_ASM2517123v1/GCA_025171235.1_ASM2517123v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/255/GCA_025171255.1_ASM2517125v1/GCA_025171255.1_ASM2517125v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/275/GCA_025171275.1_ASM2517127v1/GCA_025171275.1_ASM2517127v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/295/GCA_025171295.1_ASM2517129v1/GCA_025171295.1_ASM2517129v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/171/315/GCA_025171315.1_ASM2517131v1/GCA_025171315.1_ASM2517131v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/562/635/GCA_025562635.1_ASM2556263v1/GCA_025562635.1_ASM2556263v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/562/675/GCA_025562675.1_ASM2556267v1/GCA_025562675.1_ASM2556267v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/151/385/GCA_025151385.1_ASM2515138v1/GCA_025151385.1_ASM2515138v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/151/535/GCA_025151535.1_ASM2515153v1/GCA_025151535.1_ASM2515153v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/402/735/GCA_025402735.1_ASM2540273v1/GCA_025402735.1_ASM2540273v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/402/755/GCA_025402755.1_ASM2540275v1/GCA_025402755.1_ASM2540275v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/402/775/GCA_025402775.1_ASM2540277v1/GCA_025402775.1_ASM2540277v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/152/645/GCA_025152645.1_ASM2515264v1/GCA_025152645.1_ASM2515264v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/152/665/GCA_025152665.1_ASM2515266v1/GCA_025152665.1_ASM2515266v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/152/685/GCA_025152685.1_ASM2515268v1/GCA_025152685.1_ASM2515268v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/201/235/GCA_025201235.1_ASM2520123v1/GCA_025201235.1_ASM2520123v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/136/435/GCA_025136435.1_ASM2513643v1/GCA_025136435.1_ASM2513643v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/692/935/GCA_900692935.1_18090_1_84-2/GCA_900692935.1_18090_1_84-2_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/693/025/GCA_900693025.1_19341_2_86-2/GCA_900693025.1_19341_2_86-2_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/693/055/GCA_900693055.1_19084_8_150-2/GCA_900693055.1_19084_8_150-2_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/693/075/GCA_900693075.1_19084_8_183-2/GCA_900693075.1_19084_8_183-2_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/795/205/GCA_900795205.1_22841_2_22-5/GCA_900795205.1_22841_2_22-5_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/349/925/GCA_025349925.1_ASM2534992v1/GCA_025349925.1_ASM2534992v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/273/655/GCA_025273655.1_ASM2527365v1/GCA_025273655.1_ASM2527365v1_genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/349/965/GCA_025349965.1_ASM2534996v1/GCA_025349965.1_ASM2534996v1_genomic.fna.gz
```
# blast比对

```
makeblastdb -in ./genome/genome.fna -input_type fasta -dbtype nucl -title genomedb -parse_seqids -out genomedb


blastn -db genomedb -query selected_gene.fasta -out GCAmapping  -outfmt 6 -num_threads 30 & 
```

# 整理accession与物种对应关系

```
grep '>' ./genome/genome.fna | sed -e 's/>//g' > acc_tax.txt

# gene与ko对应关系
grep '>' selected_gene.fasta | sed -e 's/>//g' > ko_genes.txt


```

