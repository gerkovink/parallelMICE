
require(ggplot2)
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

data <- as.data.frame(result)
data[40 : 50, "V2"] <- data[40 : 50, "V2"] * 60
data["n.imp"] <- steps * 3
data
plot <- ggplot(data = data) + 
  geom_line(aes(x = n.imp, y = V1, color = "V1")) + 
  geom_line(aes(x = n.imp, y = V2, color = "V2")) + 
  xlab("Number of imputations") + 
  ylab("Time") + 
  scale_colour_manual("Type", values = c("red", "blue"), 
                      labels = c("Parallel","Conventional"))
plot
