help(predict.Arima)


#### Example 1: Forecasting ####
# Simulate, fit, and forecast ARIMA(2,1,2)

# Example for model identification and forecasting #
# Generate some training data from ARIMA(2,1,2)
set.seed(1)
series2 <- arima.sim(model=list(order=c(2,1,2), ar=c(.4, .2), ma=c(.3,.1)), n=100)
series1 <- ts(series2[1:90])

# Graph the data.
par(mfrow=c(3,2))
plot(series1)
title("ARIMA(2,1,2)")
plot(diff(series1))
title("Differenced")
acf(series1)
acf(diff(series1))
acf(series1, type="partial")
acf(diff(series1), type="partial")

# fit ARIMA model to first 90 observations
fit <- arima(series1, order=c(2,1,2))

# check for the quality of the model 
tsdiag(fit)
qqnorm(fit$residuals)
qqline(fit$residuals, col = "red")

# and compute forecasts for last 10.
pred <- predict(fit, n.ahead=10)
pred

# graph them.
par(mfrow=c(1,1))
plot(c(series1,pred$pred), ylim=c(-3,50), type="n")
lines(1:90,series1, lty=1)
lines(91:100, pred$pred + 2*pred$se, lty=2)
lines(91:100, pred$pred - 2*pred$se, lty=2)
points(91:100, pred$pred, pch=3)
points(91:100, series2[91:100], pch=1) #This is the data that was "held out"
title("95% Forecast intervals")

legend("topleft", c("Forecases", "Data HO"), pch = c(3,1))


#### Example 2: Forecasting with Transformations ####

#Fitting ARIMA Models to Wolfer sunspot numbers, 1770-1869

wolfer <- scan("https://edoras.sdsu.edu/~babailey/stat673/sun_spot.txt", skip=1)

wolfer <- ts(wolfer, start=1770)
sqrtwolfer <- ts(sqrt(wolfer), start=1770)

# Graph the data.
par(mfrow=c(3,2))
plot(wolfer)
title("Wolfer Sunspot Numbers")
plot(sqrtwolfer)
# smaller y axis and more stationary 

title("Square Root Transform")
acf(wolfer)
acf(sqrtwolfer)
## The ACF is damped since wave == AR

acf(wolfer, type="partial")
acf(sqrtwolfer, type="partial")
## The PACF cut off after 2 


## we can use ARIMA(2,0,0) for this transformation model

#Fit AR(2) 

fit1 <- arima(sqrtwolfer, order=c(2,0,0))
fit2 <- arima(wolfer, order=c(2,0,0))

# diagnostics plots of the 2 fits 
tsdiag(fit1)
## no pattern in residuals 
## ACF loooks good 
## p values are higher than fit2

tsdiag(fit2)
## there is pattern in standardized residuals 
## ACF looks good same as white noise 
## p value is lower than transformation fit1 

# forecast 
pred <- predict(fit1,n.ahead=20)
pred

# graph the forecasts 
## however we don't want to plot the trasnformation plot 
## so we need to do back transformation by square it  
par(mfrow=c(1,1))
plot(c(wolfer,(pred$pred)^2), ylim=c(0,180), type="n")
lines(1:100, wolfer, lty=1)
lines(101:120, (pred$pred + 2*pred$se)^2, lty=2)
lines(101:120, (pred$pred - 2*pred$se)^2, lty=2)
points(101:120, (pred$pred)^2, pch=3)
title("95% Forecast intervals")

#### Example 3: Forecasting ####

#Fitting ARIMA Models to US Savings Rate 1955-1980 (as % of disposable income)

sr <- scan("https://edoras.sdsu.edu/~babailey/stat673/savings_rate.txt", skip=1)

sr <- ts(sr, start=1955)

# Graph the data.
par(mfrow=c(3,2))
plot(sr)
title("US Saving Rate Data")
plot(diff(sr))
title("Differenced")
acf(sr)
acf(diff(sr))
acf(sr, type="partial")
acf(diff(sr), type="partial")

#Fit Some models

fit1 <- arima(sr, order=c(1,0,2))
fit2 <- arima(sr, order=c(0,1,1))
fit3 <- arima(sr, order=c(0,1,2))

# diagnostic 
tsdiag(fit1)
tsdiag(fit2)
tsdiag(fit3)

# forecast 
pred <- predict(fit1,n.ahead=16)

# graph the forecasts 
par(mfrow=c(1,1))
plot(c(sr,pred$pred), ylim=c(0,10), type="n")
lines(1:104, sr, lty=1)
lines(105:120, pred$pred + 2*pred$se, lty=2)
lines(105:120, pred$pred - 2*pred$se, lty=2)
points(105:120, pred$pred, pch=3)
title("95% Forecast intervals")














