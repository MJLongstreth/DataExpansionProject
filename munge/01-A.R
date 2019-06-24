# Preprocessing script to format data for initial analysis.

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