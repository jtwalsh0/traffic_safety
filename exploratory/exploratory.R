

require('checkpoint')
checkpoint('2017-08-01', project = 'git-projects/traffic_safety')


require('dplyr')
require('readr')
require('scales')
library('ggplot2')


configuration = fromJSON(traffic_safety_config.json)
working_directory = configuration$working_directory
care_data = configuration$files$care_data


raw_df = read_csv(care_data)


# traffic crashes per year
raw_df %>%
  select(`Year`) %>%
  group_by(`Year`) %>%
  summarize(y = n()) %>%
  ggplot(aes(`Year`, `y`)) + 
    ggtitle('Alabama Traffic Crashes: Yearly') +
    scale_y_continuous(labels = comma) +
    xlab('year') + 
    ylab('# crashes') +
    geom_line()
    


# traffic crashes by week
raw_df %>%
  mutate(week = Year + `Week of the Year`/12) %>%
  group_by(`week`) %>%
  summarize(y = n()) %>%
  ggplot(aes(week, y)) + 
    ggtitle('Alabama Traffic Crashes: Weekly') +
    xlab('week') + 
    ylab('# crashes') +
    geom_line()


# traffic crashes per day of week
raw_df %>%
  mutate(dow = ordered(`Day of the Week`,
                       levels = c('Sunday',
                                  'Monday',
                                  'Tuesday',
                                  'Wednesday',
                                  'Thursday',
                                  'Friday',
                                  'Saturday'))) %>%
  select(dow) %>%
  ggplot(aes(dow)) + 
    ggtitle('Alabama Traffic Crashes: Day of Week') +
    xlab('') + 
    ylab('# crashes') +
    geom_histogram(stat='count')


# traffic crashes by time of day
raw_df %>%
  mutate(tod = ordered(`Time of Day`,
                       levels = c('12:00 Midnight to 12:59 AM',
                                  '1:00 AM to 1:59 AM',
                                  '2:00 AM to 2:59 AM',
                                  '3:00 AM to 3:59 AM',
                                  '4:00 AM to 4:59 AM',
                                  '5:00 AM to 5:59 AM',
                                  '6:00 AM to 6:59 AM',
                                  '7:00 AM to 7:59 AM',
                                  '8:00 AM to 8:59 AM',
                                  '9:00 AM to 9:59 AM',
                                  '10:00 AM to 10:59 AM',
                                  '11:00 AM to 11:59 AM',
                                  '12:00 Noon to 12:59 PM',
                                  '1:00 PM to 1:59 PM',
                                  '2:00 PM to 2:59 PM',
                                  '3:00 PM to 3:59 PM',
                                  '4:00 PM to 4:59 PM',
                                  '5:00 PM to 5:59 PM',
                                  '6:00 PM to 6:59 PM',
                                  '7:00 PM to 7:59 PM',
                                  '8:00 PM to 8:59 PM',
                                  '9:00 PM to 9:59 PM',
                                  '10:00 PM to 10:59 PM',
                                  '11:00 PM to 11:59 PM'))) %>%
  select(`tod`) %>%
  #group_by(`tod`) %>%
  #summarize(y = n()) %>%
  ggplot(aes(`tod`)) + 
    ggtitle('Alabama Traffic Crashes: Hourly') +
    xlab('time of day') + 
    ylab('# crashes') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_histogram(stat='count')

