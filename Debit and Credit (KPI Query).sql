# 1 - Total Credit Amount

SELECT
    CONCAT(ROUND(SUM(Credit_Amount) / 1000000, 2),'M') AS credit_amount
FROM Bank_Debit_Credit;

------------------------------------------------------------------------------------------------------------------------------------
# 2 - Total Debit Amount

SELECT
    CONCAT(ROUND(SUM(Debit_Amount) / 1000000, 2),'M') AS debit_amount
FROM Bank_Debit_Credit;

-------------------------------------------------------------------------------------------------------------------------------------
# 3 - Credit to Debit Ratio

SELECT 
    ROUND( SUM(Credit_Amount) /
    NULLIF(SUM(Debit_Amount),0), 4 ) AS Credit_Debit_Ratio
FROM Bank_Debit_Credit;

------------------------------------------------------------------------------------------------------------------
# 4 - Net Transaction Amount

SELECT
	CONCAT(
	ROUND((SUM(Credit_Amount) - SUM(Debit_Amount)) / 1000000, 2),
	' M')
AS Net_transaction_amount
FROM Bank_Debit_Credit;

----------------------------------------------------------------------------------------------------------------
# 5 - Account Activity Ratio

SELECT
    ROUND(COUNT(*) * 1.0 / NULLIF(AVG(Balance), 0), 4) AS Account_Activity_ratio
FROM Bank_Debit_Credit;

-------------------------------------------------------------------------------------------------------------
# 6 - Transactions per Day/ Week/ Month

SELECT 
    'DAY' AS period_type,
    DATE(Transaction_Date) AS period,
    COUNT(*) AS transaction_count
FROM Bank_Debit_Credit
GROUP BY 
	DATE(Transaction_Date)

UNION ALL

SELECT 
    'WEEK' AS period_type,
    CONCAT(YEAR(Transaction_Date), '-W', WEEK(Transaction_Date)) AS period,
    COUNT(*) AS transaction_count
FROM Bank_Debit_Credit
GROUP BY 
    CONCAT(YEAR(Transaction_Date), '-W', WEEK(Transaction_Date))

UNION ALL

SELECT 
    'MONTH' AS period_type,
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS period,
    COUNT(*) AS transaction_count
FROM Bank_Debit_Credit
GROUP BY
    DATE_FORMAT(Transaction_Date, '%Y-%m');

-------------------------------------------------------------------------------------------------------------------------------
# 7 - Total Transaction by Branch

SELECT
    COALESCE(Branch, 'Grand Total') AS Branch,
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS total_transaction_amount
FROM Bank_Debit_Credit
GROUP BY Branch WITH ROLLUP;

----------------------------------------------------------------------------------------------------------------------------------
# 8 - Transaction Volume by Bank

SELECT
    COALESCE(Bank_Name, 'Grand Total') AS Bank_Name,
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS transaction_volume
FROM Bank_Debit_Credit
GROUP BY Bank_Name WITH ROLLUP;

-------------------------------------------------------------------------------------------------------------------------------------
# 9 - Transaction Method Distribution

SELECT
    COALESCE(Transaction_Method, 'Grand Total') AS Transaction_Method,
    CONCAT(
        ROUND(
            COUNT(*) * 100.0 /
            (SELECT COUNT(*) FROM Bank_Debit_Credit),
            2),'%') AS Transaction_Count
FROM Bank_Debit_Credit
GROUP BY Transaction_Method WITH ROLLUP;

----------------------------------------------------------------------------------------------------------------------------------
# 10 - Branch Transaction Growth 

SELECT
    COALESCE(Branch, 'Grand Total') AS Branch,
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS total_amount
FROM Bank_Debit_Credit
GROUP BY Branch WITH ROLLUP;

----------------------------------------------------------------------------------------------------------------------------------
# 11 - High Risk Transactions

SELECT
    'High Risk' AS risk_flag,
    COUNT(High_Risk_Flag) AS Count_Flag
FROM Bank_Debit_Credit
WHERE Amount > 4000;

-------------------------------------------------------------------------------------------------------------------------------------
# 12 - Suspicious Transaction Frequency

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month_year,
    COUNT(*) AS suspicious_count
FROM Bank_Debit_Credit
WHERE amount >= 4000
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m');

---------------------------------------------------------------------------------------------------------------------------------------


