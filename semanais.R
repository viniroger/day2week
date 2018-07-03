# Script to work with weekly data
end_libs='~/Rpacks'
suppressPackageStartupMessages(require(timeDate,lib=end_libs))
suppressPackageStartupMessages(require(zoo,lib=end_libs))

# Open daily observed data
dados_obs = read.csv('dados_obs.csv')
# Open daily forecasted data
dados_prev = read.csv('dados_prev.csv', as.is = TRUE)
# Join data
dados_reg = rbind(dados_obs,dados_prev)

# Calculate weekly totals from daily values
serie_diarios = zoo(dados_reg$value, as.Date(dados_reg$date))
nextfri <- function(x) 7 * ceiling(as.numeric(x-5+4) / 7) + as.Date(5-4)
serie_semanas = aggregate(serie_diarios, nextfri, sum)

# Split on "past" and "future" weeks
reg_pas = window(serie_semanas, end = as.Date(Sys.Date()))
reg_fut = window(serie_semanas, start = as.Date(Sys.Date()))

# Calculate week number on each week
for (date in time(serie_semanas)){
	print(format(as.Date(date), '%Y-%m-%d'))
	nweek = format(as.Date(date), '%W')
	print(nweek)
}
