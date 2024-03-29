-----------https://www.edureka.co/blog/interview-questions/sql-query-interview-questions

-- EmployeeInfo Table
CREATE TABLE EmployeeInfo (
    EmpID INT PRIMARY KEY,
    EmpFname VARCHAR(50),
    EmpLname VARCHAR(50),
    Department VARCHAR(50),
    Address VARCHAR(255),
    DOB DATE,
    Gender CHAR(1) -- Assuming 'M' or 'F' for Male or Female
);

-- EmployeePosition Table
CREATE TABLE EmployeePosition (
    EmpPosID INT PRIMARY KEY,
    EmpID INT,
    EmpPosition VARCHAR(50),
    DateOfJoining DATE,
    Salary DECIMAL(10, 2), -- Adjust the precision and scale as needed
    FOREIGN KEY (EmpID) REFERENCES EmployeeInfo(EmpID)
);

---
--Q1. Write a query to fetch the EmpFname from the EmployeeInfo table in upper case and use the ALIAS name as EmpName.
SELECT UPPER(EmpFname) AS EmpName FROM EmployeeInfo;

---
--Q2. Write a query to fetch the number of employees working in the department ‘HR’.
SELECT COUNT(*) FROM EmployeeInfo WHERE Department = 'HR';

---

--Q4. Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
SELECT SUBSTRING(EmpLname, 1, 4) FROM EmployeeInfo;

--Q5. Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.
SELECT MID(Address, 0, LOCATE('(',Address)) FROM EmployeeInfo;

---
--Q6. Write a query to create a new table which consists of data and structure copied from the other table.
CREATE TABLE NewTable AS SELECT * FROM EmployeeInfo;

---
--Q7. Write a query to find all the employees whose salary is between 50000 to 100000.
SELECT * FROM EmployeePosition WHERE Salary BETWEEN '50000' AND '100000';


---
--Q8. Write a query to find the names of employees that begin with ‘S’
SELECT * FROM EmployeeInfo WHERE EmpFname LIKE 'S%';



---
--Q10. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.
SELECT CONCAT(EmpFname, ' ', EmpLname) AS 'FullName' FROM EmployeeInfo;

---
--Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender
SELECT COUNT(*), Gender FROM EmployeeInfo 
WHERE DOB BETWEEN '1960-05-02' AND '1999-12-11' 
GROUP BY Gender;

---
--Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

SELECT * FROM EmployeeInfo ORDER BY EmpFname desc, Department asc;

---
--Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

SELECT * FROM EmployeeInfo WHERE EmpLname LIKE '____a';

----
--Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.
SELECT * FROM EmployeeInfo WHERE EmpFname NOT IN ('Sanjay','Sonia');


--Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.
SELECT * FROM EmployeeInfo WHERE Address LIKE 'DELHI(DEL)%';

--Q16. Write a query to fetch all employees who also hold the managerial position.
SELECT E.EmpFname, E.EmpLname, P.EmpPosition 
FROM EmployeeInfo E INNER JOIN EmployeePosition P ON
E.EmpID = P.EmpID AND P.EmpPosition IN ('Manager');


--Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.
SELECT Department, count(EmpID) AS EmpDeptCount 
FROM EmployeeInfo GROUP BY Department 
ORDER BY EmpDeptCount ASC;


---Q18. MOD() 


---Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.
SELECT * FROM EmployeeInfo E 
WHERE EXISTS 
(SELECT * FROM EmployeePosition P WHERE E.EmpId = P.EmpId);

--Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.

--To retrieve two minimum salaries, you can write a query as below:
SELECT DISTINCT Salary FROM EmployeePosition E1 
 WHERE 2 >= (SELECTCOUNT(DISTINCT Salary)FROM EmployeePosition E2 
  WHERE E1.Salary >= E2.Salary) ORDER BY E1.Salary DESC;

--To retrieve two maximum salaries, you can write a query as below: 
SELECT DISTINCT Salary FROM EmployeePosition E1 
 WHERE 2 >= (SELECTCOUNT(DISTINCT Salary) FROM EmployeePosition E2 
  WHERE E1.Salary <= E2.Salary) ORDER BY E1.Salary DESC;

--Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.
SELECT Salary 
FROM EmployeePosition E1 
WHERE N-1 = ( 
      SELECT COUNT( DISTINCT ( E2.Salary ) ) 
      FROM EmployeePosition E2 
      WHERE E2.Salary >  E1.Salary );

--Q22. Write a query to retrieve duplicate records from a table.
SELECT EmpID, EmpFname, Department COUNT(*) 
FROM EmployeeInfo GROUP BY EmpID, EmpFname, Department 
HAVING COUNT(*) > 1;

--Q23. Write a query to retrieve the list of employees working in the same department.
Select DISTINCT E.EmpID, E.EmpFname, E.Department 
FROM EmployeeInfo E, Employee E1 
WHERE E.Department = E1.Department AND E.EmpID != E1.EmpID;

--Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.
SELECT * FROM EmployeeInfo WHERE
EmpID <=3 UNION SELECT * FROM
(SELECT * FROM EmployeeInfo E ORDER BY E.EmpID DESC) 
AS E1 WHERE E1.EmpID <=3;

--Q25. Write a query to find the third-highest salary from the EmpPosition table.
SELECT TOP 1 salary
FROM(
SELECT TOP 3 salary
FROM employee_table
ORDER BY salary DESC) AS emp
ORDER BY salary ASC;

--Q26. Write a query to display the first and the last record from the EmployeeInfo table.

--To display the first record from the EmployeeInfo table, you can write a query as follows:
SELECT * FROM EmployeeInfo WHERE EmpID = (SELECT MIN(EmpID) FROM EmployeeInfo);

--To display the last record from the EmployeeInfo table, you can write a query as follows:
SELECT * FROM EmployeeInfo WHERE EmpID = (SELECT MAX(EmpID) FROM EmployeeInfo);

--Q27. Write a query to add email validation to your database
SELECT Email FROM EmployeeInfo WHERE NOT REGEXP_LIKE(Email, ‘[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}’, ‘i’);

--Q28. Write a query to retrieve Departments who have less than 2 employees working in it.
SELECT DEPARTMENT, COUNT(EmpID) as 'EmpNo' FROM EmployeeInfo GROUP BY DEPARTMENT HAVING COUNT(EmpD) < 2;

--Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them.
SELECT EmpPosition, SUM(Salary) from EmployeePosition GROUP BY EmpPosition;

--Q30. Write a query to fetch 50% records from the EmployeeInfo table.
SELECT * 
FROM EmployeeInfo WHERE
EmpID <= (SELECT COUNT(EmpID)/2 from EmployeeInfo);