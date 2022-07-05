library(correlation)
library(pheatmap)
library(optparse)

option_list <- list(
    make_option(c("-g", "--gene_exp"     ), type="character", default = NULL                                       , metavar="path"   , help="Input gene_exp file"  	  ),
    make_option(c("-m", "--meta_exp"     ), type="character", default = NULL                                       , metavar="path"   , help="Input meta_exp file"  	  ),
    make_option(c("-c", "--corr"         ), type="character", default = "pearson"                                  , metavar="string" , help="method of correlation"      ),
    make_option(c("-o", "--output"       ), type="character", default = "./Gene_and_Meta_correlation_results.csv"  , metavar="path"   , help="Output file/Directory"      )
)

opt_parser <- OptionParser(option_list = option_list)
opt        <- parse_args(opt_parser)

if (is.null(opt$gene_exp)){
    print_help(opt_parser)
    stop("Please provide a gene_exp file.", call.=FALSE)
}
if (is.null(opt$meta_exp)){
    print_help(opt_parser)
    stop("Please provide a meta_exp file.", call.=FALSE)
}


gene_exp  = read.table(opt$gene_exp, sep="\t",header = T,row.names = 1)
meta_exp  = read.table(opt$meta_exp, sep="\t",header = T,row.names = 1)

gene_exp_input = t(as.matrix(gene_exp))
meta_exp_input = t(as.matrix(meta_exp))

metaGeneCor.r <- cor(gene_exp_input, meta_exp_input, method=opt$corr)
write.csv(metaGeneCor.r,file=opt$output)

pheatmap(metaGeneCor.r,show_rownames = F,show_colnames = F, filename = "Gene_and_Meta_correlation_results.pdf")

