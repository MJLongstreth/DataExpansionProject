#Splitting data for training and testing
y <- DS1$TotalGBPreExpansion
split <- sample.split(y , SplitRatio = 0.8)
DS1 <- cbind(DS1, split)
train_data <- subset(DS1, split == "TRUE")
test_data <- subset(DS1, split == "FALSE")
test_data$split <- NULL
train_data$TotalGBPostExpansion.1 <- NULL
cr <- cor(train_data)
corrplot(cr, type = "lower")
library(corrplot)

