library(TwoArmSurvSim)

# Define the risk factors
f1 <- list(name='Treatment', N_level=2, prevalence=c(0.5, 0.5), HR=c(1, 0.5), strata=TRUE)
f2 <- list(name='Lichen_ruber', N_level=2, prevalence=c(0.7, 0.3), HR=c(1, 1.7), strata=TRUE)
f3 <- list(name='VIN', N_level=2, prevalence=c(0.7, 0.3), HR=c(1, 1.7), strata=TRUE)
f4 <- list(name='MorbusPaget', N_level=2, prevalence=c(0.7, 0.3), HR=c(1, 1.5), strata=TRUE)
f5 <- list(name='HPV16_18', N_level=2, prevalence=c(0.3, 0.7), HR=c(1, 1.5), strata=TRUE)
f6 <- list(name='Smoking', N_level=2, prevalence=c(0.7, 0.3), HR=c(1, 1.7), strata=TRUE)
f7 <- list(name='Obesity', N_level=2, prevalence=c(0.6, 0.4), HR=c(1, 1.7), strata=TRUE)
f8 <- list(name='More_than_3_Sexual_Partners', N_level=2, prevalence=c(0.6, 0.4), HR=c(1, 1.5), strata=TRUE)
f9 <- list(name='Lymphovascular_Invasion', N_level=2, prevalence=c(0.4, 0.6), HR=c(1, 1.5), strata=TRUE)
f10 <- list(name='Perineural_Invasion', N_level=2, prevalence=c(0.4, 0.6), HR=c(1, 1.7), strata=TRUE)
f11 <- list(name='HPV_Vaccination', N_level=2, prevalence=c(0.4, 0.6), HR=c(1, 0.5), strata=TRUE)

# Combine the risk factors into a list
factors <- list(f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)

# Set simulation parameters
samplesize <- 150
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
data <- out$Data[,2:14]
colnames(data) <- c("Treatment", "Lichen_ruber", "VIN", "MorbusPaget", "HPV16_18", "Smoking", "Obesity", "More_than_3_Sexual_Partners", "Lymphovascular_Invasion", "Perineural_Invasion", "HPV_Vaccination", "Time", "Status")

# Save the data to a CSV file
write.csv(data, "vulvarcancer.csv", row.names = FALSE)