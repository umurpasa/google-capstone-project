#=================================================
#VISUALIZING
#=================================================

# Source the analysis script to load the data into memory
source("C:/Users/mrpas/Desktop/google_capstone_project/script/02_data_analysis.R")

# Total rides by user type (from the analysis file)
total_rides %>%
  ggplot(aes(x = member_casual, y = n, fill = member_casual)) +
  geom_col() +
  labs(title = "Total Rides by User Type", x = "User Type", y = "Total Rides") +
  theme_minimal()

# Rides by day of the week (from the analysis file)
rides_by_day %>%
  ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Number of Rides by Day of the Week", 
       x = "Day of the Week", y = "Number of Rides") +
  theme_minimal()

# Rides by hour (from the analysis file)
rides_by_hour %>%
  ggplot(aes(x = hour, y = n, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Rides by Hour", x = "Hour of the Day", y = "Number of Rides") +
  theme_minimal()

# Average Ride Length by Day of the Week (from the analysis file)
rides_by_day %>%
  ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Average Ride Length by Day of the Week",
       x = "Day of the Week", y = "Average Ride Length (minutes)") +
  theme_minimal()

# Number of Rides by Bike Type (from the analysis file)
rides_by_bike_type %>%
  ggplot(aes(x = rideable_type, y = n, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Number of Rides by Bike Type",
       x = "Bike Type", y = "Number of Rides") +
  theme_minimal()