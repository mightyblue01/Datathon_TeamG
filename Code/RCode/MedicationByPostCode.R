library(RMySQL)
library(dbConnect)
library("dplyr")
# pass the MySQL Credentials - 
mydb = dbConnect(MySQL(), user='xxxx', password='password', dbname='MelbDatathon2017', host='localhost')





zip_param <- 3000

result = data.frame()
for(zip_param in 3000:3139) {
  pull2 <- dbSendQuery(mydb, paste("select postcode, ATCLevel5Name, count(ATCLevel5Name) as consumption from ZipCodeATC5View
                                where postcode= 
                                   ",zip_param,"group by ATCLevel5Name
                                   order by count(ATCLevel5Name) desc limit 3;"))
                      
                      data3 = fetch(pull2, n=-1)
                      #print(data3)
                      result <- rbind( result, data.frame(data3))
                      
                      
}
print(result)
write.csv(result, "//Volumes//JetDrive//MedicationByLocation.csv",row.names=FALSE) 

#rm(result)
#lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)



