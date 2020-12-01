#### Example 1: Spectrum of AR(1) ####
# Let's look at the sample code in spec1.r
# 
# Which process has a high frequency component, so that there is a lot of power concentrated at high frequencies of the spectrum?
# 
# Which process has a low frequency component, so that there is a lot of power concentrated at low frequencies of the spectrum?ocess has a low frequency component, so that there is a lot of power concentrated at low frequencies of the spectrum?

par(mfrow=c(2,2))

set.seed(1)

test1 <- arima.sim(n=100,model=list(ar=.8))
test2 <- arima.sim(n=100,model=list(ar=-.8))

plot(test1)
title("AR(1) with phi=0.8")
# moving very slowly 
# dominated by low frequency 
# ACF will have exponential decay 

plot(test2)
title("AR(1) with phi=-0.8")
# positive and negative 
# time series dominate by higher frequency

spectrum(test1,spans=c(5,5))
# higher frequency then mostly lower 
# points go back and forward more 

spectrum(test2,spans=c(5,5))
# lower frequency then mostly higher

# n is only 100, so the peak is really wide 
# need larger sample side to narrow down the peak 

#### spectrun of white noise process ####
test3 <- rnorm(100)
plot(test3)
title("White Noise")
spectrum(test3, spans = c(5, 5))
# spectrum supposed to be flat 
# but we only have 100 sample size, there fore it's noisy 

# we can use smoothing function to flatten the noise 

# Which process has a high frequency component, 
# so that there is a lot of power concentrated at high frequencies 
# of the spectrum?
## The negative phi 


# Which process has a low frequency component, 
# so that there is a lot of power concentrated at low frequencies 
# of the spectrum?ocess has a low frequency component, 
# so that there is a lot of power concentrated at low frequencies 
# of the spectrum?
## The positive phi


#### Example 2: Lynx Data ####

par(mfrow=c(3,2))

plot(lynx)
plot(log(lynx))
acf(lynx)
acf(log(lynx))
acf(lynx,type="partial")
# ACF cuts off after 2 indicating this is an AR(2) model

acf(log(lynx),type="partial")

## To estimate the spectrum for this series, 
## let's look at the sample code in
## will not be on final exam 

par(mfrow=c(3,2))

# raw periodogram 
lynx.pgram <- spec.pgram(lynx, plot=T)
llynx.pgram <- spec.pgram(log(lynx), plot=T)

# smoothed spectrum
lynx.pgram <- spec.pgram(lynx, spans=c(3,3), plot=T)
llynx.pgram <- spec.pgram(log(lynx), spans=c(3,3), plot=T)

## people interested in analyzing the signficant peaks 
## what frequency are dominated by the spectrum 

# estimated spectrum based on AR model
lynx.pgram <- spec.ar(lynx, plot=T)
llynx.pgram <- spec.ar(log(lynx), plot=T)

# What is a dB? Ans: decibels = 10 x log_10(I(omega))
# I(omega) is the periodogram 


