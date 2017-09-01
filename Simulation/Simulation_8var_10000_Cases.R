sigma <- matrix(data = c(1, .5, .5, .5, .5, .5, .5, .5, 
                         .5, 1, .5, .5, .5, .5, .5, .5,
                         .5, .5, 1, .5, .5, .5, .5, .5,
                         .5, .5, .5, 1, .5, .5, .5, .5, 
                         .5, .5, .5, .5, 1, .5, .5, .5, 
                         .5, .5, .5, .5, .5, 1, .5, .5, 
                         .5, .5, .5, .5, .5, .5, 1, .5, 
                         .5, .5, .5, .5, .5, .5, .5, 1), nrow = 8)
data <- mvrnorm(n = 10000, 
                mu = rep(0, 8),
                Sigma = sigma)

amp <- ampute(data, prop = 0.8)$amp 
# At the time of running these simulations, 
# the defaults in ampute resulted in MCAR missingness. The new defaults of ampute 
# generate MARRIGHT missingness

result1 <- run.conventional(amp, ms = ms)
cat("conv")
result2 <- run.parallel(amp, ms = ms, n.core = 1)
cat("par1")
result3 <- run.parallel(amp, ms = ms, n.core = 2)
cat("par2")
result4 <- run.parallel(amp, ms = ms, n.core = 3)
cat("par3")

out_8_10000 <- cbind(result1, result2, result3, result4)
write.table(out_8_10000, "Simulation/sim8_10000.csv", sep = ',')