

USbondssymbols <- paste0("DGS",c(1,2,3,5,7,10,20,30))

us_y <- tq_get(USbondssymbols,
               get = "economic.data",
               from = "2018-04-01",
               to = "2019-07-15")

us_y %>% 
  spread(key = symbol,
         value = price) -> pca_data


#可視化
pca_data %>% 
  na.exclude() %>% 
  select(-date) %>% 
  DataExplorer::plot_prcomp(
  　　variance_cap = 0.99,
    　prcomp_args = list(scale. = TRUE),  #標準化
      ncol = 2, nrow = 2
    )


#PCA
pca_data %>% 
  na.exclude() %>% 
  select(-date) %>% 
  prcomp(scale = TRUE) -> pca_res


#これを可視化
pca_res$rotation
pca_res$x


data.frame(pca_res$rotation[, 1:3]) %>% 
  mutate(Maturity = factor(rownames(.)))
    gather("PC", "FactorLodings", -Maturity)
    ggplot(aes(x = Maturity, y = FactorLodings)) + 
    geom_line(aes(colour = PC, group = PC), size = 1) 
    
data.frame(Date = ust.xts$date, irate_pc$x[, 1:3]) %>% 
  gather(PC, Factor, -Date)

