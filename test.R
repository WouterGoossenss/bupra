test <- log %>%
  group_by(`Variant index`, caseType) %>%
  summarise(
    abs_freq = n()
  ) %>%
  mutate(rel_freq = abs_freq / sum(abs_freq))
