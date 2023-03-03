libraryData <- read.csv("/Users/isaackeen/Documents/Data/2017-2023-10-Checkouts-SPL-Data.csv")
invisible(library("ggplot2"))
invisible(library("dplyr"))


libraryData <- libraryData %>%
  filter(UsageClass == "Physical" & MaterialType == "BOOK")


libraryData$Genre <- if_else(grepl("Fiction", libraryData$Subjects), "Fiction", "All Other Genres", missing = NA_character_)


checkouts_by_genre <- libraryData %>%
  group_by(CheckoutYear, Genre) %>%
  summarise(total_checkouts = sum(Checkouts))


library_checkout_bar_chart <- ggplot(data = checkouts_by_genre, aes(x = CheckoutYear, y = total_checkouts, fill = Genre)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7) +
  labs(
    title = "Fiction vs Other Genre Physical Checkouts",
    subtitle = "Source: 2017-2023-10-Checkouts-SPL-Data.csv",
    caption = "Data starts in year of 2017 and goes until 2023",
    x = "Year",
    y = "Total Checkouts"
  ) +
  scale_x_continuous(breaks = seq(2017, 2023, 1), labels = c("17", "18", "19", "20", "21", "22", "23"))
  scale_fill_manual(values = c("Fiction" = "red", "All Other Genres" = "blue"))
  
library_checkout_bar_chart

