library(ggplot2)
library(reshape2)

ggheatmap<-function(datatable, outputName = "heatmap.pdf", sep = "\t", ggformat = TRUE, 
                    width = 7, height = 3, transpose = T,
                    xlab = "X title", ylab = "Y title", varlab = "Variable") {
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
  
  # begins plotting
  pdf(outputName, width = 7, height = 3)
  g <- ggplot(df, aes(x = df[,xcol], y = df[,ycol], fill = df[,3]))
  g <- g + geom_tile(color = "black", size = 0.25) + 
    geom_text(aes(label = round(df[,3], digits = 2)), color = "black") +
    scale_fill_gradientn(colors = c("green2","white","red3"), limits = c(-15,15),
                         breaks = seq(-10,10,10),
                         values = scales::rescale(c(-15,-12,-10,0,10,12,15))) + 
    theme_minimal() + xlab(xlab) + ylab(ylab) + labs(fill=varlab)
  print(g)
  dev.off()
}
