use Northwind

insert into Products_New
select p.ProductID, p.ProductName, cu.CompanyName, c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as Fecha
from Products as p 
inner join Categories as c
on  p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID


--Crear una tabla a partir de una consulta

select p.ProductID, p.ProductName, cu.CompanyName, c.CategoryName, od.UnitPrice,
p.Discontinued, GETDATE() as [Inserted_date]
into Products_New
from Products as p 
inner join Categories as c
on  p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID

--Crear una tabla solo las columnas

select top 0 p.ProductID, p.ProductName, cu.CompanyName, c.CategoryName, od.UnitPrice,
p.Discontinued, GETDATE() as [Inserted_date]
into Products_New
from Products as p 
inner join Categories as c
on  p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID

--Con alias y agregando la PK
select top 0 0 as [Productbk], p.ProductID, p.ProductName as [Product], cu.CompanyName as [Customer], c.CategoryName as [Category],
od.UnitPrice, p.Discontinued, GETDATE() as [Inserted_date]
into Products_New
from Products as p 
inner join Categories as c
on  p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID

-- Carga Full

insert into products_new
select 0 as [bkproduct], p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE()
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

alter table products_new
add constraint pk_products_new
primary key (productbk) 

-- Crear la tabla mediante consulta y se agrega el campo identidad y clave primaria despues

select top 0 p.ProductID, p.ProductName as [producto]
,[cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID


alter table products_new
add productbk int not null identity(1,1)

alter table products_new
add constraint pk_products_new
primary key (productbk)
Go

-- Carga Full
insert into products_new (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date' 
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID


select pn.ProductID, pn.Producto, pn.Customer, pn.Category, pn.UnitPrice, pn.Discontinued, pn.Inserted_date,
p.ProductID, p.ProductName
from Products as p
inner join Products_New as pn
on p.ProductID = pn.ProductID
where ProductName = 'elote feliz'

select pn.ProductID, pn.Producto, pn.Customer, pn.Category, pn.UnitPrice, pn.Discontinued, pn.Inserted_date,
p.ProductID, p.ProductName
from Products as p
left join Products_New as pn
on p.ProductID = pn.ProductID
where p.ProductID is not null

--carga delta

--1
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date' , pn.ProductID
from Products as p 
left join 
Categories as c 
on p.CategoryID = c.CategoryID
left join [Order Details] as od
on od.ProductID = p.ProductID
left join Orders as o
on o.OrderID = od.OrderID
left join Customers as [cu]
on [cu].CustomerID = o.CustomerID
left join Products_New as pn
on pn.ProductID = p.ProductID

--2
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date' , pn.ProductID
from Products as p 
left join 
Categories as c 
on p.CategoryID = c.CategoryID
left join [Order Details] as od
on od.ProductID = p.ProductID
left join Orders as o
on o.OrderID = od.OrderID
left join Customers as [cu]
on [cu].CustomerID = o.CustomerID
left join Products_New as pn
on pn.ProductID = p.ProductID
where pn.ProductID is null

select * from Products_New as pn
where pn.producto in  ('Garacha Sabrosona' , 'Elote Feliz')



select top 10 * 
into products2
from Products

select * from Products
select * from products2

select *
from Products as p1
inner join products2 as p2
on p1.ProductID = p2.ProductID

select *
from Products as p1
left join products2 as p2
on p1.ProductID = p2.ProductID

select *
from Products as p1
Right join products2 as p2
on p1.ProductID = p2.ProductID

--carga full
select * from Products_New

--Borrar tabla
drop table Products_New