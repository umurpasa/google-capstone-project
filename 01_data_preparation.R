#load libraries 
library(tidyverse) #calculations
library(lubridate) #dates 
library(hms) #time
library(data.table) #exporting data frame
library(dplyr)
library(ggplot2)

#=================================================
# PREPARATION 
#=================================================

#load original .csv files, a years worth of data from August 2020 to July 2021
sep <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202309-divvy-tripdata.csv") 
oct <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202310-divvy-tripdata.csv") 
nov <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202311-divvy-tripdata.csv") 
dec <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202312-divvy-tripdata.csv") 
jan <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202401-divvy-tripdata.csv") 
feb <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202402-divvy-tripdata.csv") 
mar <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202403-divvy-tripdata.csv") 
apr <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202404-divvy-tripdata.csv") 
may <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202405-divvy-tripdata.csv") 
jun <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202406-divvy-tripdata.csv") 
jul <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202407-divvy-tripdata.csv") 
aug <- read_csv("C:/Users/mrpas/Desktop/google_capstone_project/data/202408-divvy-tripdata.csv") 

#merge all of the data frames into one year view
cyclistic_df <- rbind (sep, oct, nov, dec, jan, feb, mar, apr, may, jun, jul, aug)

#remove individual month data frames to clear up space in the environment 
remove(sep, oct, nov, dec, jan, feb, mar, apr, may, jun, jul, aug)

# Inspect the new table that has been created
# summary(cyclistic_df)
# colnames(cyclistic_df)
# nrow(cyclistic_df)
# dim(cyclistic_df)
# head(cyclistic_df)
# tail(cyclistic_df)
# str(cyclistic_df)

#=================================================
# PROCESSING
#=================================================

# grouping unique values
# unique(cyclistic_df$member_casual)
# 
# table(cyclistic_df$member_casual)
# 
# cyclistic_df %>%
#   group_by(member_casual) %>%
#   summarize(count = n())
# 
# cyclistic_df %>%
#   count(member_casual)

# adding neccessary columns to the data drame
cyclistic_df <- cyclistic_df %>%
  mutate(date = as.Date(started_at),  # Default format is yyyy-mm-dd
         month = format(date, "%m"),
         day = format(date, "%d"),
         year = format(date, "%Y"),
         day_of_week = format(date, "%A"),
         hour = hour(hms::as_hms(started_at)))  # Extract hour from the start time

cyclistic_df$ride_length <- difftime(cyclistic_df$ended_at, cyclistic_df$started_at, units = "mins")
cyclistic_df$ride_length <- as.numeric(cyclistic_df$ride_length)

# Remove rows where start_station_name is "HQ QR" or where ride_length is negative
cyclistic_df_v2 <- cyclistic_df %>%
  filter(start_station_name != "HQ QR" & ride_length > 0)

# Remove rows with NA values and duplicates
cyclistic_df_v2 <- cyclistic_df_v2 %>%
  na.omit() %>%
  distinct()

# Remove unnecessary columns from cyclistic_df_v2
cyclistic_df_v2 <- cyclistic_df_v2 %>%
  select(-c(start_lat, start_lng, end_lat, end_lng))

