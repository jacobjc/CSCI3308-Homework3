--Jacob Christiansen CSCI3308--
--Question 1--
select * from employees where Country!='USA' and HireDate<CURRENT_TIMESTAMP-interval'5 years' order by FirstName, LastName;
--Question 2--
select ProductID, ProductName, UnitsInStock, UnitPrice from products where UnitsInStock<=ReorderLevel and UnitsInStock>=1;
--Question 3--
select ProductName, UnitPrice from products where UnitPrice=(select MIN(UnitPrice) from products) or UnitPrice=(select MAX(UnitPrice) from products);
--Question 4--
select ProductID, ProductName, UnitsInStock*UnitPrice AS "Total Inventory Value" from products where UnitsInStock*UnitPrice>1000 order by "Total Inventory Value" DESC;
--Question 5--
select distinct ShipCountry, COUNT(OrderID) from orders where EXTRACT(YEAR from ShippedDate)='2013' and EXTRACT(MONTH from ShippedDate)='10' and ShipCountry!='Germany' group by ShipCountry order by ShipCountry DESC;
--Question 6--
select CustomerID, ShipName from orders group by CustomerID, ShipName having COUNT(CustomerID)>=10;
--Question 7--
select SupplierID, SUM(UnitsInStock*UnitPrice) as "Value of Inventory" from products group by SupplierId having COUNT(SupplierID)>=5;
--Question 8--
select suppliers.CompanyName, products.ProductName, products.UnitPrice from suppliers inner join products on suppliers.SupplierID=products.SupplierId where Country='USA' or Country='Germany' order by UnitPrice DESC; 
--Question 9--
select employees.LastName, employees.FirstName, employees.Title, employees.Extension, COUNT(orders.EmployeeID) from employees inner join orders on employees.EmployeeID=orders.EmployeeID group by LastName, FirstName, Title, Extension having COUNT(orders.EmployeeID)>50 order by LastName;
--Question 10--
select customers.CustomerID, customers.CompanyName from customers where customerid NOT IN(select customerid from orders);
--Question 11--
select suppliers.CompanyName, suppliers.ContactName, categories.CategoryName, categories.Description, products.ProductName, products.UnitsOnOrder from suppliers inner join products on suppliers.SupplierID=products.SupplierID inner join categories on products.CategoryID=categories.CategoryID where UnitsInStock=0;
--Question 12--
select products.ProductName, suppliers.CompanyName, suppliers.country, products.UnitsInStock from products inner join suppliers on products.SupplierId=suppliers.SupplierID where products.QuantityPerUnit like '%bags%' or products.QuantityPerUnit like '%bottles%';
--Question 13--
create table Top_Items(ItemID int not null, ItemCode int not null, ItemName varchar(40) not null, InventoryDate timestamp not null, SupplierID int not null, ItemQuantity int not null, ItemPrice decimal(9,2) not null, PRIMARY KEY (ItemID));
--Question 14--
insert into Top_Items (ItemID, ItemCode, ItemName, InventoryDate, ItemQuantity, ItemPrice, SupplierID) select ProductID, CategoryID, ProductName, CURRENT_DATE, UnitsInStock, UnitPrice, SupplierID from products where UnitsInStock*UnitPrice>1500;
--Question 15--
delete from Top_Items where SupplierID=any(select suppliers.SupplierID from suppliers inner join Top_Items on suppliers.SupplierID=Top_Items.SupplierID where suppliers.Country='USA' or suppliers.Country='Canada');
--Question 16--
alter table Top_Items add InventoryValue decimal(9,2);
--Question 17--
update Top_Items set InventoryValue=ItemPrice*ItemQuantity;
--Question 18--
drop table Top_Items;

