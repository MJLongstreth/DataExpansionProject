DS <- read.csv("C:/Users/Mike/Documents/UC Berkeley/Data Science/Project/FPS/data/processing_tickets_stats.csv")
View(DS)
DS$ClientNumber2 <- paste0("0000",DS$ClientNumber)
DS$ClientNumber3 <- substr(DS$ClientNumber2, nchar(DS$ClientNumber2)-6, nchar(DS$ClientNumber2))
DS$MatterNumber2 <- paste0("000",DS$MatterNumber)
DS$MatterNumber3 <- substr(DS$MatterNumber2, nchar(DS$MatterNumber2)-6, nchar(DS$MatterNumber2))
DS$ClientMatter <- paste(DS$ClientNumber3,DS$MatterNumber3, sep= "_")
hist(as.numeric(DS$TotalGBPreExpansion))
boxplot(as.numeric(DS$TotalGBPreExpansion))
summary(as.numeric(DS$TotalGBPreExpansion))
DS2 <- DS[as.numeric(DS$TotalGBPreExpansion) >=20 & as.numeric(DS$TotalGBPreExpansion) <= 1214,]
View(DS2)
boxplot(as.numeric(DS2$TotalGBPreExpansion))
summary(as.numeric(DS$TotalGBPreExpansion))
DS2$TotalGBPreExpansionNum <- as.numeric(DS2$TotalGBPreExpansion) 
DS2$TotalDocuments <- DS2$TotalDocumentsPostFiltering + DS2$NumberofFilesDeduplicated
DS2$DocumentPerMB <- DS2$TotalDocuments / DS2$TotalGBPreExpansionNum
hist(DS2$DocumentPerMB)
boxplot(DS2$DocumentPerMB)