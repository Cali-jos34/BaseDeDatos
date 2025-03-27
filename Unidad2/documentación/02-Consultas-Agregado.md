# Ejercicios Agregado: Solo devuelven un solo registro sum, avg, count, count(*), max y min.

```sql
--Consultas de agregado
use Northwind;
--Cuantos Clientes Tengo

select count(*) as 'Numero de Clientes' from Customers

--Cuantas Regiones hay (distinct = para que no se repitan) (where= filtra filas)

select count(Region) from Customers

select count(*) from Customers
where Region is NULL

select count (distinct Region) from Customers
where Region is not NULL
order by Region asc

 --count(*) Cuenta todos los registros
 --count No agrega null

select * from Orders
select count(*) from Orders
select count(ShipRegion) from Orders

--Selecciona el precio mas bajo de los productos (avg = promedio)
select * from Products

select min(UnitPrice) from Products;
select min(UnitPrice), max(UnitPrice) from Products;
select min(UnitPrice), max(UnitPrice), avg (UnitsInStock) from Products;
select min(UnitPrice), max(UnitPrice), avg (UnitsInStock), sum(UnitPrice) from Products;

--Seleccionar cuantos pedidos existen
select * from Orders

select count(*) from Orders
select count(OrderID) as [Total de pepidos] from Orders

--Calcula el total de dinero vendido
select * from [Order Details]

select sum(UnitPrice * Quantity) as [Dinero Perdido] from [Order Details]
select sum(UnitPrice * Quantity - (UnitPrice*Quantity*Discount)) as [Dinero Perdido] from [Order Details]

--Calcula el total de unidades en stock de todos los productos
select * from Products

select count(*) from Products
select sum(UnitsInStock) as [Total de unidades] from Products




--GROUP BY
--seleccionar el n�mero de productos por categoria
select * from  Products

select CategoryID, count(*) as [Numero de productos] from Products
group by CategoryID


-----------Adelanto de joins ---------------------------
select p.CategoryID,  count (*) as [Numero de Productos] from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by p.CategoryID

select Categories.CategoryName, count (*) as [Numero de Productos] from Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName
---------------------------------------------------------

--Calcular el precio promedio de los productos por cada categoria
select * from Products

select CategoryID, avg (UnitPrice) as [Precio Promedio] 
from Products
group by CategoryID

--Seleccionar el n�mero de pedidos por cada empleado por el ultimo trimestre de 1996
select * from Orders

select EmployeeID, count (*) [Numero de Pedidos] from Orders
group by EmployeeID

select EmployeeID, count(*) from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by EmployeeID

--Seleccionar la suma total de unidades vendidas por cada producto
select * from [Order Details]

select ProductID, sum(Quantity) from [Order Details]
group by ProductID 

select top 5 ProductID, sum(Quantity) from [Order Details]
group by ProductID 
order by 2 desc

select ProductID, sum(Quantity) from [Order Details]
group by ProductID 
order by 2 desc

select OrderID, ProductID, sum(Quantity) from [Order Details]
group by OrderID, ProductID
order by 2 desc

--HAVING (filtra grupos dentro de los group by)

--seleccionar el numero de productos por categoria, pero solo aquellos que tengan m�s de 10 productos

select CategoryID from Products
where CategoryID in (2,4,8)

select CategoryID, avg(UnitPrice) from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*) > 10

--Listar las ordenes agrupadas por empleado, pero que solo muestre aquellos que hayan gestionado m�s de 10 pedidos

select * from Orders

select EmployeeID, count(*) from Orders
group by EmployeeID
having count(*) > 80
order by EmployeeID
```