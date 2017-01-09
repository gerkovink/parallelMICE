require(gridExtra)
require(ggplot2)

test1 <- read.csv("Simulation/sim4_1000.csv")
test1["n.imp"] <- seq(6, 600, 6) * 3 
plot1 <- ggplot(data = test1) + 
  geom_line(aes(x = n.imp, y = result1, color = "result1")) + 
  geom_line(aes(x = n.imp, y = result2, color = "result2")) + 
  geom_line(data = test1[1:50, ], aes(x = n.imp * 2, y = result3, color = "result3")) +
  geom_line(data = test1[1:34, ],aes(x = n.imp * 3, y = result4, color = "result4")) +
  xlab("Number of imputations") + 
  ylab("") + 
  ggtitle("Time comparison with small dataset") +
  scale_colour_manual("Type", values = c("#009E73", "#D55E00", "#0072B2", "#CC79A7"), 
                      labels = c("Conv.", "1 Core", "2 Cores", "3 Cores"))
plot1

test2 <- read.csv("Simulation/sim4_1000_2.csv")
test2["n.imp"] <- seq(6, 120, 6)
plot2 <- ggplot(data = test2) + 
  geom_line(aes(x = n.imp, y = result1), color = "#009E73") + 
  geom_line(aes(x = n.imp, y = result2), color = "#D55E00") + 
  geom_line(aes(x = n.imp, y = result3), color = "#0072B2") +
  geom_line(aes(x = n.imp, y = result4), color = "#CC79A7") +
  xlab("Number of imputations") + 
  ylab("Time in seconds") + 
  ggtitle("Time comparison with small dataset") 
plot2

list1 <- list(plot2, plot1)
postscript("Simulation/Figure1.pdf", width = 16, height=5)
do.call(grid.arrange, c(list1, list(nrow = 1, ncol = 2)))
dev.off()

test3 <- read.csv("Simulation/sim8_10000.csv")
test3["n.imp"] <- seq(6, 120, 6)
plot3 <- ggplot(data = test3) + 
  geom_line(aes(x = n.imp, y = result1, color = "result1")) + 
  geom_line(aes(x = n.imp, y = result2, color = "result2")) + 
  geom_line(aes(x = n.imp, y = result3, color = "result3")) +
  geom_line(aes(x = n.imp, y = result4, color = "result4")) +
  xlab("Number of imputations") + 
  ylab("") + 
  ggtitle("Time comparison with large dataset") +
  scale_colour_manual("Type", values = c("#009E73", "#D55E00", "#0072B2", "#CC79A7"), 
                      labels = c("Conv.", "1 Core", "2 Cores", "3 Cores"))
plot3

test4 <- read.csv("Simulation/sim8_10000_2.csv")
test4["n.imp"] <- seq(6, 24, 6)
plot4 <- ggplot(data = test4) + 
  geom_line(aes(x = n.imp, y = result1), color = "#009E73") + 
  geom_line(aes(x = n.imp, y = result2), color = "#D55E00") + 
  geom_line(aes(x = n.imp, y = result3), color = "#0072B2") +
  geom_line(aes(x = n.imp, y = result4), color = "#CC79A7") +
  xlab("Number of imputations") +
  ylab("Time in seconds") + 
  ggtitle("Time comparison with large dataset")
plot4

list2 <- list(plot4, plot3)
postscript("Simulation/Figure2.pdf", width = 16, height=5)
do.call(grid.arrange, c(list2, list(nrow = 1, ncol = 2)))
dev.off()
