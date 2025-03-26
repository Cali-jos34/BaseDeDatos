```sql
use Northwind;
--joins

select * from
Categories
inner join 
Products
on Categories.CategoryID = Products.CategoryID;

select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from
Categories
inner join 
Products
on Categories.CategoryID = Products.CategoryID;

select C.CategoryID as [Numero de categoria], CategoryName as [Nombre categoria], ProductName as [Nombre del producto],
UnitsInStock as 'Existencia', UnitPrice as 'Precio' from
Categories as C
inner join 
Products as P
on C.CategoryID = P.CategoryID;


select * from Products;
select * from Categories;

--Seleccionar los productos de la categoria beverages y condiments, donde la existencia este entre 18 y 30

select * from 
Products as P
join
Categories as C
on C.CategoryID = P.CategoryID
where (C.CategoryName in ('beverages', 'condiments'))
and  P.UnitsInStock >= 18 and  P.UnitsInStock <= 30

select * from 
Products as P
join
Categories as C
on C.CategoryID = P.CategoryID
where (C.CategoryName = 'beverages' or C.CategoryName = 'condiments')
and  P.UnitsInStock >= 18 and  P.UnitsInStock <= 30

--seleccionar los productos y sus importes realizados de marzo a junio de 1996, mostrando la fecha de la orden, , id del producto y 
--el importe
select * from [Order Details];

select O.OrderID, O.OrderDate, OD.ProductID, 
(OD.UnitPrice*OD.Quantity) as Importe from 
Orders as O
join
[Order Details] as OD
on O.OrderID = OD.OrderID
where O.OrderDate between '1996-07-01' and '1996-10-31'

select getdate()

--Mostrar el importe total de ventas de la consulta anterior

select concat('$',' ',sum(OD.UnitPrice*OD.Quantity)) as Importe 
from Orders as O
join
[Order Details] as OD
on O.OrderID = OD.OrderID
where O.OrderDate between '1996-07-01' and '1996-10-31'

--consultas B�sicas con inner join

--1. Obtener los nombres de los clientes y los paises a los que se enviaron sus pedidos

select C.CompanyName, O.ShipCountry 
from Customers as C
join
Orders as O
on C.CustomerID = O.CustomerID

select C.CompanyName, O.ShipCountry 
from Customers as C
join
Orders as O
on C.CustomerID = O.CustomerID
order by 2 desc

--2. Obtener los productos y sus respectivos proveedores

select P.ProductName, S.CompanyName from 
Products as P
join
Suppliers as S
on P.SupplierID = S.SupplierID

select P.ProductName, S.CompanyName from 
Products as P
join
Suppliers as S
on P.SupplierID = S.SupplierID
order by 2 desc

--3. Obtener los pedidos y los empleados que los gestionaron

Select O.OrderID, (FirstName + ' ' + LastName) as [Nombre completo] from 
Employees as E
join
Orders as O
On E.EmployeeID = O.EmployeeID

Select O.OrderID, concat (E.Title, ' - ',E.FirstName, ' ', E.LastName) as [Nombre completo] from 
Employees as E
join
Orders as O
On E.EmployeeID = O.EmployeeID

--4. Listar los productos juntos con sus precios y la categoria a la que pertenecen

select p.ProductName, p.UnitPrice, c.CategoryName from 
Products as p
join 
Categories as c
on p.CategoryID = c.CategoryID

--5. Obtener el nombre del cliente, el numero de orden y la fecha de orden

select cu.CompanyName, o.OrderID, o.OrderDate from 
Customers as cu
join
Orders as o
on cu.CustomerID = o.CustomerID

--6. Listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad que se vendio

select od.OrderID, p.ProductName, od.Quantity 
from [Order Details] as od
join
Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

select od.OrderID, p.ProductName, od.Quantity 
from [Order Details] as od
join
Products as p
on od.ProductID = p.ProductID
where od.OrderID = 11031
order by od.Quantity desc

select od.OrderID, count(*) as 'cantidad de Productos Vendidos'
from [Order Details] as od
join
Products as p
on od.ProductID = p.ProductID
where od.OrderID = 11031
group by od.OrderID
order by od.OrderID desc

select * from 
[Order Details]as od
where od.OrderID = 11077

--7. Obtener los empleados y sus respectivos jefes

select concat(e1.FirstName, ' ', e1.LastName) as Nombre, concat(j1.FirstName, ' ', j1.LastName) as Jefe 
from Employees as e1
join
Employees as j1
on e1.ReportsTo = j1.EmployeeID

--8. Listar los pedidos y el nombre de la empresa de transporte utilizada

select o.OrderID, s.CompanyName 
from Orders as o
join
Shippers as s
on s.ShipperID = o.ShipVia

--Consultas inner join intermedias

--9. Obtener la cantidad total de productos vendidos por categor�a

select sum(Quantity) from [Order Details]

select c.CategoryName as [Nombre categoria], sum(Quantity) as [Productos vendidos]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on  od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

--10. Obtener el total de ventas por empleado

select e.FirstName, sum((Quantity * od.UnitPrice)-(Quantity * od.UnitPrice) * od.Discount) as [Total de ventas]
from Orders as o
inner join Employees as e
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by e.FirstName

--11. Listar los clientes y la cantidad de pedidos que han realizado 

select c.CompanyName, count(*) as [Numero de Ordenes]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID 
group by c.CompanyName
order by [Numero de Ordenes] asc 

select c.CompanyName, count(*) as [Numero de Ordenes]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID 
group by c.CompanyName
order by count(*) asc

select c.CompanyName, count(*) 
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName

--12. Obtener los empleados que han gestionado pedidos enviados a Germany 

select distinct concat(e.FirstName, ' ', e.LastName), o.ShipCountry
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'

select concat(e.FirstName, ' ', e.LastName), o.ShipCountry
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany';

--13. Listar los productos junto con el nombre del proovedor y el pa�s de origen

select p.ProductName, s.CompanyName,s.Country
from Products as p
inner join Suppliers as s
on s.SupplierID = p.SupplierID
order by 1 asc

--14. Obtener los pedidos agrupados por pa�s de envio

select * from Orders	

--15. Obtener los empleados y la cantidad de territorios en los que trabajan

select distinct concat(e.FirstName, ' ', e.LastName) as Empleado, t.RegionID
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID

--16. Listar las categorias y la cantidad de productos que contienen

select c.CategoryName, count(p.ProductID) as [Cantidad de Productos]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc

--17. Obtener la cantidad total de productos vendidos por proveedor

select sum(od.Quantity) as ventas, s.CompanyName
from Suppliers as s
inner join Products as p
on p.SupplierID = s.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by s.CompanyName


--18. Obtener la cantidad de pedidos enviados por cada empresa de transporte

select s.CompanyName, count(*) as [Total de Pedidos]
from Orders as o
inner join Shippers as s
on o.ShipVia = s.ShipperID
group by s.CompanyName

select * from Orders
select count(*) from Orders
select count(OrderID) from Orders
select count(ShipRegion) from Orders


--Consultas Avanzadas

--19. Obtener los clientes que han realizado pedidos con mas de un producto

select c.CompanyName, count(distinct ProductID) as [Numero de productos]
from  Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 desc

select distinct ProductID as [Numero de productos]
from  Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
order by 1 desc

--20 Listar los empleados con la cantidad total de pedidos que han gestionado y a que clientes les han vendido, agrupandolos por
--nombre completo y dentro de este nombre por cliente, ordenandolos por la cantidad mayor de pedidos

--Con clientes
select concat(e.FirstName, ' ', e.LastName)as [Nombre del Empleado], count(*) as [Total de Pedidos], c.CompanyName
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
inner join Customers as c
on c.CustomerID = o.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by [Nombre del Empleado] asc, c.CompanyName

--Sin clientes
select concat(e.FirstName, ' ', e.LastName)as [Nombre del Empleado], count(*) as [Total de Pedidos]
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
group by e.FirstName, e.LastName
order by [Nombre del Empleado] asc

--21 Listar las categorias con el total de ingresos generados por sus productos

select c.CategoryName as Categoria, p.ProductName as Producto, sum(od.Quantity * od.UnitPrice) as Ingresos
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID 
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName, p.ProductName

--22 Listar los clientes con el total ($) gastado en pedidos

select c.CompanyName, sum (od.Quantity * od.UnitPrice) as Total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName

--23 Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el total en dinero

select o.OrderDate, sum (od.Quantity * od.UnitPrice) as Total
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
where OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate

--24 Listar los productos con las categorias Beverages, seafood, confections

select p.ProductName,c.CategoryName
from Categories as c
inner join Products as p
on c.CategoryID=p.CategoryID
where c.CategoryName in ('Beverages', 'Seafood', 'Confections')

--25 Listar los clientes ubicados en Alemania y que hayan realizado pedidos antes del 1 de enero de 1997

select 
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
where Country = 'Germany'
and o.OrderDate < '1997-01-01'

--26 Listar los clientes que han realizado pedidos con un total entre $500 y $2000

select c.CompanyName,  sum (od.Quantity * od.UnitPrice) as Total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID= o.OrderID
group by c.CompanyName
having  sum (od.Quantity * od.UnitPrice) between 500 and 2000

```