-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)

-- Step 1: Create the ProductDetail_1NF table.
-- Each row will contain only one product per order.

CREATE TABLE ProductDetail_1NF (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

-- Step 2: Insert normalized records.
-- Each product is stored in a separate row.

INSERT INTO ProductDetail_1NF
    (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Step 3: Display the normalized table.

SELECT * FROM ProductDetail_1NF;


-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)


-- Partial dependency:
-- CustomerName depends only on OrderID,
-- not on the complete composite key (OrderID, Product).
--
-- To achieve 2NF, separate order information
-- from product and quantity information.

-- Step 1: Create the Orders table.
-- OrderID is the primary key.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 2: Create the OrderItems table.
-- The combination of OrderID and Product
-- forms the composite primary key.
-- OrderID is also a foreign key referencing Orders.

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert unique order records into Orders.

INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 4: Insert product and quantity records
-- into the OrderItems table.

INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- Step 5: Display the Orders table.

SELECT * FROM Orders;

-- Step 6: Display the OrderItems table.

SELECT * FROM OrderItems;

-- Step 7: Use INNER JOIN to display complete order details.

SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
INNER JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
ORDER BY Orders.OrderID, OrderItems.Product


