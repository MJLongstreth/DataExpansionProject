model <- lm(DS5$ExpansionRate ~ DS5$ExpansionEstimate + DS5$DocsPerGBEstimate)

model1 <- lm(testexpan$ExpansionRate ~ log(testexpan$ExpansionEstimate^2) + log(testexpan$DocsPerGBEstimate^2) + mean(testexpan$GBAvgFileSize))