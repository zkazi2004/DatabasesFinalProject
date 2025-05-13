-- QUERY 1
-- Interviewers for Hellen Cole's interview for job 11111
SELECT DISTINCT I.InterviewerID, P.FirstName, P.LastName
FROM Interview I
JOIN Person P ON I.InterviewerID = P.PersonalID
JOIN Person H ON I.IntervieweeID = H.PersonalID
WHERE H.FirstName = 'Hellen' AND H.LastName = 'Cole' AND I.JobID = 11111;

-- QUERY 2
-- Job IDs posted by Marketing in Jan 2011
SELECT JobID
FROM JobPosition JP
JOIN Department D ON JP.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Marketing'
AND EXTRACT(YEAR FROM PostedDate) = 2011
AND EXTRACT(MONTH FROM PostedDate) = 1;

-- QUERY 3
-- Employees with no supervisees
SELECT E.PersonalID, P.FirstName, P.LastName
FROM Employee E
JOIN Person P ON E.PersonalID = P.PersonalID
WHERE E.PersonalID NOT IN (
    SELECT SupervisorID FROM Employee WHERE SupervisorID IS NOT NULL
);

-- QUERY 4
-- Sites with no sales during March 2011
SELECT SiteID, SiteLocation
FROM MarketingSite
WHERE SiteID NOT IN (
    SELECT SiteID FROM Sale
    WHERE EXTRACT(YEAR FROM SaleTime) = 2011 AND EXTRACT(MONTH FROM SaleTime) = 3
);

-- QUERY 5
-- Jobs that did not hire anyone 1 month after posting
SELECT JP.JobID, JP.JobDescription
FROM JobPosition JP
WHERE NOT EXISTS (
    SELECT 1 FROM Interview I
    WHERE I.JobID = JP.JobID
    GROUP BY I.IntervieweeID
    HAVING AVG(I.Grade) > 70 AND COUNT(CASE WHEN I.Grade > 60 THEN 1 END) >= 5
)
AND JP.PostedDate <= CURRENT_DATE - INTERVAL '1 month';

-- QUERY 6
-- Salesmen who sold all products > $200
SELECT DISTINCT S.SalesmanID, P.FirstName, P.LastName
FROM Sale S
JOIN Person P ON S.SalesmanID = P.PersonalID
WHERE NOT EXISTS (
    SELECT ProductID FROM Product WHERE ListPrice > 200
    EXCEPT
    SELECT ProductID FROM Sale WHERE Sale.SalesmanID = S.SalesmanID
);

-- QUERY 7
-- Departments with no job post in Jan-Feb 2011
SELECT DepartmentID, DepartmentName
FROM Department
WHERE DepartmentID NOT IN (
    SELECT DepartmentID FROM JobPosition
    WHERE PostedDate BETWEEN '2011-01-01' AND '2011-02-01'
);

-- QUERY 8
-- Existing employees who applied for job 12345
SELECT P.PersonalID, P.FirstName, P.LastName, DA.DepartmentID
FROM Application A
JOIN Employee E ON A.PersonalID = E.PersonalID
JOIN Person P ON P.PersonalID = E.PersonalID
JOIN DepartmentAssignment DA ON E.PersonalID = DA.EmpID
WHERE A.JobID = 12345;

-- QUERY 9
-- Best-selling product type
SELECT ProductType
FROM Product P
JOIN Sale S ON S.ProductID = P.ProductID
GROUP BY ProductType
ORDER BY COUNT(*) DESC
LIMIT 1;

-- QUERY 10
-- Product type with highest net profit
SELECT P.ProductType
FROM Product P
JOIN ProductPart PP ON P.ProductID = PP.ProductID
JOIN VendorPart VP ON PP.PartID = VP.PartID
GROUP BY P.ProductType
ORDER BY SUM(P.ListPrice) - SUM(PP.QuantityUsed * VP.Price) DESC
LIMIT 1;

-- QUERY 11
-- Employees who have worked in all departments
SELECT E.PersonalID, P.FirstName, P.LastName
FROM Employee E
JOIN Person P ON E.PersonalID = P.PersonalID
WHERE NOT EXISTS (
    SELECT DepartmentID FROM Department
    EXCEPT
    SELECT DepartmentID FROM DepartmentAssignment WHERE EmpID = E.PersonalID
);

-- QUERY 12
-- Name and email of selected interviewees
-- (Assuming Email attribute exists in Person)
SELECT P.FirstName, P.LastName, P.Email
FROM Person P
WHERE P.PersonalID IN (
    SELECT IntervieweeID FROM Interview
    GROUP BY IntervieweeID
    HAVING AVG(Grade) > 70 AND COUNT(CASE WHEN Grade > 60 THEN 1 END) >= 5
);

-- QUERY 13
-- Name, phone, email of interviewees selected for all their applied jobs
SELECT DISTINCT P.FirstName, P.LastName, P.PhoneNumber, P.Email
FROM Person P
JOIN Interview I ON P.PersonalID = I.IntervieweeID
JOIN PhoneNumber PN ON PN.PersonalID = P.PersonalID
WHERE P.PersonalID IN (
    SELECT IntervieweeID FROM Interview
    GROUP BY IntervieweeID
    HAVING AVG(Grade) > 70 AND COUNT(CASE WHEN Grade > 60 THEN 1 END) >= 5
);

-- QUERY 14
-- Employee with highest average salary
SELECT E.PersonalID, P.FirstName, P.LastName
FROM Employee E
JOIN Person P ON E.PersonalID = P.PersonalID
JOIN SalaryTransaction ST ON E.PersonalID = ST.EmpID
GROUP BY E.PersonalID, P.FirstName, P.LastName
ORDER BY AVG(ST.Amount) DESC
LIMIT 1;

-- QUERY 15
-- Vendor who supplies the cheapest "Cup" under 4 lbs
SELECT V.VendorID, V.VendorName
FROM Vendor V
JOIN VendorPart VP ON V.VendorID = VP.VendorID
JOIN Part P ON VP.PartID = P.PartID
WHERE P.PartName = 'Cup' AND P.Weight < 4
ORDER BY VP.Price ASC
LIMIT 1;
