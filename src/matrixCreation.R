my_matrix <- as.matrix(DS[5:9])
head(my_matrix)
my_matrix <- cbind(my_matrix, DS[13])
TotalDocuments <- my_matrix$NumberofFilesDeduplicated + my_matrix$TotalDocumentsPostFiltering
my_matrix <- cbind(my_matrix, TotalDocuments)
DocumentPerGBPostExpan <- my_matrix$TotalDocuments / my_matrix$TotalGBPostExpansion
my_matrix <- cbind(my_matrix, DocumentPerGBPostExpan)
cor(my_matrix)
