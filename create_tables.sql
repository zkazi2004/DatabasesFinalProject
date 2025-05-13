-- CREATE TABLE Statements

CREATE TABLE Person (
    PersonalID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT CHECK (Age < 65),
    Gender VARCHAR(10),
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

CREATE TABLE PhoneNumber (
    PersonalID INT,
    PhoneNumber VARCHAR(15),
    PRIMARY KEY (PersonalID, PhoneNumber),
    FOREIGN KEY (PersonalID) REFERENCES Person(PersonalID)
);

CREATE TABLE Employee (
    PersonalID INT PRIMARY KEY,
    Rank VARCHAR(50),
    Title VARCHAR(50),
    SupervisorID INT,
    FOREIGN KEY (PersonalID) REFERENCES Person(PersonalID),
    FOREIGN KEY (SupervisorID) REFERENCES Employee(PersonalID)
);

CREATE TABLE Customer (
    PersonalID INT PRIMARY KEY,
    PreferredSalesRepID INT,
    FOREIGN KEY (PersonalID) REFERENCES Person(PersonalID),
    FOREIGN KEY (PreferredSalesRepID) REFERENCES Employee(PersonalID)
);

CREATE TABLE PotentialEmployee (
    PersonalID INT PRIMARY KEY,
    FOREIGN KEY (PersonalID) REFERENCES Person(PersonalID)
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE DepartmentAssignment (
    EmpID INT,
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (EmpID, DepartmentID, StartDate),
    FOREIGN KEY (EmpID) REFERENCES Employee(PersonalID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE JobPosition (
    JobID INT PRIMARY KEY,
    JobDescription VARCHAR(255),
    PostedDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Application (
    ApplicationID INT PRIMARY KEY,
    PersonalID INT,
    JobID INT,
    FOREIGN KEY (PersonalID) REFERENCES Person(PersonalID),
    FOREIGN KEY (JobID) REFERENCES JobPosition(JobID)
);

CREATE TABLE Interview (
    InterviewID INT PRIMARY KEY,
    InterviewTime TIMESTAMP,
    Grade DECIMAL(5,2),
    JobID INT,
    IntervieweeID INT,
    InterviewerID INT,
    FOREIGN KEY (JobID) REFERENCES JobPosition(JobID),
    FOREIGN KEY (IntervieweeID) REFERENCES Person(PersonalID),
    FOREIGN KEY (InterviewerID) REFERENCES Employee(PersonalID)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductType VARCHAR(100),
    Size VARCHAR(50),
    ListPrice DECIMAL(10,2),
    Weight DECIMAL(10,2),
    Style VARCHAR(50)
);

CREATE TABLE Part (
    PartID INT PRIMARY KEY,
    PartName VARCHAR(100),
    Weight DECIMAL(10,2)
);

CREATE TABLE ProductPart (
    ProductID INT,
    PartID INT,
    QuantityUsed INT,
    PRIMARY KEY (ProductID, PartID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (PartID) REFERENCES Part(PartID)
);

CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(100),
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    AccountNumber VARCHAR(50),
    CreditRating INT,
    WebServiceURL VARCHAR(255)
);

CREATE TABLE VendorPart (
    VendorID INT,
    PartID INT,
    Price DECIMAL(10,2),
    PRIMARY KEY (VendorID, PartID),
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
    FOREIGN KEY (PartID) REFERENCES Part(PartID)
);

CREATE TABLE MarketingSite (
    SiteID INT PRIMARY KEY,
    SiteName VARCHAR(100),
    SiteLocation VARCHAR(100)
);

CREATE TABLE SiteAssignment (
    SiteID INT,
    PersonalID INT,
    PRIMARY KEY (SiteID, PersonalID),
    FOREIGN KEY (SiteID) REFERENCES MarketingSite(SiteID),
    FOREIGN KEY (PersonalID) REFERENCES Person(PersonalID)
);

CREATE TABLE Sale (
    SaleID INT PRIMARY KEY,
    SaleTime TIMESTAMP,
    ProductID INT,
    CustomerID INT,
    SalesmanID INT,
    SiteID INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(PersonalID),
    FOREIGN KEY (SalesmanID) REFERENCES Employee(PersonalID),
    FOREIGN KEY (SiteID) REFERENCES MarketingSite(SiteID)
);

CREATE TABLE SalaryTransaction (
    TransactionNumber INT,
    EmpID INT,
    PayDate DATE,
    Amount DECIMAL(10,2),
    PRIMARY KEY (TransactionNumber, EmpID),
    FOREIGN KEY (EmpID) REFERENCES Employee(PersonalID)
);
