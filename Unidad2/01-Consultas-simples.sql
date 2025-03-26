-- lenguaje SQL-LMD (instert, update, delete, select - crud)

--Consultas simples

use Northwind;

-- Mostrar todos los clientes, con todos las columnas de datos de la empresa

Select * from Customers;
Select * from Employees;
Select * from Orders;
Select * from Suppliers;
Select * from Products;
Select * from Shippers;
Select * from Categories;
Select * from [Order Details];

-- Proyección
--Seleccionar o mastrar el número de empleado, su primer nombre, su cargo, ciudad y pais.

Select EmployeeID, FirstName, Title, City, Country
from Employees;

--Alias de columna 
--En base a la consulta anterior, visualizar el EmployeeID como número empleado, FirstName como primer nombre, title como cargo, City como ciudad, Country como pais

select EmployeeID as 'Numero Empleado', FirstName as [Primer Nombre], Title 'Cargo', City as Ciudad, Country 'Pais'
from Employees;

--Campos calculados
--Seleccionar el importe de cada uno de los productos vendidos en una orden

Select *, (UnitPrice * Quantity)as importe
from [Order Details];

--seleccionar las fechas de orden, año , mes y día
--El cliente que las ordeno y el empleado que las realizo

select OrderDate, year(OrderDate) as Año, month(OrderDate) as Mes, day(OrderDate) as Dia,
CustomerID, EmployeeID 
from Orders;

--filas duplicadas (Distinct) --Quitar datos repetidos.
select * from Customers;

--Mostrar los paises en donde se tiene clientes mostrando pais solamente

select distinct Country from Customers
order by country

--Clausula where
--Operadores relacionales (<,>,=,<=,>=,!=, <>)
select * from Customers;

--Seleccionar el cliente BOLID

select CustomerID as Cliente, CompanyName as 'Nombre de empresa', City as Ciudad, Country as Pais
from Customers
where CustomerID = 'BOLID';

--Seleccionar los clientes, mostrando su identificador, nombre de la empresa, contacto, ciudad y pais de alemania
select * from Customers;

select CustomerID as Identificador, CompanyName as 'Nombre de Empresa', ContactName as Contacto, City as ciudad, Country as pais
from Customers
where Country = 'Germany';

--seleccionar todos los clientes que no sean de Alemania
select * from Customers;

select CustomerID as Identificador, CompanyName as 'Nombre de Empresa', ContactName as Contacto, City as ciudad, Country as pais
from Customers
--where Country != 'Germany';
where not Country = 'Germany';

--Seleccionar todos los productos mostrando su nombre de producto, categoria a la que pertenece, existencia, precio
--pero solamente donde su precio sea mayor a 100
select * from Products;

select ProductName as [Nombre del Producto], CategoryID as Categoria, UnitsInStock as Existencia, UnitPrice as Precio,
(UnitPrice * UnitsInStock) as [Costo inventario]
from Products
where UnitPrice > 100;

--seleccionar las ordenes de compra mostrando la fecha de orden, de entrega y de envio
--el cliente a quien se vendio de 1996
select * from Orders;

select OrderDate as [Fecha de Orden], RequiredDate as [Fecha de entrega], ShippedDate as [Fecha de envio],
CustomerID as Cliente
from Orders
where year(OrderDate) = '1996'

--Mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5.
Select * from [Order Details]
where Quantity >= 40

--Mostrar el nombre completo del empleado, su numero de empleado, fecha de nacimiento, ciudad y fecha de contratación
--y esta debe ser de aquellos que fueron contratados después de 1993, los resultados en sus encabezados deben ser mostrados
--en español.
select *from Employees

--Primera opción
select LastName as Apellido, FirstName as Nombre,EmployeeID as [Numero de Empleado], BirthDate as [Fecha de Nacimiento],
city as Ciudad, HireDate as [Fecha de contratación]
from Employees
where year (HireDate) > 1993 

