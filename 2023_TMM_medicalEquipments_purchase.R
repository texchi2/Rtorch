# Load the required libraries
library(ggplot2)
library(dplyr)
library(gridExtra)

# Create a data frame with the TMM purchase progression data
tmm_data <- data.frame(
  Equipment = c("Autoclave", "C-arm", "ABG", "VelScope", "Telemedicine", "PACS", "Other"),
  Price = c(4400, 48000, 33760, 5500, 52000, 125000, 37013)
)

# Sort the data by price
tmm_data <- tmm_data %>% arrange(Price)

# Draw a stacked bar chart
ggplot(tmm_data, aes(x = Equipment, y = Price)) +
  geom_bar(stat = "identity") +
  ggtitle("TMM Purchase Plan before 2023/06") +
  xlab("Equipment") +
  ylab("Price (USD)")


### # Calculate the total budget (USD)
total_budget <- 305673

# Calculate the percentage of the total budget spent on Telemedicine, PACS, and C-arm
tmm_data$Percentage <- tmm_data$Price / total_budget * 100

# Create a new column to specify the color of each equipment category
tmm_data$Color <- ifelse(tmm_data$Equipment %in% c("Telemedicine", "PACS", "C-arm", "ABG", "VelScope", "Autoclave"), tmm_data$Equipment, "Others") # Others= xxx

# Order the data by price in descending order
tmm_data <- tmm_data %>% arrange(desc(Price))

# Create a pie chart for the major equipment categories
p1 <- ggplot(tmm_data %>% filter(Color != "Other"), aes(x = "", y = Percentage, fill = Color)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = c("Telemedicine" = "red", "PACS" = "turquoise2", "C-arm" = "brown", "ABG" = "wheat", "Others" = "white", "Veloscope" = "lawngreen", "Autoclave"="slateblue2")) +
  geom_text(aes(label = paste0("$", Price)), position = position_stack(vjust = 0.3), size =2)
#  scale_fill_manual(name = "Equipment", values = c("Telemedicine" = "red", "PACS" = "turquoise2", "C-arm" = "brown", "ABG" = "wheat", "Others" = "white", "Veloscope" = "lawngreen", "Autoclave"="slateblue2")) +
#  geom_text(aes(label = paste0("$", Price)), position = position_stack(vjust = 0.3), size = 2)

##
# Create a pie chart for the other equipment categories
p2 <- ggplot(tmm_data %>% filter(Color == "Other"), aes(x = "", y = Percentage, fill = Color)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = c("Other" = "slategray3")) +
  geom_text(aes(label = paste0(round(Percentage), "%")), position = position_stack(vjust = 0.5), size = 3)

# Arrange the two pie charts next to each other
grid.arrange(p1, p2, ncol = 2)


  