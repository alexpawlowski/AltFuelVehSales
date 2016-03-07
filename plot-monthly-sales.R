# import data ----
rawsales <- read.csv("https://docs.google.com/spreadsheets/d/1Wxicai_6bYeCIx8q1o6uHgSu9uwZB-21bBSgsAhBWyc/pub?output=csv")


# prepare data for plotting ----
library(ggplot2)
library(reshape2)
sales <- melt(rawsales, id.vars = "Date")
sales <- sales[!is.na(sales[,"value"]),]

sales_values <- as.numeric(sales[,"value"])
sales[,"value"] <- sales_values

sales_dates <- sales[,"Date"]
sales_dates <- as.character.Date(sales_dates)
sales_dates <- as.Date(sales_dates, format = "%m/%d/%Y")
sales[,"Date"] <- sales_dates
# prepare plot ----
salesplot <- ggplot(data = sales, aes(x = Date, y = value, color = variable)) +
  geom_point(size = 4, alpha = 0.85) +
  geom_line(size = 2, alpha = 0.35) +
  scale_color_brewer(palette = "Paired") +
  ggtitle("Alternative Vehicle Sales")+
  scale_x_date(name = "Date", date_breaks = "1 year", date_minor_breaks = "4 months", date_labels = "%b %y") +
  scale_y_continuous(name = "Sales %", labels = scales::percent, limits = c(0,0.06), minor_breaks = 0.01) +
  # discrete: lims(x = c(0,2) , y = c(0,300)) +
  guides(color = guide_legend(title = "Vehicle Type", nrow = 1)) +
  theme(
    axis.text.y = element_text(color="#58595B", size = 20, vjust = 0.5),
    axis.text.x = element_text(color="#58595B", size = 20, vjust = 0.5),
    axis.title.y = element_text(color="#58595B", face = "bold", size = 20, vjust = 0.5, angle = 90),
    axis.title.x = element_text(color="#58595B", face = "bold", size = 20, vjust = 0.5),
    axis.ticks.y = element_line(color="#58595B", size = 2),
    plot.title = element_text(color="#58595B", face = "bold", size = 20, hjust = 0.5, vjust = 0),
    panel.background = element_blank(),
    #panel.border = element_rect(color="#58595B"),#element_blank(),
    panel.grid.major.x = element_line(color = "#A7A9AC", size = 0.5),
    panel.grid.major.y = element_line(color = "#A7A9AC", size = 0.5),
    legend.position = "top",
    legend.title = element_text(color="#58595B", size = 16),
    legend.text = element_text(color="#58595B", size = 16)
  )
salesplot
# save plot ----