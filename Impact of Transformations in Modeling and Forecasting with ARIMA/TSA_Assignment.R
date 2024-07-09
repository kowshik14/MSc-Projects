plot(AirPassengers)
title(main = "AirPassengers Time Plot")
library(tseries)
library(forecast)
tsdisplay(AirPassengers)
ggsubseriesplot(AirPassengers)
traindata=ts(AirPassengers[1:101],frequency=12,start=c(1949,1))
testdata=ts(AirPassengers[102:144],frequency=12,start=c(1957,6))
adf.test(traindata)
kpss.test(traindata)
tsdisplay(traindata)

Dtraindata=diff(traindata, lag = 1,differences = 1)
tsdisplay(Dtraindata)
adf.test(Dtraindata)
kpss.test(Dtraindata)
M1=Arima(traindata, order=c(2,1,1), seasonal = c(1,1,2))
M1#AIC=652.21   AICc=653.61   BIC=669.55
library(itsmr)
test(M1$residuals)

ctraindata=traindata^(1/3)
tsdisplay(ctraindata)
adf.test(ctraindata)
kpss.test(ctraindata)

Dctraindata=diff(traindata, lag  = 1)
tsdisplay(Dctraindata)
adf.test(Dctraindata)
kpss.test(Dctraindata)
M2=Arima(ctraindata, order=c(2,0,1), seasonal = c(0,1,2))
M2#AIC=-186.51   AICc=-185.49   BIC=-171.58

test(M2$residuals)

#box-cox transformation
ld=BoxCox.lambda(traindata)
bc_traindata=BoxCox(traindata, lambda = ld)
plot(bc_traindata)
tsdisplay(bc_traindata)
adf.test(bc_traindata)
kpss.test(bc_traindata)

d_bc_traindata=diff(bc_traindata, lag=1, differences = 1)
adf.test(d_bc_traindata)
kpss.test(d_bc_traindata)
M3=Arima(bc_traindata, order=c(0,1,0),seasonal = c(1,1,2))
M3
#AIC=-459.71   AICc=-459.29   BIC=-449.29
M4= auto.arima(traindata, approximation=F, stepwise=F)
M4#AIC=649.21   AICc=649.94   BIC=661.6
test(M4$residuals)
forecast1=forecast::forecast(M1,h=length(testdata))
fit_1=forecast1$mean
forecast2=forecast::forecast(M2,h=length(testdata))
fit_2=forecast2$mean^3
forecast3=forecast::forecast(M3,h=length(testdata))
fit_3=(ld * forecast3$mean + 1)^(1 / ld)
forecast4=forecast::forecast(M4,h=length(testdata))
fit_4=forecast4$mean

n=length(testdata)

err1=testdata-fit_1
err2=testdata-fit_2
err3=testdata-fit_3
err4=testdata-fit_4

MSE1=sum(err1^2)/n
MSE2=sum(err2^2)/n
MSE3=sum(err3^2)/n
MSE4=sum(err4^2)/n

cat("MSE1:", MSE1, ", MSE2:", MSE2, ", MSE3:", MSE3, ", MSE4:", MSE4, "\n")

RMSE1=sqrt(MSE1)
RMSE2=sqrt(MSE2)
RMSE3=sqrt(MSE3)
RMSE4=sqrt(MSE4)

cat("RMSE1:", RMSE1, ", RMSE2:", RMSE2, ", RMSE3:", RMSE3, ", RMSE4:", RMSE4, "\n")


MAE1=sum(abs(err1))/n
MAE2=sum(abs(err2))/n
MAE3=sum(abs(err3))/n
MAE4=sum(abs(err4))/n
cat("MAE1:", MAE1, ", MAE2:", MAE2, ", MAE3:", MAE3, ", MAE4:", MAE4, "\n")

PE1=(err1/testdata)*100
MPE1=sum(PE1)/n
PE2=(err2/testdata)*100
MPE2=sum(PE2)/n
PE3=(err3/testdata)*100
MPE3=sum(PE3)/n
PE4=(err4/testdata)*100
MPE4=sum(PE4)/n
cat("MPE1:", MPE1, ", MPE2:", MPE2, ", MPE3:", MPE3, ", MPE4:", MPE4, "\n")

MAPE1=sum(abs(PE1))/n
MAPE2=sum(abs(PE2))/n
MAPE3=sum(abs(PE3))/n
MAPE4=sum(abs(PE4))/n
cat("MAPE1:", MAPE1, ", MAPE2:", MAPE2, ", MAPE3:", MAPE3, ", MAPE4:", MAPE4, "\n")

fitted_values2=fitted(M2)^3
# Plot the original data, fitted values, and forecast
plot(AirPassengers, type = "l", col = "blue", lwd=2, ylim = range(c(AirPassengers, fitted_values2, fit_2)))
grid()
lines(fitted_values2, col = "red", lwd=2)
lines(fit_2, col = "green", lwd=3)
legend("topleft", legend = c("Original Data", "Fitted Values (Rescaled)", "Prediction (Rescaled)"), col = c("blue", "red", "green"), lty = 1, lwd=3)

cair=AirPassengers^(1/3)
model=Arima(cair, order=c(2,0,1), seasonal = c(0,1,2))
f=forecast::forecast(model, h=10)
fitv=fitted(model)^3
fv=f$mean^3

# Plot the original data, fitted values, and forecast
plot(AirPassengers, type = "l", col = "navyblue", lwd=2, ylim = range(c(AirPassengers, fitv, fv)),xlim=range(c(1949,1962)))
grid()
lines(fitv, col = "salmon2", lwd=2)
lines(fv, col = "seagreen4", lwd=2)
legend("topleft", legend = c("AirPassengers Data", "Fitted Values", "Forecast"), col = c("navyblue", "salmon2", "seagreen4"), lty = 1, lwd=3)
