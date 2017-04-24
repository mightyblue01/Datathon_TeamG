library(RMySQL)
library(dbConnect)
library("dplyr")
# pass the MySQL Credentials - 
mydb = dbConnect(MySQL(), user='xxxx', password='password', dbname='MelbDatathon2017', host='localhost')

zip_param <- 3000

resultSet = data.frame()
for(zip_param in 3000:3999) {
  pull2 <- dbSendQuery(mydb, paste("select postcode, ATCLevel5Name, count(ATCLevel5Name) as consumption from ZipCodeATC5View
                                where postcode= 
                                   ",zip_param,"group by ATCLevel5Name
                                   order by count(ATCLevel5Name) desc limit 3;"))
                      
                      data = fetch(pull2, n=-1)
                      #print(data3)
                      resultSet <- rbind(resultSet, data.frame(data))

}

for(zip_param in 8000:8999) {
  pull2 <- dbSendQuery(mydb, paste("select postcode, ATCLevel5Name, count(ATCLevel5Name) as consumption from ZipCodeATC5View
                                   where postcode= 
                                   ",zip_param,"group by ATCLevel5Name
                                   order by count(ATCLevel5Name) desc limit 3;"))
  
  data = fetch(pull2, n=-1)
  #print(data3)
  resultSet <- rbind(resultSet, data.frame(data))
}
print(resultSet)
write.csv(resultSet, "//Volumes//JetDrive//MedicationByLocationFile1.csv",row.names=FALSE) 

#rm(resultSet)
#lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)



