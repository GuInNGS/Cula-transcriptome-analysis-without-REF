setwd("")
dir()
input_data <- read.table("deseq2_input.txt", header=TRUE, row.names=1)
input_data <-round(input_data,digits = 0)
input_data <- as.matrix(input_data)
condition <- factor(c(rep("ct1", 2), rep("exp", 2)))
coldata <- data.frame(row.names=colnames(input_data), condition)

library(DESeq2)

dds <- DESeqDataSetFromMatrix(countData=input_data,colData=coldata, design=~condition)

dds <- DESeq(dds)

res <- results(dds,alpha=0.05)

summary(res)

res <- res[order(res$padj), ]
res

resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
names(resdata)[1] <- "Gene"

write.table(resdata,file="diffexpr-results.txt",sep = "\t",quote = F, row.names = F)

#According to the document("diffexpr-results.txt"), we can use "awk" in linux to extract up and down regulated genes
#extract up-regulated gene;
awk '{if($3>1 && $7<0.05)print $0}' diffexpr-results.txt |cut -f 1,2,4,7 > up.gene.txt
#extract down-regulated gene;
awk '{if($3<-1 && $7<0.05)print $0}' diffexpr-results.txt |cut -f 1,2,4,7 > down.gene.txt

