# Example preprocessing script.
DS <- as.data.frame(DS)
DS$ClientNumber <- paste0("0000",DS$ClientNumber)
DS$ClientNumber <- substr(DS$ClientNumber, nchar(DS$ClientNumber)-6, nchar(DS$ClientNumber))
colnames(DS)[1] <- "Client"
DS$MatterNumber <- paste0("000",DS$MatterNumber)
DS$MatterNumber <- substr(DS$MatterNumber, nchar(DS$MatterNumber)-6, nchar(DS$MatterNumber))
colnames(DS)[2] <- "Matter"
DS[3] <- anytime(DS$CompletionDate)
DS[4] <- anytime(DS$DateProcessed)
colnames(DS)[5] <- "DedupGB"
colnames(DS)[6] <- "DedupFiles"
colnames(DS)[7] <- "TotalDocPostFilter"
DS[8] <- as.numeric(paste(DS$TotalGBPostFiltering))
colnames(DS)[8] <- "GBPostFiltering"
DS[9] <- as.numeric(paste(DS$TotalGBPreExpansion))
colnames(DS)[9] <- "GBPreExp"
DS[11] <- NULL
DS[10] <- NULL
GBPostExp <- (DS$GBPostFiltering + DS$DedupGB)
DS <- cbind(DS, GBPostExp)
ExpansionRate <- DS$GBPostExp / DS$GBPreExp
DS <- cbind(DS, ExpansionRate)
TotalDocs <- DS$DedupFiles + DS$TotalDocPostFilter
DS <- cbind(DS, TotalDocs)
DocsPerGB <- DS$TotalDocs / DS$GBPostExp
DS <- cbind(DS, DocsPerGB)
GBAvgFileSize <- DS$GBPostExp /DS$TotalDocs
DS <- cbind(DS, GBAvgFileSize)

#Removing Bad Data
DS1 <- subset(DS, DS$GBPreExp > 0)
DS1 <- subset(DS1, DS1$ExpansionRate >= 1)

#DS1 is data that can be worked with.  Includes outliers. Remove information that will not be used.
DS1$Client <- NULL
DS1$Matter <- NULL
DS1$DateProcessed <- NULL
DS1$CompletionDate <- NULL

#Work for RMarkDown files
#Initial Analysis
plot(DS1$ExpansionRate)
boxplot(DS1$ExpansionRate)
hist(DS1$ExpansionRate, 
     main="Expansion Rate", 
     xlab="ExpansionRate", 
     border="blue", 
     col="green",
     las=1,
     prob = TRUE)
lines(density(DS1$ExpansionRate))
print(summary(DS1$ExpansionRate))

#There are some significant outliers.  To get better data, I will remove those above the 3rd quintile.
#DS3 Has outliers removed
DS2 <- subset(DS1, DS1$ExpansionRate < 3)
plot(DS2$ExpansionRate)
boxplot(DS2$ExpansionRate)
hist(DS2$ExpansionRate, 
     main="Expansion Rate", 
     xlab="ExpansionRate", 
     border="blue", 
     col="green",
     las=1,
     prob = TRUE)
lines(density(DS2$ExpansionRate))
print(summary(DS2$ExpansionRate))
#Loss of records due to cutting outliers 4916-4697 = 219
#Commnents distribution looks much better, but need to classify records
#with no expansion

#Check document counts
plot(DS2$DocsPerGB)
boxplot(DS2$DocsPerGB)
hist(DS2$DocsPerGB
     main="Expansion Rate", 
     xlab="ExpansionRate", 
     border="green", 
     col="blue",
     las=1,
     prob = TRUE)
lines(density(DS2$ExpansionRate))
summary(DS2$DocsPerGB)

#Need to cut outliers for document expansion
DS4 <- subset(DS3, DS3$DocsPerGB < 8000)
summary(DS4$DocsPerGB)
hist(DS4$DocsPerGB)
boxplot(DS4$DocsPerGB
        main="Expansion Rate", 
        xlab="ExpansionRate", 
        border="blue", 
        col="green",
        las=1,
        prob = TRUE)
lines(density(DS2$ExpansionRate))
plot(DS4$DocsPerGB)

#Add cuts to data frame as input to use in determining data
#expansion based on data expansion rate
ExpansionEstimate <- cut(DS4$ExpansionRate, breaks = 8, label = FALSE)
DS4 <- cbind(DS4, ExpansionEstimate)

#Add cuts to approximate documents per GB
DocsPerGBEstimate <- cut(DS4$DocsPerGB, breaks = 3, label = FALSE)
DS4 <- cbind(DS4, DocsPerGBEstimate)

#Create data set for first model
DS5 <- DS4[c(5, 11, 12, 10, 7)]


#Creating Data Partition with Caret
#?Caret
inTrain <- createDataPartition(DS5$ExpansionRate, p =0.75, list=FALSE)
str(inTrain)
training <- DS4[inTrain,]
testing <- DS4[-inTrain,]