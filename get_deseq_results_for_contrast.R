#!/usr/bin/env Rscript
# this script will output the results of a specified comparison from our deseq fit
library(DESeq2)
library(IHW)

# set up input/output locations
out_direc = "DESeq_output"
outprefix = "DESeq_output"
deseq_fname = file.path(out_direc, paste( outprefix, "deseq_fit.RData", sep="_"))

load(deseq_fname)

possible_contrasts = resultsNames(dds)
#print(possible_contrasts)
cont = as.integer(possible_contrasts == "condition_KD_vs_control")
#print(contrast.type.1)
#print(cont)
#stop()
res.IHW <- results(
    dds,
    contrast=cont,
    filterFun=ihw
)
res.LFC <- lfcShrink(
    dds,
    contrast=cont,
    type="ashr"
)
resmat <- results(
    dds,
    contrast=cont
)

resmat$padj.IHW = res.IHW$padj
resmat$log2fc.shrunk = res.LFC$log2FoldChange
out_fname = file.path(out_direc, "KD_vs_control_results.csv")
print(paste0("Writing results to ", out_fname))
write.csv( resmat[order(resmat$padj.IHW),], out_fname, quote=FALSE)