--Segunda Opción
select (FirstName + ' ' + LastName) as [Nombre Completo],EmployeeID as [Numero de Empleado], BirthDate as [Fecha de Nacimiento],
city as Ciudad, HireDate as [Fecha de contratación]
from Employees
where year (HireDate) > 1993

--Tercera opción
select Concat(FirstName, ' ', LastName) as [Nombre Completo],EmployeeID as [Numero de Empleado], BirthDate as [Fecha de Nacimiento],
city as Ciudad, HireDate as [Fecha de contratación]
from Employees
where year(HireDate) > 1993 

--mostrar los empleados que no son dirigidos por el jefe 2
select * from Employees

select Concat(FirstName, ' ', LastName) as [Nombre Completo],EmployeeID as [Numero de Empleado], BirthDate as [Fecha de Nacimiento],
city as Ciudad, HireDate as [Fecha de contratación], ReportsTo as jefe
from Employees
where ReportsTo != 2

--seleccionar los empleados que no tengan jefe

select * from Employees
where ReportsTo is null;

--Operadores lógicos (or, and y not)

--Seleccionar los productos que tengan un precio de entre 10 y 50
Select * from Products

select ProductName, UnitPrice, UnitsInStock 
from Products
where UnitPrice>=10
and UnitPrice<=50

--Mostrar todos los pedidos realizados por clientes que NO son enviados de Alemania

select OrderID, ShipCountry
from Orders
where  not ShipCountry = 'Germany'

--Seleccionar clientes de México o Estados Unidos

select * from Customers
where Country = 'Mexico'
or Country = 'USA'

--Seleccionar empleados que nacieron entre 1955 y 1958 y que vivan en Londres

select * from Employees
where (year(BirthDate)>=1955 and year(BirthDate)<=1958)
and City ='London'

--Seleccionar los Pedidos con flete de peso (Freight) mayor a 100 y enviados a Francia o España

Select * from Orders
where Freight>100
and (ShipCountry= 'France' or ShipCountry= 'Spain')

--Seleccionar las primeras 5 ordenes de compras

select top 5 * from Orders

--Seleccionar los productos con precio entre $10 y $50 que NO estén descontinuados y tengan más de 20 unidades en stock
Select * from Products

Select UnitPrice, UnitsInStock, Discontinued from Products
where (UnitPrice >= 10 and UnitPrice <= 50)
and Discontinued = 0 and UnitsInStock>20

--Pedidos enviados a Francia o Alemania, pero con un flete menor a 50
select OrderID, ShipCountry, Freight from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany')
and Freight < 50

--Clientes que NO sean de México o USA y que tengan fax registrado
select * from Customers

select Country, Fax from Customers
where not (Country='Mexico' or Country='USA')
and Fax is not NULL

--Seleccionar pedidos con un fletemayor a 100, enviados a Brasil o Argentina, pero NO enviados por el transportista 1
Select * from Shippers
Select * from Orders


--Seleccionar Empleados que NO viven en Londres o Seattle y que 

select concat(FirstName, '',LastName), HireDate, City, Country
from Employees
where City <> 'London' and City <> 'Seattle'
and year(HireDate) >=1992

select concat(FirstName, '',LastName), HireDate, City, Country
from Employees
where NOT (City = 'London' and City = 'Seattle')
and year(HireDate) >=1992


--CLAUSULA IN (or)

--seleccionar los productos con categoria 1, 3 o 5

select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5

select ProductName, CategoryID, UnitPrice from Products
where CategoryID in (1, 3, 5);

--Seleccionar todas las ordenes de la región RJ, Tachira y que no tengan región asignada
select * from Orders

select OrderID, ShipRegion
from Orders
where ShipRegion in ('RJ','Táchira')
or ShipRegion is NULL

--seleccionar las ordenes que tengan cantidaes de 12, 9 o 40 y descuento de 0.15 0 0.5
select * from [Order Details]

select * from [Order Details]
where  Quantity in (12, 9, 40)
and Discount in (0.15, 0.5)


--CLAUSULA BETWEEN (buscar rangos) and
--between valorInicial and valorFinal

