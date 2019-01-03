/*VIEW 1 - TopDoctor*/

CREATE VIEW TopDoctor AS
SELECT p.firstname, p.lastname, e.startdate
FROM PERSON P, EMPLOYEE E
WHERE e.employeepersonid = p.personid AND p.personid IN 
(
SELECT p.personid 
FROM CLASS2_PATIENT C2, PERSON P
WHERE c2.doctorpersonID = p.personid AND p.personid IN
(
SELECT  p.personid 
FROM CLASS1_PATIENT C1, PERSON P
WHERE c1.doctorpersonid = p.personid
GROUP BY p.personid
HAVING COUNT(c1.doctorpersonid) > 5
)
GROUP BY p.personid
HAVING COUNT(c2.doctorpersonid) > 10
);

/*--------------------------------------------------------------------*/

/*VIEW 3 - ReorderMeds*/

CREATE VIEW ReorderMeds AS
SELECT * 
FROM PHARMACY
WHERE (dateofexpiry - sysdate) < 30 OR quantity < 1000;

/*----------------------------------------------------------*/

/*VIEW 4 - PotentialPatient*/

CREATE VIEW PotentialPatient AS
SELECT p.firstname, p.lastname, p.personid, ph.phonenumber
FROM PERSON P INNER JOIN PERSON_PHONE PH ON P.PERSONID = PH.PERSONID
GROUP BY p.firstname, p.lastname, p.personid, ph.phonenumber
HAVING p.personid = ( 
    SELECT PERSONID 
    FROM class1_patient
    WHERE CLASS1_PATIENT.personid NOT IN (SELECT PERSONID FROM CLASS2_PATIENT)
    GROUP BY personid
    HAVING COUNT(class1patientid) > 3
);

/*----------------------------------------------------------------*/

/*VIEW 5 - MostFrequentIssues*/

CREATE VIEW MostFrequentIssues AS
SELECT TREATMENTNAME, TREATMENTDESCRIPTION
FROM TREATMENT
WHERE TREATMENTDESCRIPTION = (

        SELECT DESCRIPTION
        FROM PATIENT_RECORDS
        GROUP BY DESCRIPTION
        HAVING COUNT(DESCRIPTION) = (

        SELECT MAX(c) as maxcount
        FROM ((
            SELECT DESCRIPTION, COUNT(DESCRIPTION) as c 
            FROM PATIENT_RECORDS 
            GROUP BY DESCRIPTION))));

/*----------------------------------------------------------------*/