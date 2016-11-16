#'Function to run mice parallel
#'
#'This is a wrapper function for mice. With this function, imputations will be 
#'performed parallel using multiple cores. Consequently the procedure is speeded 
#'up. 
#'
#'@param
#'
#'@return
#'
#'@author Rianne Schouten, Gerko Vink, Peter Lugtig, 2016
#'@seealso
#'@references
#'@examples 
#'@export
parallelMICE <- function(data, n.imp.core = 1, m = 30,
                         n.core = detectCores() - 1, 
                         seed = NULL, ...){
  suppressMessages(require(parallel))
  cl <- makeCluster(n.core)
  clusterEvalQ(cl, library(mice))
  if (!is.null(seed)) {
    clusterSetRNGStream(cl, seed)
  }
  imps <- parLapply(cl = cl, X = 1:n.core, fun = function(empty){
    mice(nhanes, print = FALSE, m = m, ...)
    })
  stopCluster(cl)
  imp <- ibind(imps[[1]], imps[[2]])
  for (i in 3:length(imps)) {
    imp <- ibind(imp, imps[[i]])
  }
  return(imp)
}

result1 <- parallelMICE(data = nhanes, seed = 10,
                        m = 100, method = "norm.nob")

# Check wheter it is faster, ibind is slowing things down
steps <- seq(10, 1000, 20)
result <- matrix(NA, nrow = length(steps), ncol = 2)
for (i in 1:length(steps)) {
  mt <- steps[i]
  st1 <- Sys.time()
  result1 <- parallelMICE(data = nhanes, m = mt, method = "norm")
  # it works with m = a value, but not with m = mt, why? 
  result[i, 1] <- Sys.time() - st1
  st2 <- Sys.time()
  result2 <- mice(nhanes, m = mt * 3, print = FALSE)
  result[i, 2] <- Sys.time() - st2
}
