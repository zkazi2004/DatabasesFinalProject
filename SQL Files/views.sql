-- VIEW 1: Average salary each employee has earned monthly
CREATE VIEW View1_AvgMonthlySalary AS
SELECT EmpID, AVG(Amount) AS AvgMonthlySalary
FROM SalaryTransaction
GROUP BY EmpID;

-- VIEW 2: Number of interview rounds each interviewee passed per job
CREATE VIEW View2_InterviewPassCount AS
SELECT IntervieweeID, JobID, COUNT(*) AS PassedRounds
FROM Interview
WHERE Grade > 60
GROUP BY IntervieweeID, JobID;

-- VIEW 3: Number of items of each product type sold
CREATE VIEW View3_ProductsSoldCount AS
SELECT P.ProductType, COUNT(*) AS ItemsSold
FROM Sale S
JOIN Product P ON S.ProductID = P.ProductID
GROUP BY P.ProductType;

-- VIEW 4: Part purchase cost per product
CREATE VIEW View4_ProductPartCost AS
SELECT PP.ProductID, SUM(PP.QuantityUsed * VP.Price) AS TotalPartCost
FROM ProductPart PP
JOIN VendorPart VP ON PP.PartID = VP.PartID
GROUP BY PP.ProductID;
