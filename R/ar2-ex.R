#Let's examine the sample size and noise in an AR(2) ACF

set.seed(1)
ar2_sim1 <- arima.sim(model=list(ar=c(1.3, -0.4)), n=100)

set.seed(2)
ar2_sim2 <- arima.sim(model=list(ar=c(1.3, -0.4)), n=1000)

acf(ar2_sim1, plot=F)
acf(ar2_sim2, plot=F)

ARMAacf(ar=c(1.3, -0.4), lag.max = 20, pacf = FALSE)

#What do you notice about the accuracy of the estimates compared to the 
#theoretical ACF? 

#Let's add more noise!

set.seed(1)
ar2_sim1b <- arima.sim(model=list(ar=c(1.3, -0.4)), n=100, sd=2)
set.seed(2)
ar2_sim2b <- arima.sim(model=list(ar=c(1.3, -0.4)), n=1000, sd=2)
acf(ar2_sim1b, plot=F)
acf(ar2_sim2b, plot=F)

#What happened? 