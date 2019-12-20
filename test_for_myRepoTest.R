# This is a simple change in the document to coinfirm sync with "GitHub"


library(dplyr)
library(readxl)
Ca_moving <- read_excel("E:/Dataset_main/Housing 2019/Ca_moving.xls")
View(Ca_moving)

ca_outflow <- Ca_moving %>%
 filter(as.numeric(...2) <57) %>%
 select(-c(`CALIFORNIA OUTFLOW`,'...2') )

colnames(ca_outflow) <- c("abb","state","returns","exemptions","AGI")
ca_outflow <- arrange(ca_outflow,state)
ca_outflow$state <- tolower(ca_outflow$state)


ca_outflow$returns <- as.numeric(ca_outflow$returns)
ca_outflow$AGI <- as.numeric(ca_outflow$AGI)  

#---------------------------
library(choroplethr)
data("df_pop_state")
library(knitr)
library(kableExtra)
df_pop_state$value <- ca_outflow$returns
state_choropleth(df_pop_state, 
                 title = "California Outflow by IRS filing",
                 legend = "Number of tax filers",
                 num_colors = 9)

top_ten <- top_n(ca_outflow,10,returns) %>%
           arrange(-returns)
top_ten[,2:3] %>%
  kable() %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  column_spec(1, bold = T, border_right = T) %>%
  row_spec(1, bold = T, color = "white", background = "blue")
