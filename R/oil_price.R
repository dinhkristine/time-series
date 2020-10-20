oil <- read.table("Data/oil.price.dat.txt", header = TRUE)

plot(oil$oil.price, type = "l")

plot(log(oil$oil.price), type = "l")

plot(diff(oil$oil.price), type = "l")

plot(diff(log(oil$oil.price)), type = "l")



acf(diff(oil$oil.price))

acf(diff(oil$oil.price),type="partial")


hist((oil$oil.price)^2)

## fit an ARIMA(2,1,0) or ARIMA(0,1,1)
