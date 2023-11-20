library(TwoArmSurvSim)
f1<-list(name='Treatment', N_level=2, prevalence=c(0.5,0.5), HR=c(1,0.5), strata=TRUE)
factors<-list(f1)
cov_simu(sample_size=300,factors=factors)


f1<-list(name='RiskGroup', N_level=2, prevalence=c(0.5,0.5), HR=c(1,1.7), strata=TRUE)
#f2<-list(name='Age', N_level=4, prevalence=c(0.1,0.1,0.1,0.1), HR=c(1, 1.1, 1.2, 1.3), strata=TRUE)
factors<-list(f1)
samplesize<-600
blocksize<-2
accrual_interval<-c(0,5,10)
accrual_rate<-c(5,10,20)
trtHR<-0.5
lambda<-0.03
gamma<-1.2
dropoutrate<-0.2
eventtarget<-240
N_simulation<-1
out<-run_simulation(samplesize=samplesize,blocksize=blocksize,factors=factors,
                    accrual_interval=accrual_interval,accrual_rate=accrual_rate, trtHR=trtHR, lambda=lambda,
                    gamma=gamma,dropoutrate=dropoutrate,eventtarget=eventtarget,N_simulation=N_simulation)

data <- out$Data[,1:4]
colnames(data) <- c("Treatment", "HighRisk", "Time", "Status")
write.csv(data, "data/ovarian.csv", row.names = F)

# out$Data
# result <- analyse_multivariate(out$Data,
#                                vars(time, status),
#                                covariates = vars(trt, RiskGroup.1)) 
# forest_plot(result,
#             endpoint_labeller = c(futime="OS"),
#             orderer = ~order(HR),
#             labels_displayed = c("endpoint", "factor", "n")
# )
