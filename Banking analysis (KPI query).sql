#Total Clients
SELECT COUNT(DISTINCT Client_id) AS Total_Clients
FROM final_fact;

#Active Clients
SELECT COUNT(DISTINCT Client_id) AS Active_Clients
FROM final_fact
WHERE Loan_Status = 'Active';

#Total Repayments Collected
SELECT 
CONCAT(ROUND(SUM(Total_Pymnt) / 1000000, 2),' M')
AS Total_Repayments_Collected
FROM final_fact;


#5. Total Funded Amount
SELECT CONCAT(ROUND(SUM(Funded_Amount) / 1000000, 2),' M') 
AS Total_Funded_Amount
FROM final_fact;

#13. On-Time Repayment %
SELECT 
ROUND(
    SUM(CASE 
        WHEN Repayment_Behavior LIKE '%On-Time%' THEN 1 
        ELSE 0 
    END) * 100.0 / COUNT(*),
    2
) AS On_Time_Repayment
FROM final_fact;
# 11. Default Rate
SELECT 
  ROUND(
    SUM(CASE WHEN Is_Default_Loan = 'Y' THEN 1 ELSE 0 END) 
    / COUNT(*) * 100, 2
  ) AS Default_Rate
FROM final_fact;

# 9. Principal Recovery Rate
SELECT 
  ROUND(SUM(Total_Rec_Prncp) / SUM(Loan_Amount) * 100, 2) 
  AS Principal_Recovery_Rate
FROM final_fact;

# 10. Interest Income in Millions
SELECT 
CONCAT(
ROUND(SUM(Total_Rrec_int) / 1000000, 2),
' M'
) AS Interest_Income
FROM final_fact;

# 6. Average Loan Size
SELECT ROUND(AVG(Loan_Amount/1000), 2) AS Average_Loan_Size
FROM final_fact;
  
  # 14. Loan Distribution by Branch
SELECT 
  Branch_Name_x AS Branch_Name,
  SUM(Loan_Amount) AS Total_Loan_Amount
FROM final_fact
GROUP BY Branch_Name_x
ORDER BY Total_Loan_Amount DESC;

 -- Start Transaction
START TRANSACTION;
 # 15. Branch Performance Category Split using ROLLUP
SELECT 
IFNULL(Branch_Performance_Category, 'Grand Total') 
AS Branch_Performance_Category,

COUNT(*) AS Loan_Count,

CONCAT(
ROUND(SUM(Loan_Amount) / 1000000, 2),
' M'
) AS Total_Loan_Amount

FROM final_fact
GROUP BY Branch_Performance_Category WITH ROLLUP;


 # 7. Loan Growth % Year Wise
SELECT 
YEAR(Disbursement_Date) AS Loan_Year,
  SUM(Loan_Amount) AS This_Year_Loan_Amount,
  LAG(SUM(Loan_Amount)) OVER (ORDER BY YEAR(Disbursement_Date)) AS Previous_Year_Loan_Amount,
  ROUND(
    (SUM(Loan_Amount) - LAG(SUM(Loan_Amount)) OVER (ORDER BY YEAR(Disbursement_Date)))
    / LAG(SUM(Loan_Amount)) OVER (ORDER BY YEAR(Disbursement_Date)) * 100, 2
  ) AS Loan_Growth_Percentage
FROM final_fact
GROUP BY YEAR(Disbursement_Date)
ORDER BY Loan_Year;



  # 10. Interest Income in Millions
SELECT 
CONCAT(
ROUND(SUM(Total_Rrec_int) / 1000000, 2),
' M'
) AS Interest_Income
FROM final_fact;
