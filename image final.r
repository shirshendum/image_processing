splitratio <- 0.1
kvalue <- 3
image = readJPEG("6100_1_3_RGB.jpg")
mask = readPNG("6100_1_3_MASK.png")


size = dim(image)
test <- data.frame(
  x = rep(1:size[2], each = size[1]),
  y = rep(size[1]:1, size[2]),
  R = as.vector(image[,,1]),
  G = as.vector(image[,,2]),
  B = as.vector(image[,,3]),
  target = as.vector(mask)
)


split = sample.split(test$target, SplitRatio = splitratio)
train = subset(test, split == TRUE)

xtr <- as.matrix(train[,-6])
xte <- as.matrix(test[,-6])
ytr <- factor(train[,6])

### The fast KNN function

knnout <- fastknn(xtr = xtr, ytr = ytr, xte = xte, k = kvalue)
pred <- (as.numeric(knnout$class)-1)
truth <- (as.vector(mask))

ans <- jaccard(pred, truth)
cat("Jaccard score is " ,ans)

## Printing out the image as a PNG file

out <- data.frame(
  x = rep(1:size[2], each = size[1]),
  y = rep(size[1]:1, size[2]),
  target = as.vector(pred)
)

try1 <- reshape(out, idvar = "x", timevar = "y", direction = "wide")
save(try1, file = "try.Rdata")
try2 <- (try1[,-1])
try3 <- t(data.matrix(try2))
class(try3) <- "nativeRaster"
writePNG(try3, target = "6100_1_3_OUTPUT.png")

### Printing the Jaccard score again
cat("Jaccard score is " ,ans)
