install.packages(c("jpeg", "png"))
library(jpeg)
library(png)

install.packages("caTools")
library(caTools)

install.packages("remotes")
remotes::install_github("davpinto/fastknn")
library(fastknn)

install.packages("BiocManager")
library(BiocManager)
BiocManager::install("jaccard")
library(jaccard)
