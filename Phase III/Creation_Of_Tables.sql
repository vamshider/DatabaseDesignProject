CREATE TABLE PERSON(

    PersonId varchar2(4) not null,
    FirstName varchar2(20) not null,
    MiddleName varchar2(20),
    LastName varchar2(20) not null,
    Address varchar(200) not null,
    Gender char(2) not null,
    DateOfBirth date not null,
    
    PRIMARY KEY (PersonId)
    
);

CREATE TABLE PERSON_PHONE(

    PersonId varchar2(4) not null,
    PhoneNumber NUMBER(10) not null,
    
    PRIMARY KEY (PersonId, PhoneNumber),
    FOREIGN KEY (PersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE EMPLOYEE(

    EmployeePersonId varchar2(4) not null,
    StartDate date not null,
    Salary NUMBER(10,2) not null,
    Designation varchar2(200) not null,
    
    PRIMARY KEY (EmployeePersonId),
    FOREIGN KEY (EmployeePersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE DOCTOR(

    DoctorPersonId varchar2(4) not null,
    Specialization varchar2(20) not null,
    DoctorType varchar2(20), 
    
    PRIMARY KEY (DoctorPersonId),
    FOREIGN KEY (DoctorPersonId) REFERENCES PERSON(PersonId)
);


CREATE TABLE CLASS1_PATIENT(

    Class1PatientId varchar2(4) not null,
    PersonId varchar(4) not null,
    DoctorPersonId varchar(4) not null,
    
    PRIMARY KEY (Class1PatientId),
    FOREIGN KEY (PersonId) REFERENCES PERSON(PersonId),
    FOREIGN KEY (DoctorPersonId) REFERENCES DOCTOR(DoctorPersonId)
);

CREATE TABLE NURSE(

    NursePersonId varchar2(4) not null,
    
    PRIMARY KEY (NursePersonId),
    FOREIGN KEY (NursePersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE RECEPTIONIST(

    ReceptionistPersonId varchar2(4) not null,
    
    PRIMARY KEY (ReceptionistPersonId),
    FOREIGN KEY (ReceptionistPersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE TRAINEE(

    TraineePersonId varchar2(4) not null,
    
    PRIMARY KEY (TraineePersonId),
    FOREIGN KEY (TraineePersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE VISITING(

    VisitingPersonId varchar2(4) not null,
    
    PRIMARY KEY (VisitingPersonId),
    FOREIGN KEY (VisitingPersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE PERMANENT_DOCTOR(

    PermanentPersonId varchar2(4) not null,
    
    PRIMARY KEY (PermanentPersonId),
    FOREIGN KEY (PermanentPersonId) REFERENCES PERSON(PersonId)
);


CREATE TABLE CLASS2_PATIENT(

    Class2PatientId varchar2(4) not null,
    PersonId varchar(4) not null,
    DoctorPersonId varchar(4) not null,
    RoomNo number(10) not null,
    DateOfAdmit date not null,
    
    PRIMARY KEY (Class2PatientId),
    FOREIGN KEY (PersonId) REFERENCES PERSON(PersonId),
    FOREIGN KEY (DoctorPersonId) REFERENCES DOCTOR(DoctorPersonId)
);

CREATE TABLE ROOMS(

    RoomNumber number(10) not null,
    RoomType varchar2(20) not null,
    RoomDuration number(5),
    NursePersonId varchar2(4) not null,    

    PRIMARY KEY (RoomNumber),
    FOREIGN KEY (NursePersonId) REFERENCES NURSE(NursePersonId)
);

CREATE TABLE PATIENT_RECORDS(

    RecordId varchar2(20) not null,
    DateOfAppointment date not null,
    DateOfVisit date not null,
    Description varchar2(100) not null,
    PersonId varchar2(4) not null,
    
    PRIMARY KEY (RecordId),
    FOREIGN KEY (PersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE PHARMACY(

    MedicineCode varchar2(20) not null,
    MedicineName varchar2(100) unique not null,
    MedicinePrice number(10) not null,
    Quantity number(5) not null,
    DateOfExpiry date not null,
    
    PRIMARY KEY (MedicineCode)
);

CREATE TABLE TREATMENT(

    TreatmentId varchar2(20) not null,
    TreatmentName varchar2(100) not null,
    TreatmentDuration number(5) not null,
    TreatmentDescription VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (TreatmentId)
);

CREATE TABLE TREATMENT_MEDICINE(

    TreatmentId varchar2(20) not null,
    MedicineCode varchar2(20) not null,
    
    PRIMARY KEY (TreatmentId, MedicineCode),
    FOREIGN KEY (TreatmentId) REFERENCES TREATMENT(TreatmentId)
);

CREATE TABLE VISITOR(

    VisitorId varchar2(20) not null,
    Class2PatientId varchar2(4) not null,
    VisitorName varchar2(20) not null,
    VisitorAddress varchar2(100) not null,
    VisitorContact number(10) not null,
    
    PRIMARY KEY (VisitorId, Class2PatientId),
    FOREIGN KEY (Class2patientId) REFERENCES CLASS2_PATIENT(Class2PatientId)
);

CREATE TABLE BILL_PAYMENT(

    BillId varchar2(20) not null,
    PersonId varchar2(4) not null,
    DateOfPayment date not null,
    TotalAmountDue number(10,2) not null,
    
    PRIMARY KEY (BillId),
    FOREIGN KEY (PersonId) REFERENCES PERSON(PersonId)
);

CREATE TABLE BILL_CASH(

    BillId varchar2(20) not null,
    BillAmount number(10,2) not null,
    
    PRIMARY KEY (BillId),
    FOREIGN KEY (BillId) REFERENCES BILL_PAYMENT(BillId)
);

CREATE TABLE BILL_INSURANCE(

    InsuranceId varchar2(20) not null,
    BillId varchar2(20) not null,
    BillAmount number(10,2) not null,
    
    PRIMARY KEY (InsuranceId),
    FOREIGN KEY (BillId) REFERENCES BILL_PAYMENT(BillId)
);

CREATE TABLE INSURANCE_DETAILS(

    InsuranceId varchar2(20) not null,
    InsuranceProvider varchar2(100) not null,
    InsuranceCoverage number(10,2) not null,
    
    PRIMARY KEY (InsuranceId),
    FOREIGN KEY (InsuranceId) REFERENCES BILL_Insurance(InsuranceId)
);

CREATE TABLE MAINTAINS_RECORDS(

    RecordId varchar2(20) not null,
    ReceptionistPersonId varchar2(4) not null,
    
    PRIMARY KEY (RecordId, ReceptionistPersonId),
    FOREIGN KEY (RecordId) REFERENCES PATIENT_RECORDS(RecordId),
    FOREIGN KEY (ReceptionistPersonId) REFERENCES RECEPTIONIST(ReceptionistPersonId)
);

CREATE TABLE MAINTAINS_PAYMENTS(

    BillId varchar2(20) not null,
    ReceptionistPersonId varchar2(4) not null,
    
    PRIMARY KEY (BillId, ReceptionistPersonId),
    FOREIGN KEY (BillId) REFERENCES BILL_PAYMENT(BillId),
    FOREIGN KEY (ReceptionistPersonId) REFERENCES RECEPTIONIST(ReceptionistPersonId)
);

CREATE TABLE GETS_TREATMENT_PHARMACY(

    TreatmentId varchar2(20) not null,
    MedicineCode varchar2(20) not null,
    Class2PatientId varchar2(4) not null,
    
    PRIMARY KEY (MedicineCode, TreatmentId, Class2PatientId),
    FOREIGN KEY (MedicineCode) REFERENCES PHARMACY(MedicineCode),
    FOREIGN KEY (TreatmentId) REFERENCES TREATMENT(TreatmentId),
    FOREIGN KEY (Class2PatientId) REFERENCES CLASS2_PATIENT(Class2PatientId)
);