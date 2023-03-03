libraryData <- read.csv("/Users/isaackeen/Documents/Data/2017-2023-10-Checkouts-SPL-Data.csv")
library(dplyr)

# Calculate the average number of checkouts for each item
overall_avg_checkouts <- mean(libraryData$Checkouts)
# Calculate the month or year with the most/least checkouts for a book that you're interested in
book_title <- "The Great Gatsby"
book_checkouts_by_month <- libraryData %>%
  filter(Title == book_title) %>%
  group_by(CheckoutYear, CheckoutMonth) %>%
  summarise(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts))
most_popular_month <- book_checkouts_by_month$CheckoutMonth[1]
least_popular_month <- book_checkouts_by_month$CheckoutMonth[nrow(book_checkouts_by_month)]

# Calculate the month or year with the most/least checkouts for ebooks
ebook_checkouts_by_month <- libraryData %>%
  filter(MaterialType == "EBOOK") %>%
  group_by(CheckoutYear, CheckoutMonth) %>%
  summarise(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts))
most_popular_ebook_month <- ebook_checkouts_by_month$CheckoutMonth[1]
least_popular_ebook_month <- ebook_checkouts_by_month$CheckoutMonth[nrow(ebook_checkouts_by_month)]

# Calculate how the number of print book checkouts has changed over time
physical_checkouts_over_time <- libraryData %>%
  filter(MaterialType == "BOOK" & CheckoutType != "Hoopla" & CheckoutType != "OverDrive") %>%
  group_by(CheckoutYear) %>%
  summarise(total_checkouts = sum(Checkouts)) %>%
  filter(CheckoutYear %in% c(2017, 2017))

# Calculate the difference between 2017 and 2022
physical_checkouts_difference <- diff(physical_checkouts_over_time$total_checkouts)

# Calculate the most common material tyoe
checkouts_by_material_type <- libraryData %>%
  group_by(MaterialType) %>%
  summarise(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts))


most_checkout_material <- checkouts_by_material_type$MaterialType[1]
most_checkout_material_checkouts <- checkouts_by_material_type$total_checkouts[1]

