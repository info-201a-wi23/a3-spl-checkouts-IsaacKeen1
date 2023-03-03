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
print_checkouts_over_time <- libraryData %>%
  filter(MaterialType == "BOOK" & CheckoutType != "Hoopla" & CheckoutType != "OverDrive") %>%
  group_by(CheckoutYear, CheckoutMonth) %>%
  summarise(total_checkouts = sum(Checkouts)) %>%
  mutate(timeline = as.Date(paste0(CheckoutYear, "-", CheckoutMonth, "-01")))

# Calculate the total number of checkouts by checkout type and material type
checkouts_by_type <- libraryData %>%
  group_by(CheckoutType, MaterialType) %>%
  summarise(total_checkouts = sum(Checkouts))

