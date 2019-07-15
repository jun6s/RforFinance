library(tidyverse)
library(tidyquant)
library(corrr)
library(rvest)


#rvest
url <- "http://www.matsui.co.jp/service/stock/trade/rule_topix100/"
html <- read_html(url, encoding = "UTF-8")

stock_name_df <- html %>% 
  html_node("table.m-tbl") %>%
  html_table

stock_code <- stock_name_df %>%
  select(`銘柄コード`)




#使用例テスト
TOPIX100 <- stock_code %>%
  unlist() %>%
  as.character() %>% 
  paste0("YJ", ., ".T") %>% 
  tq_get(get = "stock.prices.japan",
         from = "2019-04-01",
         to = "2019-06-30")

TOPIX100 %>% 
  filter(grepl("^YJ7", symbol)) %>%  #7ではじまるやつだけ！
  ggplot(aes(x = date, y = close, colour = symbol)) +
    geom_line() + 
    theme_tq() +
    scale_color_tq() +
    facet_wrap(~ symbol, ncol = 3, scales = "free_y")





# data取得 ------------------------------------------------------------------

#data取得元
tq_get_options()

#data fetch
  tq_get(c("DGS2","DGS10"),
         get = "economic.data",
         from = "2017-01-01",
         to = "2017-03-31")



#bloomberg
my_bloomberg_data <- c('SPX Index','ODMAX Equity') %>%
    tq_get(get         = "Rblpapi",
           rblpapi_fun = "bdh",
           fields      = c("PX_LAST"),
           options     = c("periodicitySelection" = "WEEKLY"),
           from        = "2016-01-01",
           to          = "2016-12-31")


eur_usd <- tq_get("EUR/USD", 
                  get = "exchange.rates", 
                  from = Sys.Date() - lubridate::days(10))




# リターンの計算 -----------------------------------------------------------------

#→債券はどうする？

#日次対数収益率
log_returns <- TOPIX100 %>% 
  group_by(symbol) %>%
  tq_mutate(
    select = close, 
    mutate_fun = periodReturn,
    period = "daily",
    type = "log",
    col_rename = "log_return"
  )

#対数リターン可視化
log_returns %>% 
  filter(grepl("^YJ7", symbol)) %>%
  ggplot(aes(x = date, y = log_return, colour = symbol)) +
    geom_line() +
    theme_tq() +
    scale_color_tq() +
    facet_wrap(~ symbol, ncol = 3, scales = "free_y")

log_returns %>% 
  filter(grepl("^YJ7", symbol)) %>%
  ggplot(aes(x = log_return, fill = symbol)) +
    geom_histogram(binwidth = 0.005) +
    theme_tq() +
    scale_color_tq() +
    facet_wrap(~ symbol, ncol = 3, scales = "free_y")


#リターンとボラの計算
return_vol <- log_returns %>%
   group_by(symbol) %>%
   summarise(return = mean(log_return), vol = sd(log_return))

return_vol

tq_transmute_fun_options()




# ポートフォリオのリターンとリスク----------------------------------------------------------


#銘柄とウェイトを決定
stocks <- c("YJ3382.T", "YJ4755.T", "YJ6954.T", "YJ7974.T", "YJ9983.T", "YJ9984.T")
weights <- c(rep(0.15, 4), rep(0.2, 1))

log_returns %>% 
   filter(symbol %in% stocks) %>% 
   tq_portfolio(assets_col = symbol,
                returns_col = log_return,
                weights = weights) 

