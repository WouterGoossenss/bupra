test <- log %>%
  filter(!is.na(diagnosis)) %>%
  group_by(case_id) %>%
  summarise(
    n = n()
  ) %>%
  filter(n > 1) %>%
  left_join(
    log %>%
      select(case_id, diagnosis, activity_instance_id, Activity) %>%
      filter(!is.na(diagnosis))
  ) %>%
  filter(Activity == "CHANGE DIAGN") %>%
  mutate(wrong_diagnosis = ifelse(case_id == lead(case_id), T, F)) %>%
  filter(wrong_diagnosis == T) %>%
  select(diagnosis, wrong_diagnosis) %>%
  group_by(diagnosis, wrong_diagnosis) %>%
  summarise(
    frequency = n()
  ) %>%
  arrange(-frequency) %>%
  select(-wrong_diagnosis)