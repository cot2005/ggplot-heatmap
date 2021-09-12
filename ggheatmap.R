library(ggplot2)
library(reshape2)

ggheatmap<-function(datatable, outputName = "heatmap.pdf", sep = "\t", ggformat = TRUE, 
                    width = 7, height = 3, transpose = TRUE,
                    xlab = "X title", ylab = "Y title", varlab = "Variable", labels = TRUE) {
  # imports data
  if (ggformat == TRUE) {
    df <- read.table(datatable, sep = sep, header = T)
  } else {
    df <- read.table(datatable, sep = sep, header = T, check.names = F)
    df <- melt(df, id.vars = 1)
  }
  # transpose heatmap
  if (transpose == TRUE) {
    xcol <- 1
    ycol <- 2
    temp <- xlab
    xlab <- ylab
    ylab <- temp
  } else {
    xcol <- 2
    ycol <- 1
  }
  
  # prepares data
  df[,1] <- as.factor(df[,1])
  df[,2] <- as.factor(df[,2])
  
  fontsize <- width/2
  # begins plotting
  pdf(outputName, width = width, height = height)
  g <- ggplot(df, aes(x = df[,xcol], y = df[,ycol], fill = df[,3]))
  g <- g + geom_tile(color = "black", size = 0.15) +
    scale_fill_gradientn(colors = c("green2","white","red3"), limits = c(-13,13),
                         breaks = seq(-10,10,10),
                         values = scales::rescale(c(-15,-12,-10,0,10,12,15))) + 
    theme_minimal() + xlab(xlab) + ylab(ylab) + labs(fill=varlab) + 
    theme(axis.text=element_text(size=fontsize*2), axis.title=element_text(size=fontsize*2,face="bold"))
  if (labels == TRUE) {
    g <- g + geom_text(aes(label = round(df[,3], digits = 2)), color = "black", size = 2.75)
  }
  print(g)
  dev.off()
}
