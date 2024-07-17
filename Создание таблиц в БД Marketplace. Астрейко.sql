
--1) Создала БД Marketplace. В ней создала 3 схемы:
--Production (таблицы Product, Category, Subcategory)
--SupplyChain (таблица Supplier)
--Sales (таблицы Revenue, Customer, PickupPoint, OrderDetail, DeliveryDetail)

--2) Написала запросы по созданию таблиц (но не ранала еще, жду ОС от тебя:)

--3) Обновила схему БД актуальными названиями и типами данных

--4) Подгрузила все в гит в ветку Diploma


CREATE TABLE Sales.OrderDetail
(
OrderID INT PRIMARY KEY,
OrderDate DATETIME NOT NULL,
OrderedItems INT NOT NULL
);

CREATE TABLE Sales.DeliveryDetail
(
DeliveryID INT PRIMARY KEY,
DeliveryDate DATETIME NOT NULL,
DeliveredItems INT NOT NULL
);

CREATE TABLE Production.Category
(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR (50) NOT NULL
);

CREATE TABLE Production.Subcategory
(
SubcategoryID INT PRIMARY KEY,
SubcategoryName VARCHAR (100) NOT NULL,
CategoryID INT FOREIGN KEY (CategoryID) REFERENCES Production.Category (CategoryID) NOT NULL
);

CREATE TABLE SupplyChain.Supplier
(
SupplierID INT PRIMARY KEY,
CompanyName VARCHAR (50) UNIQUE,
BrandName VARCHAR (50) DEFAULT 'n.d'
);

CREATE TABLE Production.Product
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR (100) NOT NULL,
Price DECIMAL (18,2) DEFAULT 1,
Promo BIT NOT NULL,
SubcategoryID INT FOREIGN KEY (SubcategoryID) REFERENCES Production.Subcategory (SubCategoryID) NOT NULL,
SupplierID INT FOREIGN KEY (SupplierID) REFERENCES SupplyChain.Supplier (SupplierID) NOT NULL
);

CREATE TABLE Sales.PickupPoint
(
PickupPointID INT PRIMARY KEY,
PickupPointNumber SMALLINT UNIQUE, 
City VARCHAR (25) NOT NULL,
FullAddress VARCHAR (100) NOT NULL,
);

CREATE TABLE Sales.Customer
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR (25) NOT NULL,
CustomerSurname VARCHAR (25) NOT NULL,
FullName AS CONCAT(CustomerName,' ',CustomerSurname), --нужно ли тут указывать тип данных?
BirthDate DATETIME NOT NULL,
Age AS GETDATE()-BirthDate, -- вот тут не уверена, как будто так нельзя :)) и нужно ли тут указывать тип данных?
Gender VARCHAR(2),
PhoneNumber TINYINT,
City VARCHAR (25),
Activity BIT NOT NULL,
PickupPointID INT FOREIGN KEY (PickupPointID) REFERENCES Sales.PickupPoint (PickupPointID)
);


CREATE TABLE Sales.Revenue
(
OrderID INT FOREIGN KEY (OrderID) REFERENCES Sales.OrderDetail (OrderID) NOT NULL,
ProductID INT FOREIGN KEY (ProductID) REFERENCES Production.Product (ProductID) NOT NULL,
DeliveryID INT FOREIGN KEY (DeliveryID) REFERENCES Sales.DeliveryDetail (DeliveryID) NOT NULL,
CustomerID INT FOREIGN KEY (CustomerID) REFERENCES Sales.Customer (CustomerID) NOT NULL,
Revenue DECIMAL (18,2),
Quantity INT CHECK(Quantity>=0) NOT NULL,
Discount DECIMAL(4,2) DEFAULT 0,
RevenueDate DATETIME NOT NULL
);