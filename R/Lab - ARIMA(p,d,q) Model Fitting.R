#### Example 2: Model Identification and Fitting ####
# Example for model identification and forecasting 
# Generate some training data.
set.seed(1)
series1 <- arima.sim(model=list(order=c(2,1,2), ar=c(.4, .2), ma=c(.3,.1)), n=500)

# Graph the data..
par(mfrow=c(3,2))

# not stationary 
plot(series1)
title("ARIMA(2,1,2)")

# stationary
plot(diff(series1))
title("Differenced")

# acf has characteristic of non stationary model 
acf(series1)
acf(diff(series1))
acf(series1, type="partial")
acf(diff(series1), type="partial")

# fit ARIMA model 
fit <- arima(series1, order=c(2,1,2))
fit
## phi is on the first line 
## we should have 2 phi and 2 theta for ARIMA(2,1,2) model
## second row is standard deviation 
## log likelilhood and AIC provided 

## Diagnostic 
tsdiag(fit)
# 1: standardized residuals 
# we like to see them to have no uniform and spread out
# should have no pattern with mean 0 and sd = 1
# 2: residuals: one peak (ACF) looks like white noise
# ACF coef should fall within the 95% CI for the theoretical 
# AUC ceief of white noise are all equal to 0 for k >0
# the blue lines are at +/-1.96*sqrt(1/n)
# 3: correlation, p values, we want small p values usually 
# however, this case, we want to see high correlation 
# so high p-values mean high correlation 
# stated maximum numver of lags 
# test weither AUC coef as a group are significantly different than 0.
# we look for large p-values 

##
names(fit) 
class(fit)

## QQ Plot 
## how to make a QQ plot of residuals? 
par(mfrow=c(1,1))
qqnorm(fit$residuals, pch = 1, frame = FALSE)
qqline(fit$residuals, col = "red", lwd = 2)

library("car")
qqPlot(fit$residuals)

