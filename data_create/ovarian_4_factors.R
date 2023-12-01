library(TwoArmSurvSim)

# Define the risk factors
f1 <- list(name='Treatment', N_level=2, prevalence=c(0.5, 0.5), HR=c(1, 0.5), strata=TRUE)
f2 <- list(name='RiskGroup', N_level=2, prevalence=c(0.5, 0.5), HR=c(1, 1.7), strata=TRUE)
f3 <- list(name='p53Status', N_level=2, prevalence=c(0.8, 0.2), HR=c(1, 1.7), strata=TRUE)
f4 <- list(name='BRCAStatus', N_level=2, prevalence=c(0.7, 0.3), HR=c(1, 1.5), strata=TRUE)

# Combine the risk factors into a list
factors <- list(f1, f2, f3, f4)

# Set simulation parameters
samplesize <- 600
blocksize <- 2
accrual_interval <- c(0, 5, 10)
accrual_rate <- c(5, 10, 20)
trtHR <- 0.5
lambda <- 0.03
gamma <- 1.2
dropoutrate <- 0.2
eventtarget <- 240
N_simulation <- 1

# Run the simulation
out <- run_simulation(samplesize=samplesize, blocksize=blocksize, factors=factors,
                      accrual_interval=accrual_interval, accrual_rate=accrual_rate,
                      trtHR=trtHR, lambda=lambda, gamma=gamma,
                      dropoutrate=dropoutrate, eventtarget=eventtarget,
                      N_simulation=N_simulation)

# Extract the relevant columns from the simulated data
data <- out$Data[,1:6]
colnames(data) <- c("Treatment", "RiskGroup", "p53Status", "BRCAStatus", "Status", "Time")

# Save the data to a CSV file
write.csv(data, "ovarian_4_factors.csv", row.names = FALSE)