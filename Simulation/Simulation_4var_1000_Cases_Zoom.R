
sigma <- matrix(data = c(1, .5, .5, .5, 
                         .5, 1, .5, .5, 
                         .5, .5, 1, .5,
                         .5, .5, .5, 1), nrow = 4)
data <- mvrnorm(n = 1000, 
                mu = rep(0, 4),
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

out_4_1000_zoom <- cbind(result1, result2, result3, result4)
write.table(out_4_1000_zoom, "Simulation/sim4_1000_zoom.csv", sep = ',')

