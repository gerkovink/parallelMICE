
run.conventional <- function(data, ms){
  
  result <- c()
  
  ms = ms 
  
  for (i in 1:length(ms)) {
    cat(i)
    result[i] <- system.time(expr = mice(data, m = ms[i], print = FALSE))[[3]]
  }
  
  return(result)
  
}

run.parallel <- function(data, ms, n.core) {
  
  result <- c()
  
  if (n.core == 2) {
    ms <- ms / 2
  } else if (n.core == 3) {
    ms <- ms / 3
  }
  
  for (i in 1:length(ms)) {
    cat(i)
    result[i] <- system.time(expr = parlMICE(data, m = ms[i], 
                                             n.core = n.core))[[3]]
  }
  
  return(result)
  
}