--Mostrar los productos con precio entre 10 y 50

select * from Products
where UnitPrice >= 10 and UnitPrice <= 50;

select ProductID as Número, UnitPrice as Precio, ProductName as Nombre from Products
where UnitPrice between 10 and 50;

--Seleccionar todos los pedidos realizados entre el primero de enero y el 30 de junio de 1997
select * from Orders

select OrderID as Numero, OrderDate as Fecha from Orders
where OrderDate between '1997-01-01' and '1997-06-30'

select OrderID as Numero, OrderDate as Fecha from Orders
where OrderDate >= '1997-01-01' and OrderDate <= '1997-06-30'

--Seleccionar todos los empleados contratados entre 1990 y 1995 que trabajan en Londres

select * from Employees

select HireDate, City, EmployeeID from Employees
where year(HireDate) between '1990' and '1995'
and City = 'London'

--Pedidos con flete entre 50 y 200 enviados a alemania 0 a francia
select * from Orders

select Freight, ShipCountry from Orders
where Freight between '50' and '200' 
and (ShipCountry = 'Germany' or ShipCountry = 'France')

select Freight, ShipCountry from Orders
where Freight between '50' and '200' 
and ShipCountry in ('Germany','France')

--seleccionar todos los productos que tengan un precio entre 5 y 20 dolares y que sean de la categoria 1,2 o 3
select * from Products

select ProductID, UnitPrice, CategoryID from Products
where (UnitPrice between 5 and 20) 
and CategoryID in (1,2,3)

--Seleccionar los empleados con numero de trabajador entre 3 y 7 que no trabajan en London ni Seattle
select * from Employees

select EmployeeID as Numero, City as Ciudad, concat(FirstName, '' , LastName) as [Nombre Completo] from Employees
where EmployeeID between 3 and 7
and City != 'London' and City != 'Seattle'


--Clausula Like
--Patrones:
--1) % (porcentaje) -> Representa cero o mas caracteres en el patron de búsqueda
--2) _ (guión bajo) -> Representa exactamente un caracter en el patron de busqueda
--3) [] (corchetes) -> Se utiliza para definir un conjunto de caracteres buscando cualquiera de ellos en la posición específica.
--4) [^] (asento circunflejo) -> Se utiliza para buscar caracteres que no estan dentro del conjunto específico


--Buscar los productos que comienzan con "c"
select * from Products
where ProductName like 'C%'

select * from Products
where ProductName like 'Cha%'

select * from Products
where ProductName like 'C%' and UnitPrice = 18

--buscar todos los productos que terminen con "e"

select * from Products
where ProductName like '%e'

--Seleccionar todos los clientes cuyo nombre de empresa contiene "co" en cualquier parte
select * from Customers

select CustomerID, CompanyName from Customers
where CompanyName like '%co%'

--seleccionar los empleados cuyo nombre comience con "a" y tenga exactamente 5 caracteres

select * from Employees
where FirstName like 'A_____'

--Seleccionar los productos que comiencen con A o B
select * from Products
where ProductName like '[ABC]%'

--Seleccionar todos los productos que no comiencen en A o B
select * from Products
where ProductName like '[^AB]%'

--Seleccionar todos los productos donde el nombre que comience con A pero no contenga E
select * from Products
where ProductName like 'A[^E]%'

--Clausula Order by (asc = ascendente) (desc = descendente) OERDENAR

Select ProductID, ProductName, UnitPrice,UnitsInStock from Products
order by UnitPrice desc

Select ProductID, ProductName, UnitPrice,UnitsInStock from Products
order by 3 asc

Select ProductID, ProductName, UnitPrice as 'Precio',UnitsInStock from Products
order by 'Precio' desc

--Seledccionar los clientes ordenados por el país y dentro por ciudad
select CustomerID, Country, City from Customers
where Country in ('Brazil', 'Germany')
order by Country asc, City asc

select CustomerID, Country, City, Region from Customers
where (Country = 'Brazil' or Country = 'Germany')
and Region is null
order by Country,  City asc