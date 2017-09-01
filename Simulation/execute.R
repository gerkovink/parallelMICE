
require(mice)
require(MASS)

source("GitHub/parlMICE/parlMICE.R")
source("GitHub/parlMICE/Simulation/SimulationFunctions.R")

ms <- seq(6, 600, 6) * 3 
source("GitHub/parlMICE/Simulation/simulation_4var_1000_Cases.R")

ms <- seq(6, 120, 6)
source("GitHub/parlMICE/Simulation/simulation_4var_1000_Cases_Zoom.R")
source("GitHub/parlMICE/Simulation/simulation_8var_10000_Cases.R")

ms <- seq(6, 24, 6)
source("GitHub/parlMICE/Simulation/simulation_8var_10000_Cases_Zoom.R")

