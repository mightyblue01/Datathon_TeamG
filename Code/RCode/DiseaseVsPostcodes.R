# This fetches all patients data for a given disease and specific postcodes 

library(RMySQL)
library(dbConnect)
library("dplyr")
library("sqldf")
library("dplyr")

# pass the MySQL Credentials (**edit here)- 
mydb = dbConnect(MySQL(), user='xxxx', password='password', dbname='MelbDatathon2017', host='localhost')

#set the zip code here (**edit here)- 
zip_param <- 3000
#set the chronicillness name here (**edit here)- 
chronicIllnessName <- '"Hypertension"'

resultSet = data.frame()

#Provide the zip code range as per requirement (**edit here)- 
for(zip_param in 3000:3139) {
  pull2 <- dbSendQuery(mydb, paste("select postcode, ATCLevel5Name as ATCLevel5Name, count(ATCLevel5Name) as consumption from 
                                    AllZipCodeAndIllness where postcode= 
                                   ",zip_param," and ChronicIllness=",chronicIllnessName," group by ATCLevel5Name
                                   order by count(ATCLevel5Name) desc limit 3;"))
  
  data = fetch(pull2, n=-1)
  #print(data3)
  resultSet <- rbind(resultSet, data.frame(data))
  
}

#print(resultSet)

#set the output file name (**edit here)- 
write.csv(resultSet, "//Volumes//JetDrive//Hypertension_Vic.csv",row.names=FALSE) 

rs = resultSet %>% distinct(postcode, .keep_all = TRUE)
print(rs[1:10,])

# Pass the top ingredient from Australian or statewise data 
topRows = subset(rs, ATCLevel5Name == "IRBESARTAN\r")
#just testing if we're getting meaningful output
print(topRows[1:10,])

# write the data matching suburbs with overall data
write.csv(topRows, "//Volumes//JetDrive//SubMatchingState_Hypertension.csv",row.names=FALSE) 
lowRows = subset(rs, ATCLevel5Name != "IRBESARTAN\r")
print(lowRows[1:5,])
# write the data NOT matching suburbs with overall data
write.csv(lowRows, "//Volumes//JetDrive//NotMatchingState_Hypertension.csv",row.names=FALSE) 

rm(resultSet)
lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)



