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
-- current balance is interpreted as the highest amount in any of their accounts separately

SELECT c.FirstName, c.LastName, max(Balance) AS highest_balance
FROM Accounts a
JOIN Customers c
ON a.customerID = c.customerID
GROUP By c.customerID, FirstName,LastName
ORDER By highest_balance desc;
-- Michael Lee has the highest current balance with an account at $50,000.00

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
-- Jane Doe and Alice Johnson tie for the most transactions, with each person having 4 transactions.

-- 8.Which branch has the highest total balance across all of its accounts?
SELECT b.BranchName, sum(a.Balance) AS total_balance
FROM Branches b
JOIN Accounts a
ON a.BranchID = b.BranchID
GROUP By b.BranchName
ORDER By total_balance desc;
-- North Beach is the branch with the highest total, at $60,000.00

-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT c.FirstName, c.LastName, sum(Balance) AS total_balance
FROM Accounts a
JOIN Customers c
ON a.customerID = c.customerID
WHERE a.AccountType in ("Checking", "Savings")
GROUP By c.customerID, FirstName,LastName
ORDER By total_balance desc;
-- Michael Lee has the highest total balance at $60,000.00.

-- 10. Which branch has the highest number of transactions in the Transactions table?
WITH branch_names AS ( -- connect account ID to branch name)
  SELECT a.accountID, a.BranchID, b.BranchName
  FROM Accounts a
  JOIN Branches b
  ON a.BranchID = b.BranchID
  ORDER BY a.accountID
)
SELECT b.BranchName, count(*) as total_transactions
FROM Transactions T
JOIN branch_names b
ON b.accountID = T.accountID
GROUP BY b.BranchName
Order BY total_transactions desc;
-- 'Main' branch and 'South Bay' branch were tied with the most total transactions, at 4 transactions each.
