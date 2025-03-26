#VIEWS
Sintaxis para crear una view
/*create view nombreVista
AS
select columnas
from tabla

where codicion*/

```sql
--VIEWS

Use Northwind
Go

--Crear view
create view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], picture 
from categories;
go
--mandar a llamar view
select * from VistaCategoriasTodas
where CategoryName = 'Beverages'

--Eliminar view
drop view VistaCategoriasTodas

--Create alter
create or alter view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], picture 
from categories;
where CategoryName = 'Beverages'
Go


--crear una vista que permita visualizar solamente a los clientes de mexico y brazil

create view VistaLatinos
As
select * from Customers
where Country = 'Mexico' and Country = 'Brazil';
Go

create  or alter view VistaLatinos
As
select * from Customers
where Country in ('Mexico', 'Brazil')
Go

select CompanyName as [cliente],
City as [ciudad], Country as [pa�s]
from VistaLatinos
where City = 'Sao Paulo'
order by 2 desc

select distinct * from
Orders as o
inner join VistaLatinos as vl
on vl.CustomerID = o.CustomerID


--Crear una vista que contenga los datos de todas las ordenes, los productos

create or alter view [dbo].[VistaOrdenesCompra]
as
select o.OrderID as [Numero de orden], o.OrderDate as [Fecha de orden], o.RequiredDate as [Fechad e requisicion], 
concat(e.FirstName,' ', e.LastName) as [Nombre empleado], cu.CompanyName as [Nombre del cliente], p.ProductName as [Nombre del producto], 
c.CategoryName as [Nombre de la categoria],od.UnitPrice as [Precio de venta], od.Quantity as [Cantidad vendida], 
(od.Quantity * od.UnitPrice) as [importe]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID=p.ProductID
inner join Orders as o
on od.OrderID =o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID


select count(distinct [Numero de orden]) as [Numero de orden]
from VistaOrdenesCompra

select sum([Cantidad vendida] * [Precio de venta]) as [Importe total]
from VistaOrdenesCompra

select sum([importe]) as [importe total]
from VistaOrdenesCompra
where year([Fecha de orden]) between '1995' and '1996'
Go

create or alter view vista_orddenes_1995_1996
as
select [Nombre del cliente], sum([importe]) as [importe total]
from VistaOrdenesCompra
where year([Fecha de orden]) between '1995' and '1996'
group by [Nombre del cliente]
having count(*)>2
Go



create schema rh

create table rh.tablarh (
	id int primary key,
	nombre nvarchar(50)
)

--Vista horizontal
Create or alter view rh.viewcategoriasproductos
as
select c.CategoryID, CategoryName, p.ProductID, p.ProductName
from Categories as c
inner join Products as p
on c.CategoryID=p.CategoryID;
Go

select * from rh.viewcategoriasproductos
```