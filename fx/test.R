library(tidyquant)
library(prophet)




# import ------------------------------------------------------------------


files <- list.files("data/",full.names = TRUE)


df <- read_delim(files[2],delim = ";",col_names = FALSE,skip=1)


df %>% 
  mutate(X1 = as.character(X1)) %>% 
  unite(X1,X2,col="datetime",sep="",remove = TRUE) %>% 
  mutate(time = ymd_hms(datetime)) %>% 
  select(ds = time,y = X3)->res

res %>% print()


# predict -----------------------------------------------------------------


#prophetオブジェクトの作成
m <- prophet(res)

#未来をどれくらいまで予測するのか
future <- make_future_dataframe(m, freq = 60,periods = 100)

#モデルへのfit
forecast <- predict(m, future)



#図示はかんたん
plot(m, forecast)
prophet_plot_components(m, forecast)
dyplot.prophet(m, forecast)
