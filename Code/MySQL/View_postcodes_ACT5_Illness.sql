#create a view out for all postcodes and diseases with ACTLevel5Name and illness name

CREATE VIEW AllZipCodeAndIllness
AS 

(SELECT patients.postcode, ATCLevel5Name,ChronicIllness_LookUp.ChronicIllness
FROM ATC_LookUp FORCE INDEX (idx_t3_5), 
transactions FORCE INDEX (idx_t1),
ChronicIllness_LookUp FORCE INDEX (idx_t2),
Drug_LookUp FORCE INDEX (idx_t4_5),
Patients FORCE INDEX(idx_patients)
where (
Patients.Patient_ID = TRANSACTIONS.Patient_ID
and
TRANSACTIONS.Drug_ID = Drug_LookUp.MasterProductID
and Drug_LookUp.ATCLevel5Code = ATC_LookUp.ATCLevel5Code
and Drug_LookUp.MasterProductID = ChronicIllness_LookUp.MasterProductID);



# TOP diseases in Australia overall and then statewise numbers
#find top diseases in Australia from the view
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in Victoria
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 3000 and 3999 
or postcode between 8000 and 8999
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in NSW
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 1000 and 1999 
or postcode between 2000 and 2599
or postcode between 2620 and 2899
or postcode between 2921 and 2999
group by chronicIllness
order by count(chronicIllness) desc;



#find top diseases in ACT
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 0200 and 0299 
or postcode between 2600 and 2619
or postcode between 2900 and 2920
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in QLD
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 4000 and 4999 
or postcode between 9000 and 9999
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in SA
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 5000 and 5799 
or postcode between 5800 and 5999
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in WA
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 6000 and 6797
or postcode between 6800 and 6999
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in Tasmania
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 7000 and 7799
or postcode between 7800 and 7999
group by chronicIllness
order by count(chronicIllness) desc;

#find top diseases in NT
select chronicIllness, count(chronicIllness)
from AllZipCodeAndIllness
where postcode between 0800 and 0899
or postcode between 0900 and 0999
group by chronicIllness
order by count(chronicIllness) desc;