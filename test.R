require(mice)
require(parallel)
set.seed(123)
y <- rnorm(1000000)
x <- y + rnorm(1000000, 0, .5)
cor(y, x)
idx <- sample(1:1000000, 500000)
idy <- sample(1:1000000, 500000)
x[idx] <- NA
y[idy] <- NA

test <- data.frame(y, x)
names(test)
md.pattern(test)

st1 <- Sys.time()
imp1 <- mice(test, method = "norm", m=6, print = FALSE)
rt1 <- st1 - Sys.time()

st2 <- Sys.time()
imp2 <- parlMICE(test, method = "norm", n.core=2, n.imp.core = 3)
rt2 <- st2 - Sys.time()