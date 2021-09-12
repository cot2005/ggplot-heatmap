# ggplot-heatmap
General Function to make a customizable heatmap with ggplot. Gradient scale can be customized inside of the function.

```
datatable = file name containing data
outputName = "heatmap.pdf"
sep = delimiter for data file, defaults to tabs
ggformat = boolean indicating if the data format is in ggplot format or needs to be melted, defaults to TRUE
width = 7
height = 3
transpose = boolean to switch plotting of axes, defaults to TRUE
xlab = "X title"
ylab = "Y title"
varlab = "Variable"
labels = boolean to print heatmap values in each cell, defaults to TRUE
```

