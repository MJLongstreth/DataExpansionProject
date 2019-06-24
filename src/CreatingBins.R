#Random Plots from DataCamp
ggvis(DS4, ~GBPreExp, ~GBPostExp)
qplot(DS4$GBPreExp, DS$GBPostExp)

#Playing with caret
testexpan <- training1[c(5, 11, 12, 10, 7)]
testdoc <- training[c(5, 11, 7, 6)]

featurePlot(testDS[,1:3], testDS[,4])
str(DS4)
featurePlot(training[])


gbmFit1 <- train(training$ExpansionRate ~ ., data = training, 
                 method = "gbm", 
                 verbose = FALSE)
gbmFit1

PCFit <- train(training$ExpansionRate ~.,
               data = training, 
               method ="glm",
               preProc = "pca",
               trControl = trainControl(preProcOptions = list(thresh = 0.8)))

comboInfo <- findLinearCombos(testexpan)
comboInfo

model <- lm(testexpan$ExpansionRate ~ testexpan$ExpansionEstimate + testexpan$DocsPerGBEstimate)
model1 <- lm(testexpan$ExpansionRate ~ log(testexpan$ExpansionEstimate^2) + log(testexpan$DocsPerGBEstimate^2) + mean(testexpan$GBAvgFileSize))
summary(model)
summary(model1)
plot(model)
anova(model, model1)

#Docs per GB
boxplot(DS4$DocsPerGB)
DocsPerGBEstimate <- cut(training$DocsPerGB, breaks = 3, label = FALSE)
summary(DocsPerGBEstimate)
training1 <- cbind(training, DocsPerGBEstimate)
hist(DocsPerGBEstimate)

testmean <-mean()