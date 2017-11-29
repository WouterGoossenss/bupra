# test <- log %>%
#   mutate(duration = ifelse(case_id == lead(case_id), seconds_to_period(lead(Timestamp) - Timestamp), 0)) %>%
#   select(case_id, Activity, Timestamp, duration)

# test <- log %>%
#   mutate(duration = ifelse(case_id == lead(case_id), lead(Timestamp) - Timestamp, NA)) %>%
#   group_by(case_id) %>%
#   summarise(
#     duration = mean(duration, na.rm = T)
#   ) %>%
#   left_join(
#     log %>%
#       select(case_id, `Variant index`)
#   ) %>%
#   group_by(`Variant index`) %>%
#   summarise(
#     mean_duration = mean(duration, na.rm = T)
#   ) %>%
#   mutate(mean_duration = seconds_to_period(mean_duration))

test <- log %>%
  traces(output_cases = T)

test <- test[[2]] %>%
  left_join(
    test[[1]],
    by = c("trace_id", "trace_id")
  ) %>%
  left_join(
    log %>%
      select(case_id, Timestamp, activity_instance_id, Activity)
  ) %>%
  arrange(-relative_frequency, case_id, activity_instance_id) %>%
  mutate(duration = ifelse(case_id == lead(case_id), lead(Timestamp) - Timestamp, NA)) %>%
  group_by(trace_id, Activity) %>%
  summarise(
    mean_duration = mean(duration, na.rm = T)
  ) %>%
  mutate(mean_duration = ifelse(mean_duration != "NaN", mean_duration, 0))

test <- test %>%
  select(trace_id, Activity, mean_duration) %>%
  

