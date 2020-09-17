library(tidyverse)

rnorm(100) 

#### AR(1) ####

y.50 <- arima.sim(model = list(ar = 0.5), n = 100)

plot(y.50)

plot(y.50, type = "o")

# plot ACF - autocorrelation function
acf(y.50)
## lag = rows
## blue lines are 95% CI 
## larger sample size = closer estimate of ACF 

# store values instead of plot
temp <- acf(y.50, plot = FALSE)

temp$acf

#### PACF ####

acf(y.50, type = "partial")

# You can look at plot of Z_t versus Z_t-1 for the AR(1) series

plot(lag(y.50, 1), y.50, 
     xlab = expression(Z[t-1]), 
     ylab = expression(Z[t]))


# R source code for generating data from AR(1) processes.

#set the seed so we all have the same time series
set.seed(1)


#### AR Example 1 ####

# AR(1) series with phi = 0.1 
y.10 <-  arima.sim(model=list(ar=0.1), n=100)

# AR(1) series with phi= 0.5
y.50 <- arima.sim(model=list(ar=0.5), n=100)

# AR(1) series with phi= -0.5
y.m50 <- arima.sim(model=list(ar=-0.5), n=100)

# AR(1) series with phi= 0.9
y.90 <- arima.sim(model=list(ar=.9), n=100)


# set up for a 2x2 matrix of graphs
par(mfrow=c(2,2))

plot(y.10)
title("phi=0.1, Stationary AR(1) process")
abline(h=0)

plot(y.50)
title("phi = 0.5, Stationary AR(1) process")
abline(h=0)

plot(y.m50)
title("phi = -0.5, Stationary AR(1) process")
abline(h=0)

plot(y.90)
title("phi = 0.9, Stationary AR(1) process")
abline(h=0)


#### Exmple 2 ####
# Now plot the ACF and PACF of the time series. 
# R source code for generating ACF and PACF from AR(1) processes.

# set up for a 4x2 matrix of graphs
par(mfrow=c(4,2))

acf(y.10)
acf(y.10, type="partial")

acf(y.50)
acf(y.50, type="partial")

acf(y.m50)
acf(y.m50, type="partial")

acf(y.90)
acf(y.90, type="partial")


#### Example 3 - The Random Walk #### 

# generate the random walk
# generate the noise (innovations)
set.seed(6)

# standard normal parameters
mu=0.0
sd=1

#generate n, N(0,1) RVs
n=100
e=rnorm(n=n,mean=mu,sd=sd)

# make plot region 2 x 2
par(mfrow=c(2,2))

# time plot of the innovations
plot(e, type="l")
abline(h=0,col='blue')
plot(e,type='b')
abline(h=0,col='blue')
plot(e,type='o')
abline(h=0,col='blue')

# generate random walk: Y_t = Y_t-1 + e_t
y=cumsum(e)
plot(y,type='o', xlab="Time", ylab="Y_t")
abline(h=0,col='blue')
title("Random Walk")


set.seed(27)

# AR(2)
y <- arima.sim(model = list(ar = c(0.05, 0.23)), n = 100)

names(y)






