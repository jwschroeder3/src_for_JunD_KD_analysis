#!/usr/bin/env Rscript
library(DESeq2)
library(BiocParallel)

# set up parallelization
cores = 4
print(paste0("Using ", cores, " cores."))
register(MulticoreParam(workers=cores)) # bpprogressbar=true
 
# set up input/output locations
out_direc = "DESeq_output"
se_fname = file.path("dds.RData")
dds_fname = file.path(
    out_direc,
    paste("DESeq_output", "deseq_fit.RData", sep="_")
)

# read in conditions and summarized expreiments object (se)
load(se_fname)

dds = DESeq(
    dds,
    parallel=TRUE
)

save(dds, file=dds_fname)
