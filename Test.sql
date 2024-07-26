WINDOW FUNCTIONS QUESTIONS ......

### Question 1: Calculate the running total of `TotalAmount` for each order placed by each customer.
```sql
SELECT 
    CustomerID, 
    OrderID, 
    OrderDate, 
    TotalAmount, 
    SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM Orders;
```

### Question 2: Determine the rank of each product within its category based on price.
```sql
SELECT 
    ProductID, 
    ProductName, 
    CategoryID, 
    Price, 
    RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS PriceRank
FROM Products;
```

### Question 3: Find the average `TotalAmount` of orders for each customer and the difference of each order's `TotalAmount` from the customer's average.
```sql
SELECT 
    CustomerID, 
    OrderID, 
    TotalAmount, 
    AVG(TotalAmount) OVER (PARTITION BY CustomerID) AS AvgTotalAmount, 
    TotalAmount - AVG(TotalAmount) OVER (PARTITION BY CustomerID) AS DifferenceFromAvg
FROM Orders;
```

### Question 4: Calculate the cumulative quantity of each product sold across all orders.
```sql
SELECT 
    ProductID, 
    SUM(Quantity) AS TotalQuantitySold, 
    SUM(SUM(Quantity)) OVER (ORDER BY ProductID) AS CumulativeQuantitySold
FROM OrderItems
GROUP BY ProductID
ORDER BY ProductID;
```

### Question 5: Identify the most recent order date for each customer.
```sql
SELECT 
    CustomerID, 
    OrderID, 
    OrderDate, 
    MAX(OrderDate) OVER (PARTITION BY CustomerID) AS MostRecentOrderDate
FROM Orders;
```

### Question 6: Calculate the percentage contribution of each product's price to the total price of all products within the same category.
```sql
SELECT 
    ProductID, 
    ProductName, 
    CategoryID, 
    Price, 
    Price / SUM(Price) OVER (PARTITION BY CategoryID) * 100 AS PricePercentage
FROM Products;
```

### Question 7: Find the first order date and last order date for each customer.
```sql
SELECT 
    CustomerID, 
    OrderID, 
    OrderDate, 
    MIN(OrderDate) OVER (PARTITION BY CustomerID) AS FirstOrderDate, 
    MAX(OrderDate) OVER (PARTITION BY CustomerID) AS LastOrderDate
FROM Orders;
```

### Question 8: Calculate the difference in days between consecutive orders for each customer.
```sql
SELECT 
    CustomerID, 
    OrderID, 
    OrderDate, 
    LAG(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderDate, 
    DATEDIFF(OrderDate, LAG(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysBetweenOrders
FROM Orders;
```
