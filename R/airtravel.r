#Fitting seasonal ARIMA model to international air travel series

temp <- scan("https://edoras.sdsu.edu/~babailey/stat673/airtravel.dat")
airtrav <- ts(temp,start=1949, frequency=12)
airtrav1 <- ts(temp)

airtrav.log <- log10(airtrav)
airtrav1.log <- log10(airtrav1)

cat("\n\nInternational Airline Passengers (1949-1960):\n\n")

par(mfrow=c(3,2))
plot(airtrav, main="Thousands/month")
plot(airtrav.log, main="log10(thousands/month)")
plot(diff(airtrav,lag=12), main="diff12")
plot(diff(airtrav.log,lag=12), main="diff12")
plot(diff(diff(airtrav,lag=12)),main="diff(diff12)")
plot(diff(diff(airtrav.log,lag=12)),main="diff(diff12)")

dif1 <- diff(airtrav1.log)
dif12 <- diff(airtrav1.log,lag=12)
difdif12 <- diff(dif12)

par(mfrow=c(2,3))
acf(dif1)
acf(dif12)
acf(difdif12)
acf(dif1,type="partial")
acf(dif12,type="partial")
acf(difdif12,type="partial")

#Fit ARIMA(0,1,1) x (0,1,1)12 

par(mfrow=c(1,1))

fit1 <- arima(airtrav.log, order=c(0,1,1), seasonal=list(order=c(0,1,1)))

#Diagnostic plots

tsdiag(fit1)

print(fit1)

#Devolope ARIMA forecast of the last year based on earlier data.

travhist <- airtrav[time(airtrav) < 1960]
ts.travhist <- ts(travhist, start=1949, frequency=12)
trav1960 <- airtrav[time(airtrav) >= 1960]
fit2 <- arima(log10(ts.travhist),order=c(0,1,1), 
              seasonal=list(order=c(0,1,1)))

#forecast 1960 travel - develop the forecast on log scale, then
#transform back

pred1 <- predict(fit2, n.ahead=12)

par(mfrow=c(2,1),lwd=2)
plot(101:144,c(log10(travhist), pred1$pred)[101:144], ylim=c(2.4,2.9),
     type="n")
lines(101:132, log10(travhist)[101:132], lty=1)
lines(133:144, log10(trav1960), lty=3)
lines(133:144, pred1$pred + 2*pred1$se, lty=2)
lines(133:144, pred1$pred - 2*pred1$se, lty=2)
points(133:144, pred1$pred, pch=3)
title("Forecasts")

plot(101:144, c(travhist, 10^pred1$pred)[101:144], ylim=c(300,725), type="n")
lines(101:132, travhist[101:132], lty=1)
lines(133:144, trav1960, lty=3)
lines(133:144, 10^(pred1$pred + 2*pred1$se), lty=2)
lines(133:144, 10^(pred1$pred - 2*pred1$se), lty=2)
points(133:144, 10^(pred1$pred), pch=3)
title("Log Forecasts")



dev.off()
