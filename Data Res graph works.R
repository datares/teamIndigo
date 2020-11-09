library(tidyverse)
library(scales)
library(plotly)
library(lubridate)


# explore into data 1
data1 <- read_csv("California_Fire_Incidents.csv")
view(data1)
dim(data1)

#extract month of each fire and plot data
data1$month <- month(data1$Started)

# GRAPH 1
ggplot(data1, aes(x = month, fill = "red")) + geom_bar() + 
  scale_x_discrete(limits = 1:12, labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) + 
  theme_bw() + theme(legend.position = "none", plot.title = element_text(hjust = 0.5)) +
  ggtitle("Spread of Fires over months")

#counties with most amount of fires 

data1 %>% group_by(Counties) %>% summarise(n = n()) %>% arrange(desc(n))

counties <- c("Riverside", "San Diego", "Butte", "San Luis Obispo", "Shasta")
number <- c(146, 89, 66, 64, 64)
new <- data.frame(counties = counties, number = number)

# GRAPH 2
new %>% mutate(counties = fct_reorder(counties, desc(number))) %>% ggplot(aes(x = counties, y = number, fill = counties)) + geom_bar(stat = "identity") + ggtitle("Counties with Most Fires") +
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))

