# Impact of Transformations in Modeling and Forecasting with ARIMA

# Description  
In this project, time series data was analyzed using ARIMA models. The series was initially plotted using time-plots, ACF plots, and seasonal-subseries plots to describe its main features. Stationarity was achieved by applying non-seasonal and/or seasonal differences, with stationarity verified through the Augmented Dickey-Fuller Test and the KPSS Test. Models were selected based on ACF and PACF plots of the stationary series, fitted, and subjected to residual diagnostics to ensure all underlying assumptions were met. Various transformations, including square root, cube root, and logarithm, were applied alongside the Box-Cox transformation with an optimal lambda to further refine the models. The auto.arima function was utilized to compare models based on selection criteria (AIC, BIC, AICc) and forecasting accuracy measures, identifying the best model. Forecasted values were generated, and model performance was evaluated to ensure robust and accurate predictions.

## R Packages for Time Series Analysis

The following R packages were utilized for time series analysis in this project:

- **`tseries`**: For modeling and performing ADF and KPSS tests.
- **`itsmr`**: For conducting residual diagnostics tests.
- **`forecast`**: For various forecasting functions.
- **`ggplot2`**: For creating graphics and visualizations.
- **`seasonal`**: For implementing different seasonal methods.
- **`fma`**: Provides a collection of time series datasets.
- **`expsmooth`**: For applying exponential smoothing methods.
- **`fpp2`**: Loads multiple packages including `forecast`, `ggplot2`, `fma`, and `expsmooth`.
