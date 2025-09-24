-- 0924
-- < > --
USE exdb;
SHOW TABLES;

SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM shippers;
SELECT * FROM employees;
-- inner join 테이블2개
SELECT o.OrderID, c.CustomerID, c.CustomerName 고객이름, o.OrderDate
FROM orders AS o
INNER JOIN customers AS c
	ON o.CustomerID = c.CustomerID;
	
-- inner join 테이블 3개 -- 
SELECT
 o.OrderID, c.CustomerID, c.CustomerName, s.ShipperID, s.ShipperName
FROM orders AS o
INNER JOIN customers AS c
	ON o.CustomerID = c.CustomerID
INNER JOIN shippers AS s
	ON o.ShipperID = s.ShipperID;
	
-- left join 테이블 2개--
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM customers  c
LEFT JOIN orders AS o
	ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID;

-- right join 테이블 2개--
SELECT o.OrderID, e.EmployeeID, e.FirstName FROM orders o
RIGHT JOIN employees e
	ON o.EmployeeID = e.EmployeeID
ORDER BY o.EmployeeID;

SELECT * FROM orders;
SELECT * FROM customers;

-- cross join 테이블2개--
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM customers c 
CROSS JOIN orders o
WHERE c.CustomerID = o.CustomerID;

-- self join 테이블 1개--
SELECT c1.CustomerID, c1.CustomerName AS c1고객이름 , c1.City AS c1도시,
 			c2.CustomerID, c2.CustomerName AS c2고객이름, c2.City AS c2도시
FROM customers c1, customers c2
WHERE c1.CustomerID <> c2.CustomerID
AND c1.City = c2.City
ORDER BY c1.City;

-- union
SELECT * FROM customers;
SELECT * FROM suppliers;

SELECT City FROM customers
UNION
SELECT City FROM suppliers
ORDER BY City;

SELECT City, Country FROM customers
WHERE Country = 'Germany'
UNION
SELECT City, Country FROM suppliers
WHERE Country = 'Germany'
ORDER BY City;

SELECT 'Customer' AS TYPE, contactName, City, Country
FROM customers
union
SELECT 'Supplier', ContactName, City, Country
FROM suppliers;

-- group by 예습
SELECT * FROM customers;

-- customers 필드의 값을 country별로 묶고, 각 country에 몇개의 customerID가잇는지 count하는듯
SELECT COUNT(customerID), country
FROM customers
GROUP BY Country;

-- 똑같이 country로 묶고, 각 customerID를 내림차순으로 정렬
SELECT COUNT(CustomerID), country
FROM customers
GROUP BY country
ORDER BY COUNT(CustomerID) DESC;

-- join을 사용한 group by
SELECT * FROM orders;
SELECT * FROM shippers;
-- orders와 shippers를 leftjoin후, shippers에있는 shipperName별로 분류하고,
-- orders에 있는 OrderID를 카운트함 --> 각 운송 업체가 보낸 주문 수 나열
SELECT shippers.ShipperName, COUNT(orders.OrderID) AS NumberOfOrders FROM orders
LEFT JOIN shippers ON orders.ShipperID = shippers.ShipperID
GROUP BY shippername;

-- having 각 국가의 고객 수 나열 , 고객이 5명 이상인 국가만 포함.
SELECT * FROM customers;

SELECT COUNT(CustomerID), Country FROM customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

-- 10개 이상의 주문을 등록한 직원을 나열
SELECT * FROM employees;
SELECT * FROM orders;
SELECT COUNT(OrderID) FROM orders;


-- orders의 orderID와 employees의 lastname을 교집합,  
SELECT employees.LastName, COUNT(orders.OrderID) AS 주문수 
FROM orders
INNER JOIN employees ON orders.EmployeeID = employees.EmployeeID
-- lasename별로 그룹을 만들기 
GROUP BY lastname
-- 주문수가 10보다 큰애들 나와
HAVING COUNT(orders.OrderID) > 10
-- 주문수별로 정렬
ORDER BY 주문수;

-- 'Davolio' 또는 'Fuller'가 25개 이상의 주문을 등록했는지 여부 나열----
SELECT employees.LastName, count(orders.OrderID) AS 주문수
FROM orders
INNER JOIN employees ON orders.EmployeeID = employees.EmployeeID
-- --- 여기까지 출력했을때 Buchan 830 한줄만 나오는 이유= 오류
-- select count(orderID)from orders; 했을때 한줄만 나오기때문에 다 담지못하는 오류임
-- groupby문을 쓰면 원하는대로 출력됨
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(orders.OrderID) > 25;

