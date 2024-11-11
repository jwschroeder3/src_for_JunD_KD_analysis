# Code and input data for JunD KD RNA-seq analysis in ShapeME paper

Run the following to reproduce our analysis:

```bash
mkdir DESeq_output
Rscript make_deseq_object.R
Rscript fit_deseq_model.R
Rscript get_deseq_results_for_contrast.R
```
