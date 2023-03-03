libraryData <- read.csv("/Users/isaackeen/Documents/Data/2017-2023-10-Checkouts-SPL-Data.csv")
invisible(library("ggplot2"))
invisible(library("dplyr"))
invisible(library("tidyr"))
invisible(library("scales"))

horizon_data <- libraryData %>%
  filter(CheckoutType == "Horizon" & MaterialType != "MAGAZINE") # exclude MAGAZINE as it doesn't have a timeline column

overdrive_data <- libraryData %>%
  filter(CheckoutType == "OverDrive" & MaterialType != "MAGAZINE") # exclude MAGAZINE as it doesn't have a timeline column

horizon_data$timeline <- as.Date(paste0(horizon_data$CheckoutYear, "-", horizon_data$CheckoutMonth, "-01"))
overdrive_data$timeline <- as.Date(paste0(overdrive_data$CheckoutYear, "-", overdrive_data$CheckoutMonth, "-01"))

horizon_checkouts_over_time <- horizon_data %>%
  group_by(timeline) %>%
  summarise(total_checkout = sum(Checkouts))

overdrive_checkouts_over_time <- overdrive_data %>%
  group_by(timeline) %>%
  summarise(total_checkout = sum(Checkouts))

library_checkout_line_chart2 <- ggplot() +
  geom_line(data = horizon_checkouts_over_time, aes(x = timeline, y = total_checkout, color = "Horizon")) +
  geom_line(data = overdrive_checkouts_over_time, aes(x = timeline, y = total_checkout, color = "OverDrive")) +
  labs(
    title = "Checkouts Using Horizon vs OverDrive Over Time",
    subtitle = "Source: 2017-2023-10-Checkouts-SPL-Data.csv",
    caption = "Data starts in year of 2017 and goes until 2023",
    x = "Year",
    y = "Total Checkouts(By 100,000)"
  ) +
  scale_x_date(date_breaks = "1 year", date_labels = "%y") +
  scale_y_continuous(labels = function(x) format(x/100000, big.mark = ",", scientific = FALSE)) +
  scale_color_manual(name = "Checkout Type", values = c("red", "blue"))

library_checkout_line_chart2

