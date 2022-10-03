rm(list=ls())
load("../data-cleaning/data/deidentified/s-somas_pilot2_data-rta-deidentified-20220310.Rdata")

head(data_deidentified_rta[,2:9])
sapply(X = data_deidentified_rta[,2:9], FUN = unique)
dat <- data_deidentified_rta %>%
  dplyr::mutate_at(vars(2:4), ~as.numeric(recode(., "Strongly Disagree" = 1, # Recording Likert responses to numeric as they are in text form
                                                    "Disagree" = 2,
                                                    "Somewhat Disagree" = 3,
                                                    "Neither Agree Nor Disagree" = 4,
                                                    "Somewhat Agree" = 5,
                                                    "Agree" = 6,
                                                    "Strongly Agree" = 7)))
dat <- dat %>%
  dplyr::mutate_at(vars(7), ~as.numeric(recode(., "Not at all" = 1, # Recording Likert responses to numeric as they are in text form
                                                 "Very Little" = 2,
                                                 "Less Than Average" = 3,
                                                 "Average" = 4,
                                                 "Grater Than Average" = 5,
                                                 "Large Amount" = 6,
                                                 "Great Deal" = 7)))

library("corrplot")
corrplot::corrplot(cor(dat[,c(7,78:88)], method = "spearman", use = "pairwise.complete"))
dat <- data.frame(dat, UVavg=rowSums(dat[,c(7,78:88)])/11)
corrplot::corrplot(cor(dat[,c(7,78:88,135)], method = "spearman", use = "pairwise.complete"))
