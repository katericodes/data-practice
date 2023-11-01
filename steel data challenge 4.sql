-- 1. What are the names of all the customers who live in New York?
-- Assuming question is asking about the City "New York" and not the State "NY"
SELECT CONCAT(FirstName, " ", LastName) AS customer_name
FROM Customers
WHERE City = "New York";
/*
| customer_name |
| ------------- |
| John Doe      |
| Jane Doe      |
*/

-- 2. What is the total number of accounts in the Accounts table?
SELECT count(*) AS total_accounts
FROM Accounts;
-- 15 accounts

-- 3. What is the total balance of all checking accounts?
SELECT sum(Balance) AS total_balance
FROM Accounts
WHERE AccountType = 'Checking';
-- The total balance is $31,000.00

-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?
SELECT sum(Balance) AS total_balance
FROM Accounts a
JOIN Customers c
ON a.customerID = c.customerID
WHERE City = 'Los Angeles';
-- The total balance is $75,000.00

-- 5. Which branch has the highest average account balance?
SELECT branchName, avg(Balance) AS average_balance
FROM Accounts a
JOIN Branches b
ON a.branchID = b.branchID
GROUP By b.branchID, branchName
ORDER By average_balance desc;
-- North Beach has the highest average account balance with an average of $30,000.00.

-- 6. Which customer has the highest current balance in their accounts?
-- what does 'current' balance mean?? currently interpretting it as total balance but doesn't seem right

SELECT c.FirstName, c.LastName, sum(Balance) AS total_balance
FROM Accounts a
JOIN Customers c
ON a.customerID = c.customerID
GROUP By c.customerID, FirstName,LastName
ORDER By total_balance desc;
-- Michael Lee has the highest current balance at $60,000.00

-- 7. Which customer has made the most transactions in the Transactions table?
WITH customer_names AS ( -- pairs the account id with the customer name
  SELECT a.AccountID, FirstName, LastName
  FROM Accounts a
  JOIN Customers c
  ON a.CustomerID = c.CustomerID
)
  SELECT FirstName, LastName, count(*) AS total_transactions
  FROM customer_names
  JOIN Transactions
  ON customer_names.accountID = Transactions.accountID
  GROUP BY FirstName, LastName
  ORDER BY total_transactions desc;

  -- Jane Doe and Alice Johnsons tie for the most transaction, with each person having 4 transactions.

  /* need to check answer
    | FirstName | LastName | total_transactions |
    | --------- | -------- | ------------------ |
    | Jane      | Doe      | 4                  |
    | Alice     | Johnson  | 4                  |
    | John      | Doe      | 3                  |
    | Bob       | Smith    | 3                  |
    | Michael   | Lee      | 1                  |
  */

-- 8.Which branch has the highest total balance across all of its accounts?

-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?

-- 10. Which branch has the highest number of transactions in the Transactions table?