############################################################################################################## 
# Date:         April 25, 2017
# Author:       Basant Khati
# Module:       PatientsHistoryWithDiabetes
# Description:  This script fetches medication history of all the patients that were diagnosed with 
#               diabetes and started taking "Metformin". The medication history is extracted till their 
#               first prescription of "Metformin" 500MG.
# Dependencies: MySQL tables and views.
############################################################################################################## 

library(RMySQL)
library(dbConnect)
library("dplyr")
library("sqldf")
library("dplyr")

# pass the MySQL Credentials (**edit here)- 
mydb = dbConnect(MySQL(), user='xxxx', password='password', dbname='MelbDatathon2017', host='localhost')

resultSet = data.frame()
historySet = data.frame()

#Provide the zip code range as per requirement (**edit here)- 
pull2 <- dbSendQuery(mydb, paste("select Patient_ID,postcode as Postcode, gender as Gender,Prescription_Week,
                                  Dispense_Week,ATCLevel5Name,StrengthCode from  Metformin500MGView;"))

resultSet = fetch(pull2, n=-1)
refinedSet = resultSet[!duplicated(resultSet$Patient_ID),]

write.csv(refinedSet, "//Volumes//JetDrive//Root//Datasets//Datathon//work//output//DiabeticPatients.csv",row.names=FALSE) 

fileCount <- 1
# Let's measure the execution time as well
start.time <- Sys.time()
for(i in 1:nrow(refinedSet)) {

  dFrame <- refinedSet[i,]
  patientId <- dFrame$Patient_ID
  #prescriptionWeek <- ymd(dFrame$Prescription_Week)
  prescriptionWeek <- dFrame$Prescription_Week
  
  
  pull <- dbSendQuery(mydb, paste("select Patient_ID, postcode as Postcode, gender as Gender, Prescription_Week, 
                                   Dispense_Week, ATCLevel5Name,StrengthCode from PatientsAndDiseasesView 
                                   where Patient_ID=",patientId,"and Prescription_Week < '"
                                  ,prescriptionWeek,"';"))
  
  
  dataBuffer = fetch(pull, n=-1)
  
  historySet <- rbind(historySet, data.frame(dataBuffer))
  
  # Write the dataframe into file after every 4000 iterations
  if (i%%4000 == 0){
    print(i)
    outFile = paste("//Volumes//JetDrive//Root//Datasets//Datathon//work//output//outFile_",fileCount,".csv")
    write.csv(historySet, outFile,row.names=FALSE)

    rm(historySet)
    historySet = data.frame()

    fileCount<- fileCount + 1
  }

}

outFile = paste("//Volumes//JetDrive//Root//Datasets//Datathon//work//output//outFile_",fileCount,".csv")
write.csv(historySet, outFile,row.names=FALSE)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

# Clean up 
rm(resultSet)
rm(dataBuffer)
lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)



