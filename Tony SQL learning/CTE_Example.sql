
WITH CTE_EXAMPLE AS (
SELECT clients.client_ID, clients.Name, sum(payments.amount) as TotalAmount
FROM clients
INNER JOIN payments
	ON clients.client_ID = payments.client_ID
GROUP BY clients.client_ID, clients.Name
)
SELECT *
FROM CTE_EXAMPLE
ORDER BY Totalamount desc;

Select * 
FROM clients;

SELECT * 
FROM payments;