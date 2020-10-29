#### Example 1: Monthly Sunspot Data, AR(p) ####

par(mfrow=c(2,2))

plot(sunspot.month)

acf(sunspot.month)

acf(sunspot.month, type="partial")

# AR modeling with order selection.
sunfit1 <- ar(sunspot.month)

sunfit1

# As far as I can tell, there are no model diagnostics for ar. What should you look at?
# Fit a model with the arima Call the fit sunfit2 For model diagnostics for arima function try:
sunfit2 <- arima(sunspot.month, order = c(6, 0, 0))
sunfit2
## 6 coefficent 

## diagnostic plots 
tsdiag(sunfit2)
# 1) standardized residual: we should we no pattern here 
# there is chunk of residuals sometimes 
# there is definately some pattern 
# sometimes there is little residuals and 
# sometimes there is larger residuals 

# 2) ACF plots: there are still spikes our after lag 1 

# 3) p values: high p values mostly, 
# however there are low p values at lag 9 and 10

## now try to fit an ar 29 
sunfit3 <- arima(sunspot.month, order = c(29, 0, 0))
sunfit3

tsdiag(sunfit3)
# 1) standard residual: still see pattern in error. error should be iid
# 2) ACF: acf cut off after 1 
# 3) pvalues: correlation are all higher 

## QQ plot of residuals 
par(mfrow = c(1,1))
qqnorm(sunfit3$residuals)
qqline(sunfit3$residuals, col = "red")
# residual is not normal 

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

## OR 
car::qqPlot(fit$residuals)

## fit models ar - fits with y-w (mon), AIC for model selection 
## arima - fit with MLE; return AIC and summary 
## tsdiag will give diagnostic plots 
## qqnorm will give us qq plot to check for normality 


#### Example color dataset ####

library(TSA)
data(color)

par(mfrow=c(2,2))
plot(color)
# reasonably stationary  
# there is going up and down trend but we have less points 

plot(diff(color))
acf(color)
# damp since wave pattern 

acf(color, type = "partial")
# pacf cutoff after 1 

ar(color)
# one coeficient is good 

color.fit1 <- arima(color, order = c(1,0,0)) 

tsdiag(color.fit1)
# residual looks randome 
# ACF drop off after 0 
# high correlation with high p values 

qqnorm(color.fit1$residuals, pch = 1, frame = FALSE)
qqline(color.fit1$residuals, col = "red", lwd = 2)
# normality doens't look too bad 
# a little bit off but not that bad 


#### Example oil ####

#Read in data
oil.price <- read.table("https://edoras.sdsu.edu/~babailey/stat673/oil.price.dat", header=TRUE)

oil <- ts(oil.price)

par(mfrow=c(2,2))
plot(oil, main="Oil")

plot(log(oil), main="Log Oil")

plot(diff(oil), main="Diff Oil")

plot(diff(log(oil)), main="Diff Log Oil")

# diff log oil looks the most stationary 

par(mfrow=c(3,2))
acf(oil,main='Sample ACF of the Oil Price TS')
acf(log(oil), main="ACF of log Oil")

acf(diff(oil), main="ACF of Diff Oil")
acf(diff(log(oil)), main="ACF of Diff Log Oil") 

pacf(diff(oil), main="PACF of Diff Oil")
pacf(diff(log(oil)), main="PACF of Diff Log Oil") 

#Models: ARIMA(2,1,0) or ARIMA(0,1,1)
# d = 1 when taking diff one time

oil.fit1 <- arima(log(oil), order = c(2,1,0)) 
oil.fit1
tsdiag(oil.fit1)
qqnorm(oil.fit1$residuals, pch = 1, frame = FALSE)
qqline(oil.fit1$residuals, col = "red", lwd = 2)


oil.fit2 <- arima(log(oil), order = c(0,1,1)) 
oil.fit2
tsdiag(oil.fit2)

# pick the smaller AIC if the models are too similar 
# -518 is smaller than -517 

