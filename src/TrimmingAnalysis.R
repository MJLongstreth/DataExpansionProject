ModelData <- as.data.frame(my_matrix)
ModelData <- subset(ModelData, ModelData$DocumentPerGBPostExpan > 0)
ModelData <- subset(ModelData, ModelData$TotalGBPostExpansion > 0)
ModelData <- subset(ModelData, ModelData$DocumentPerGBPostExpan < 8500)
plot(ModelData$DocumentPerGBPostExpan)
boxplot(ModelData$DocumentPerGBPostExpan)
hist(ModelData$DocumentPerGBPostExpan)
DocumentsPerGBPostExpan_Log <- log2(ModelData$DocumentPerGBPostExpan)^4.25
hist(DocumentsPerGBPostExpan_Log)


DataExpansionRate <- c(ModelData$TotalGBPostExpansion / ModelData$TotalGBPreExpansion)
plot(DataExpansionRate)
#Need to figure out how to change below 1 to 1
#Need to figure out how to handle one values (No Expansion v. Expansion categorization?)
DataExpansionRate <- c(ModelData$TotalGBPostExpansion)
DataExpansionRate_Neg <- subset(DataExpansionRate, DataExpansionRate < 1)
DataExpansionRate_Remove <- subset(DataExpansionRate, DataExpansionRate < 3.25 & DataExpansionRate >= 1)
plot(DataExpansionRate_Remove)
boxplot(DataExpansionRate_Remove)
hist(DataExpansionRate_Remove)
DataExpansionRate_Remove_Log <- log(sqrt(DataExpansionRate_Remove))
hist(DataExpansionRate_Remove_Log)




