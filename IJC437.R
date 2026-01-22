# Libraries Used
library(tidyverse)

# Import data 
MusicOset <- readr::read_delim(
  "C:/Users/Harsh/Desktop/ITDS Assignment/musicoset_songfeatures/musicoset_songfeatures_acoustic_features.csv",
  delim = "\t",
  trim_ws =TRUE,
  show_col_types = FALSE
)

# Missing data check
missing_summary <- MusicOset %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "column", values_to = "missing_count") %>%
  arrange(desc(missing_count))
missing_summary

# Summarize Data
head(MusicOset)
names(MusicOset)
nrow(MusicOset)

summary(MusicOset)

# Datatype Conversion for Modelling
MusicOset <- MusicOset %>%
  mutate(
    key = as.factor(key),
    mode = as.factor(mode),
    time_signature = as.factor(time_signature)
  )
str(MusicOset[,c("key","mode","time_signature")])

# Histogram of tempo
ggplot(MusicOset, aes(x = tempo)) +
  geom_histogram(bins = 30,fill = "lightgreen",color = "black",alpha = 0.8) +
  labs(title = "Distribution of Tempo", x = "Tempo (BPM)", y = "Count") 

# Histogram of energy
ggplot(MusicOset, aes(x = energy)) +
  geom_histogram(bins = 30,fill = "lightblue",color = "black",alpha = 0.8) +
  labs(title = "Distribution of Energy", x = "Energy", y = "Count")

# Boxplot of Loudness
ggplot(MusicOset, aes(y = loudness)) +
  geom_boxplot() +
  labs(title = "Boxplot of Loudness", y = "Loudness (dB)") 

# Scatterplot of Energy vs Loudness
ggplot(MusicOset, aes(x = energy, y = loudness)) +
  geom_point(alpha = 0.4,color = "purple") +
  labs(title = "Energy vs Loudness", x = "Energy", y = "Loudness (dB)")

# Correlation Analysis
cor.test(MusicOset$energy, MusicOset$loudness)
cor.test(MusicOset$danceability, MusicOset$tempo)

# Linear Regression()
lm_simple <- lm(loudness ~ energy, data = MusicOset)
summary(lm_simple)

ggplot(MusicOset, aes(x = energy, y = loudness)) +
  geom_point(alpha = 0.4,color = "lightblue") +
  geom_abline(intercept = coef(lm_simple)[1], slope = coef(lm_simple)[2]) +
  labs(title = "Linear Regression: Energy vs Loudness") +
  theme_bw()

# Multiple Linear Regression
lm_multi <- lm(loudness ~ energy + danceability + acousticness + valence, data = MusicOset)
summary(lm_multi)

MusicOset$pred_loudness <- predict(lm_multi)

ggplot(MusicOset, aes(x = loudness, y = pred_loudness)) +
  geom_point(alpha = 0.4,color = "grey") +
  geom_abline(intercept = 0, slope = 1) +
  labs(title = "Actual vs Predicted Loudness") +
  theme_bw()

# Classification
MusicOset <- MusicOset %>%
  mutate(high_energy = ifelse(energy > median(energy), 1, 0))

set.seed(123)
train_set <- sample_frac(MusicOset, 0.7)
test_set <- anti_join(MusicOset, train_set, by = "song_id")

log_model <- glm(
  high_energy ~ loudness + danceability + tempo,
  data = train_set,
  family = binomial(link = "logit")
)
summary(log_model)

# Prediction
prob <- predict(log_model, newdata = test_set, type = "response")
pred <- ifelse(prob >= 0.5, 1, 0)

# Confusion Matrix
cm <- table(Actual = test_set$high_energy, Predicted = pred)
cm

# Accuracy
accuracy <- mean(pred == test_set$high_energy)
accuracy

# Precision, Recall, F1 
TP <- cm["1","1"]
TN <- cm["0","0"]
FP <- cm["0","1"]
FN <- cm["1","0"]

precision <- TP / (TP + FP)
recall    <- TP / (TP + FN)
f1        <- 2 * (precision * recall) / (precision + recall)

precision
recall
f1


