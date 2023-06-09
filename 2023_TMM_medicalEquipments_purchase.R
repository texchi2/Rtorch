# Load the required libraries
library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)

### # Calculate the total budget (USD)
total_budget <- 305673

# Create a data frame with the TMM purchase progression data
tmm_data <- data.frame(
  Equipment = c("Autoclave", "C-arm", "ABG", "Telemedicine", "VelScope", "FTTO", "Vitek",  "DrillMotor"), 
  Price = as.numeric(c(4400, 48000, 33760, 52000, 5500, 30000, 40000, 1950))
)
# 125,000 => 75,000; 50,000 for example

# "VelScope", USD5,500
# adding "Others" as the rest of total budget (under planning)
tmm_others <- data.frame(Equipment = "Others", Price = as.numeric(total_budget-sum(tmm_data$Price)))
tmm_data <- rbind(tmm_data, tmm_others)

# Sort the data by price
tmm_data <- tmm_data %>% arrange(Price)

# Draw a stacked bar chart
ggplot(tmm_data, aes(x = Equipment, y = Price)) +
  geom_bar(stat = "identity", width = 0.8) +
  ggtitle("TMM Purchases from January 2023 to June 2023") +
  xlab("Equipment") +
  ylab("Price (USD)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
# In this example, the angle argument of the element_text() function is set to 45, which means that the x-axis labels will be rotated by 45 degrees. The hjust argument is set to 1, which means that the labels will be horizontally justified to the right.


# Calculate the percentage of the total budget spent on Telemedicine, PACS, and C-arm
tmm_data$Percentage <- tmm_data$Price / total_budget * 100

# Create a new column to specify the color of each equipment category: others
tmm_data$Color <- ifelse(tmm_data$Equipment %in% c("Autoclave", "C-arm", "ABG", "VelScope", "FTTO", "Vitek",  "DrillMotor"), tmm_data$Equipment, "Others") # Others= xxx, 

# Order the data by price in descending order
tmm_data <- tmm_data %>% arrange(desc(Price))



#  "Telemedicine", "PACS", on 2024
# %>% filter(Color != "Others")
######################################


####################
# Create a pie chart for the major equipment categories
p1 <- ggplot(tmm_data , aes(x = "", y = Percentage, fill = Color)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = c("Telemedicine" = "red", "C-arm" = "brown", "ABG" = "wheat", "Others" = "slategray3", "FTTO" = "lawngreen", "Autoclave"="slateblue2", "Vitek" = "yellow3", "DrillMotor" = "yellow", "VelScope"="turquoise2")) +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")), position = position_stack(vjust = 0.3), size =2) +
  labs(fill = "Equipments")
# spared: "PACS" = "turquoise2", 

#  scale_fill_manual(name = "Equipment", values = c("Telemedicine" = "red", "PACS" = "turquoise2", "C-arm" = "brown", "ABG" = "wheat", "Others" = "white", "Veloscope" = "lawngreen", "Autoclave"="slateblue2")) +
#  geom_text(aes(label = paste0("$", Price)), position = position_stack(vjust = 0.3), size = 5)




##
# Create a pie chart for the other equipment categories
p2 <- ggplot(tmm_data , aes(x = "", y = Percentage, fill = Color)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = c("Telemedicine" = "white", "PACS" = "white", "C-arm" = "white", "ABG" = "white", "Others" = "slategray3", "FTTO" = "white", "Autoclave"="white", "Vitek" = "white", "DrillMotor" = "white", "VelScope"="white")) +
  labs(fill = "Equipments")

#+   geom_text(aes(label = paste0("$", Price)), position = position_stack(vjust = 0.3), size =3)

# slategray3; %>% filter(Color != "Others")



##


# Arrange the two pie charts next to each other


# Create a grobTree for the title with adjusted margins
title1 <- grobTree(
  rectGrob(gp = gpar(col = NA), height = unit(1.5, "lines"), y = 0.5),
  textGrob(
    "TMM Purchases from January 2023 to June 2023",
    gp = gpar(fontsize = 14),
    vjust = 1
  )
)

# Create textGrobs for the labels with adjusted vertical position
label_p1 <- textGrob(paste0("Purchasing: ", round(sum(tmm_data$Percentage[tmm_data$Color!="Others"]), 2), "%"), y = unit(1.3, "npc"))
label_p2 <- textGrob(paste0("Planning: ", round(sum(tmm_data$Percentage[tmm_data$Color=="Others"]), 2), "%"), y = unit(1.2, "npc"))


# Arrange the plots side by side with a common title and footer
grid.arrange(
  top = title1,
  p1, p2,
  heights = c(0.9, 0.1),
  label_p1, label_p2,
  ncol = 2
#  bottom = 
)

  