CREATE DATABASE bootcampdb;
USE bootcampdb;

-- Year-wise loan amount statistic

SELECT 
  CONCAT('20', RIGHT(issue_d, 2)) AS loan_year,
  SUM(loan_amnt) AS total_loan_amount
FROM 
  finance_1
GROUP BY 
  loan_year
ORDER BY 
  loan_year;
  
  
  
  
  
  -- Grade and Subgrade wise Revolving Balance
  
  
  USE bootcampdb;
SELECT 
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS total_revol_bal
FROM 
    finance_1 AS f1
JOIN 
    finance_2 AS f2
    ON f1.id = f2.ï»¿id  
GROUP BY 
    f1.grade, f1.sub_grade
ORDER BY 
    f1.grade, f1.sub_grade;
    
    
    
    
    
    -- TOTAL PAYMENT FOR VERIFIED STATUS VS TOTAL PAYMENT FOR NON - VERIFIED STATUS
    
    
    USE bootcampdb;
    SELECT 
    f1.verification_status,
    SUM(f2.total_pymnt) AS total_payment
FROM 
    finance_1 AS f1
JOIN 
    finance_2 AS f2
    ON f1.id = f2.ï»¿id  
GROUP BY 
    f1.verification_status;
    




-- STATE WISE MONTH WISE LOAN STATUS

SELECT 
    addr_state AS state,
    DATE_FORMAT(
        STR_TO_DATE(
            CONCAT(
                '20', RIGHT(issue_d, 2), '-',
                CASE 
                    WHEN LEFT(issue_d, 3) = 'Jan' THEN '01'
                    WHEN LEFT(issue_d, 3) = 'Feb' THEN '02'
                    WHEN LEFT(issue_d, 3) = 'Mar' THEN '03'
                    WHEN LEFT(issue_d, 3) = 'Apr' THEN '04'
                    WHEN LEFT(issue_d, 3) = 'May' THEN '05'
                    WHEN LEFT(issue_d, 3) = 'Jun' THEN '06'
                    WHEN LEFT(issue_d, 3) = 'Jul' THEN '07'
                    WHEN LEFT(issue_d, 3) = 'Aug' THEN '08'
                    WHEN LEFT(issue_d, 3) = 'Sep' THEN '09'
                    WHEN LEFT(issue_d, 3) = 'Oct' THEN '10'
                    WHEN LEFT(issue_d, 3) = 'Nov' THEN '11'
                    WHEN LEFT(issue_d, 3) = 'Dec' THEN '12'
                    ELSE NULL
                END,
                '-01'
            ), '%Y-%m-%d'
        ), '%Y-%m'
    ) AS loan_month,
    loan_status,
    COUNT(*) AS total_loans
FROM 
    finance_1
WHERE 
    issue_d IS NOT NULL AND issue_d != ''
GROUP BY 
    state, loan_month, loan_status
ORDER BY 
    state, loan_month;
    
    
    
    
    
    -- Homeownership vs Last Payment Date Stats


SELECT 
    f1.home_ownership,
    f2.last_pymnt_d
FROM finance_1 f1
JOIN finance_2 f2 ON f1.id = f2.ï»¿id
WHERE f2.last_pymnt_d IS NOT NULL
ORDER BY f1.home_ownership, f2.last_pymnt_d;