#!/usr/bin/env Rscript

# get command line arguments as an array
args <- commandArgs(trailingOnly = TRUE)

# files
filein <- args[1]
fileout <- args[2]

# data
data <- read.table(filein, sep="\t", header=FALSE)

# breaks
bks <- seq(0,max(data$V1/data$V2)+1,by=0.05)

# main hist
png(fileout, width=800, height=800, type="cairo")
hist(data$V1/data$V2, breaks=bks, col="red", xlim=c(0,2), xlab="query len / hit len", ylab="frequency", main=filein)
dev.off() 

# scaled hist
fileout <- gsub(".png",".500.png", fileout)
png(fileout, width=800, height=800, type="cairo")
hist(data$V1/data$V2, ylim=c(0,500), breaks=bks, col="purple", xlim=c(0,2), xlab="query len / hit len", ylab="frequency", main=filein)
dev.off()

