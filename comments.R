#function to run mice in parallel
require(parallel)
require(mice)
#how many cores?
detectCores()

#
library(parallel)
# Using all cores can slow down the computer
# significantly, I therefore try to leave one
# core alone in order to be able to do something 
# else during the time the code runs
cores_2_use <- detectCores() - 1
cl <- makeCluster(cores_2_use)
clusterSetRNGStream(cl, 9956)
clusterExport(cl, "nhanes")
clusterEvalQ(cl, library(mice))
st1 <- Sys.time()
imp_pars <- 
  parLapply(cl = cl, X = 1:cores_2_use, fun = function(no){
    mice(nhanes, m = 30, print = FALSE)
  })
stopCluster(cl)
rt1 <- Sys.time() - st1

st2 <- Sys.time()
    mice(nhanes, m = 210, print = FALSE)
rt2 <- Sys.time() - st2

rt1
rt2

#requirements
# 1. functie miceParallel(data, n.imp.core = 1, n.core = detectCores() - 1, seed = NULL){}
# 2. functie returned MIDS object cf. mice()
# 3. if !is.NULL(seed){clusterSetRNGStream(cl, 9956)}
#
