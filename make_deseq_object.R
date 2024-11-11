library(tidyverse)
library(DESeq2)

info = read_tsv("intersect_samp_info.txt") %>%
    mutate(data=purrr::map(path, read_tsv))

data_mat = matrix(0, nrow=nrow(info$data[[1]]), ncol=nrow(info))
row.names(data_mat) = info$data[[1]]$target_id

col_data = tibble(condition=info$condition)
rownames(col_data) = c("control1","control2","KD1","KD2")

for (i in 1:nrow(info)) {
    data_mat[,i] = as.integer(unlist(info$data[[i]][,"est_counts"], use.names=F))
}
colnames(data_mat) = c("control1","control2","KD1","KD2")

dds = DESeqDataSetFromMatrix(countData = data_mat,
                              colData = col_data,
                              design = ~ condition)

smallestGroupSize = 2
keep = rowSums(counts(dds) >= 5) >= smallestGroupSize
dds = dds[keep,]

save(dds, file="dds.RData")

