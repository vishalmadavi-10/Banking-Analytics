CREATE DATABASE Bank_Data;
USE Bank_Data;

CREATE TABLE Raw_Bank_Data(
	Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer VARCHAR(50),
    Account_No VARCHAR(50),
    Transaction_Date DATE,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(10,2),
    Balance DECIMAL(10,2),
    Description VARCHAR(50),
    Branch VARCHAR(50),
    Transaction_Method VARCHAR(50),
    Currency Varchar(10),
    Bank_Name VARCHAR(50)
);

SELECT * FROM Raw_Bank_Data;

SELECT COUNT(*) FROM Raw_Bank_Data;

ALTER TABLE Raw_Bank_Data RENAME TO bank_debit_credit;

ALTER TABLE Raw_Bank_Data
ADD Credit_Amount DECIMAL(10,2)
GENERATED ALWAYS AS (
	CASE
		WHEN Transaction_Type = 'Credit' THEN Amount
        ELSE 0
	END
) STORED;

ALTER TABLE Raw_Bank_Data
ADD Debit_Amount DECIMAL(10,2)
GENERATED ALWAYS AS (
	CASE
		WHEN Transaction_Type = 'Debit' THEN Amount
        ELSE 0
	END
) STORED;

ALTER TABLE Raw_Bank_Data
ADD High_Risk_Flag VARCHAR(50)
GENERATED ALWAYS AS(
	CASE
		WHEN Amount > 4000 THEN "High_Risk"
        ElSE "Normal"
	END
) STORED;

















