#=================================================
# ANALYZING
#=================================================

# Descriptive analysis on ride_length (all figures in seconds)
mean(cyclistic_df_v2$ride_length) #straight average (total ride length / rides)
median(cyclistic_df_v2$ride_length) #midpoint number in the ascending array of ride lengths
max(cyclistic_df_v2$ride_length) #longest ride
min(cyclistic_df_v2$ride_length) #shortest ride

# Compare members and casual users
aggregate(cyclistic_df_v2$ride_length ~ cyclistic_df_v2$member_casual, FUN = mean)
aggregate(cyclistic_df_v2$ride_length ~ cyclistic_df_v2$member_casual, FUN = median)
aggregate(cyclistic_df_v2$ride_length ~ cyclistic_df_v2$member_casual, FUN = max)
aggregate(cyclistic_df_v2$ride_length ~ cyclistic_df_v2$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(cyclistic_df_v2$ride_length ~ cyclistic_df_v2$member_casual + cyclistic_df_v2$day_of_week, FUN = mean)
# Notice that the days of the week are out of order. Let's fix that.
cyclistic_df_v2$day_of_week <- ordered(cyclistic_df_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
# Now, let's run the average ride time by each day for members vs casual users
aggregate(cyclistic_df_v2$ride_length ~ cyclistic_df_v2$member_casual + cyclistic_df_v2$day_of_week, FUN = mean)

# analyze ridership data by type and weekday
rides_by_day <- cyclistic_df_v2 %>% 
  group_by(member_casual, day_of_week) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, day_of_week)								# sorts

# Member types
cyclistic_df_v2 %>%
  count(member_casual)

# Total number of rides by user type
total_rides <- cyclistic_df_v2 %>%
  count(member_casual)
print(total_rides)

# Average ride length by user type
avg_ride_length <- cyclistic_df_v2 %>%
  group_by(member_casual) %>%
  summarise(mean_ride_length = mean(ride_length, na.rm = TRUE))
print(avg_ride_length)

# Number of rides by hour (comparing casual and member users)
rides_by_hour <- cyclistic_df_v2 %>%
  group_by(member_casual, hour) %>%
  count() %>%
print(rides_by_hour)

# Number of rides by bike type (rideable_type) and user type
rides_by_bike_type <- cyclistic_df_v2 %>%
  group_by(member_casual, rideable_type) %>%
  count() %>%
print(rides_by_bike_type)
