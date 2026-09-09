truncate final_fact;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BANK/final_fact.csv' into table final_fact
FIELDS TERMINATED by ','
optionally  enclosed by '"'
lines terminated by '\n'
IGNORE 1 rows;
alter table final_fact rename column ï»¿Account_ID to Account_ID;
