1.

SELECT D.Specialization, E.StartDate 
FROM EMPLOYEE E, DOCTOR D
WHERE e.employeepersonid = d.doctorpersonid;

2.

SELECT p.firstname, p.middlename, p.lastname
FROM CLASS2_PATIENT C2, EMPLOYEE E, PERSON P
WHERE c2.personid = e.employeepersonid AND E.employeepersonid = p.personid AND ((c2.dateofadmit-e.startdate) < 90);

3. 

SELECT d.doctortype, ROUND(avg((sysdate - p.dateofbirth)/365)) as AverageAge
FROM TOPDOCTOR T, DOCTOR D, PERSON P
WHERE T.PERSONID = D.DOCTORPERSONID and P.PERSONID = D.DOCTORPERSONID
GROUP BY D.DOCTORTYPE;

4.


5. 

SELECT D.DOCTORPERSONID
FROM DOCTOR D

MINUS

SELECT DISTINCT D.DOCTORPERSONID
FROM DOCTOR D, CLASS1_PATIENT C1, CLASS2_PATIENT C2, BILL_PAYMENT B
WHERE (D.DoctorPersonId = C1.DoctorPersonId or D.DoctorPersonId = C2.DoctorPersonId) 
    and (C1.personid = B.PersonId or C2.personId = B.personid) and (sysdate - b.dateofpayment)/12 < 5



6.

SELECT I.INSURANCEPROVIDER, COUNT(B.PersonId) as NO_OF_PATIENTS
FROM BILL_PAYMENT B, bill_insurance BI, INSURANCE_DETAILS I
WHERE B.BillId = BI.BILLID and BI.INSURANCEID = I.INSURANCEID and B.TotalamountDue = BI.BILLAMOUNT
Group by I.INSURANCEPROVIDER

7. 

SELECT C2.ROOMNO, R.ROOMDURATION
        FROM CLASS2_PATIENT C2, ROOMS R
        WHERE C2.ROOMNO = R.ROOMNUMBER
        GROUP BY C2.ROOMNO, R.ROOMDURATION
        HAVING COUNT(C2.ROOMNO) = (

        SELECT MAX(c) as maxcount
        FROM ((
            SELECT ROOMNO, COUNT(ROOMNO) as c 
            FROM CLASS2_PATIENT 
            GROUP BY ROOMNO)))

8. 

select extract(year from DATEOFVISIT) as YEAR ,DESCRIPTION
from PATIENT_RECORDS
where extract(year from DATEOFVISIT)  IN

(SELECT extract(year from DATEOFVISIT) as year
        FROM PATIENT_RECORDS 
        GROUP BY extract(year from DATEOFVISIT)
        HAVING COUNT(RECORDID) = (
        SELECT MAX(c) as maxcount
        FROM ((
            SELECT extract(year from DATEOFVISIT), COUNT(RECORDID) as c 
            FROM PATIENT_RECORDS 
            GROUP BY extract(year from DATEOFVISIT))))
)

9.

SELECT G.TREATMENTID, T.TREATMENTDURATION
        FROM GETS_TREATMENT_PHARMACY G, TREATMENT T
        WHERE G.TREATMENTID = T.TREATMENTID
        GROUP BY G.TREATMENTID, T.TREATMENTDURATION
        HAVING COUNT(G.TREATMENTID) = (

        SELECT MIN(c) as maxcount
        FROM ((
            SELECT TREATMENTID, COUNT(TREATMENTID) as c 
            FROM GETS_TREATMENT_PHARMACY 
            GROUP BY TREATMENTID)))

10. 


11.

SELECT Distinct C2.class2patientid, p.firstname, p.lastname
FROM PATIENT_RECORDS R, CLASS2_PATIENT C2, Person P
WHERE R.DATEOFVISIT <= C2.DateOfAdmit and (C2.DateOfAdmit - R.DATEOFVISIT) <= 7 and p.personid = c2.personid

12. 

select extract(month from DATEOFPAYMENT) as MONTH ,SUM(TotalamountDue) as Sum
from bill_payment
where extract(year from DATEOFPAYMENT)  = 2017
GROUP BY extract(month from DATEOFPAYMENT)
 
13. 

SELECT P.firstname, p.lastname
From Person p, Class1_patient c1
WHERE c1.doctorPersonId = p.personid and c1.personId IN 
(SELECT PERSONID 
    FROM class1_patient
    WHERE CLASS1_PATIENT.personid NOT IN (SELECT PERSONID FROM CLASS2_PATIENT)
    GROUP BY personid
    HAVING COUNT(class1patientid) = 1 
)

14. 

SELECT  DISTINCT p.firstname, p.lastname,  ROUND((sysdate - p.dateofbirth)/365) as Age
FROM POTENTIALPATIENT PP, PERSON P
WHERE pp.personid = p.personid
