libraryData <- read.csv("/Users/isaackeen/Documents/Data/2017-2023-10-Checkouts-SPL-Data.csv")
invisible(library("ggplot2"))
invisible(library("dplyr"))
invisible(library("tidyr"))
invisible(library("scales"))


ebook_data <- libraryData %>%
  filter(UsageClass == "Digital" & MaterialType == "EBOOK")


physical_data <- libraryData %>%
  filter(UsageClass == "Physical" & MaterialType == "BOOK")


ebook_data$timeline <- as.Date(paste0(ebook_data$CheckoutYear, "-", ebook_data$CheckoutMonth, "-01"))
physical_data$timeline <- as.Date(paste0(physical_data$CheckoutYear, "-", physical_data$CheckoutMonth, "-01"))


ebook_checkouts_over_time <- ebook_data %>%
  group_by(timeline) %>%
  summarise(total_checkout = sum(Checkouts))

physical_checkouts_over_time <- physical_data %>%
  group_by(timeline) %>%
  summarise(total_checkout = sum(Checkouts))


library_checkout_line_chart <- ggplot() +
  geom_line(data = ebook_checkouts_over_time, aes(x = timeline, y = total_checkout, color = "Ebooks")) +
  geom_line(data = physical_checkouts_over_time, aes(x = timeline, y = total_checkout, color = "Physical Books")) +
  labs(
    title = "Books vs Ebooks Checkouts Over Time",
    subtitle = "Source: 2017-2023-10-Checkouts-SPL-Data.csv",
    caption = "Data starts in year of 2017 and goes until 2023",
    x = "Year",
    y = "Total Checkouts(By 100,000)"
  ) +
  scale_x_date(date_breaks = "1 year", date_labels = "%y") +
  scale_y_continuous(labels = function(x) format(x/100000, big.mark = ",", scientific = FALSE))
  scale_color_manual(name = "Material Type", values = c("red", "blue"))
  
library_checkout_line_chart
