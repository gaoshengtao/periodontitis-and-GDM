
# Periodontitis and GDM Multi-Omics Analysis

This repository contains the complete analysis workflow, scripts, and documentation used in the study: **"Oral Microbiota Remodeling Contributes to Glycemic Control in GDM"**.

## 📁 Repository Structure

```
├── data/                  # Processed data used for analysis
├── scripts/               # Analysis scripts (R, Python, Bash)
│   ├── preprocessing/     # 16S rRNA preprocessing (QIIME2)
│   ├── diversity/         # Alpha/beta diversity calculation
│   ├── differential/      # LEfSe, DESeq2, Wilcoxon tests
│   ├── correlation/       # Correlation and regression analyses
│   ├── visualization/     # Scripts to generate figures
├── results/               # Intermediate & final results
├── figures/               # Manuscript-ready plots
└── README.md              # This documentation
```

## 🔁 Workflow Overview

1. **16S rRNA Data Processing:** QIIME2 denoising, OTU picking, taxonomy assignment
2. **Diversity Analysis:** Calculation of Shannon index, Bray-Curtis distance
3. **Differential Abundance:** LEfSe and Wilcoxon rank-sum tests for genus-level features
4. **Microbiota-Trait Association:** Spearman correlation, multiple linear regression
5. **DHA-Microbiome Analysis:** DHA quantification & regression with microbial taxa
6. **Mouse Data Analysis:** Alveolar bone loss, inflammatory markers, phenotype association

## 📊 Reproducing Manuscript Figures

| Figure | Script Location | Description |
|--------|------------------|-------------|
| Fig 1B | scripts/visualization/fig1B_PHATE_embedding.R | PHATE embedding of oral samples |
| Fig 1C | scripts/differential/fig1C_bacteria_lineplot.R | SOM/POM bacteria trend over pregnancy |
| Fig 1D | scripts/visualization/fig1D_transition_plot.R | Transition from SOM to POM in GDM |
| Fig 3B | scripts/correlation/fig3B_DHA_correlation.R | DHA correlation with GDM-associated bacteria |
| Fig 4A | scripts/mouse/fig4A_bone_loss_plot.R | Bone resorption in mouse model |
| Fig S9G| scripts/invitro/figS9G_DHA_consumption.R | In vitro DHA consumption by bacteria |

## 🧰 Dependencies

- QIIME2 2022.11
- R 4.2.2 with packages: `phyloseq`, `ggplot2`, `vegan`, `DESeq2`, `pheatmap`
- Python 3.9 (for LEfSe and plotting)
- LEfSe 1.0.8 (Galaxy or local version)
- GraphPad Prism (for some statistical plots, optional)

## 🧪 How to Reproduce

```bash
# Clone the repo
git clone https://github.com/gaoshengtao/periodontitis-and-GDM.git
cd periodontitis-and-GDM

# Check the README in each folder for instructions
cd scripts/visualization/
Rscript fig1B_PHATE_embedding.R
```

## 📌 Notes

- Raw data of 16S rRNA amplicon sequencing of saliva specimens of CDis, CInt, and CVal and metagenome sequencing raw data of saliva specimens from late pregnancy of CDis have been deposited in GSA-Human (https://ngdc.cncb.ac.cn/gsa-human/) with BioProject accession: PRJCA030797. RNAseq raw data of NCL-H716 cell lines have been deposited in GSA-Human (https://ngdc.cncb.ac.cn/gsa-human/) with BioProject accession: PRJCA030813. RNAseq raw data of STC-1 cell lines and mice pancreas of POM and POM+SOM have been deposited in GSA (https://ngdc.cncb.ac.cn/gsa/) with BioProject accession: PRJCA030813. 16S rRNA amplicon sequencing raw data of in vitro culture of saliva and POM and SOM have been deposited in GSA (https://ngdc.cncb.ac.cn/gsa/) with BioProject accession: PRJCA030812. 
- Only processed feature tables (OTU/ASV) are included here for reproducibility
- Some figures require intermediate files (stored in `/results/`)

## 📫 Contact

For questions or feedback, please contact **shengtaogao@163.com** or open an issue on GitHub.
