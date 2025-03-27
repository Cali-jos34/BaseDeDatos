# Inicio del tema de los Left Join

```sql
select * from Categories

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
where c.CategoryName = 'Fast Food'

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName
from Products as p
left join Categories as c
on c.CategoryID = p.CategoryID

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName
from Products as p
left join Categories as c
on c.CategoryID = p.CategoryID
where c.CategoryID is null

select * from Products
insert into Products(ProductName,SupplierID, CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock, UnitsOnOrder,ReorderLevel, Discontinued)
values('Burger Sabrosa', 1, 9, 'xyz', 68.7, 45, 12, 2, 0)

delete Products
where CategoryID = 9

select * from Products
insert into Products(ProductName,SupplierID, CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock, UnitsOnOrder,ReorderLevel, Discontinued)
values('Guaracha Sabrosona', 1, Null, 'xyz', 68.7, 45, 12, 2, 0)

--Listar los empleados y los pedidos que han gestionado (incluyendo los empleados que no han hecho pedidos)

select concat(e.FirstName, ' ', e.LastName) as [Nombre Empleado], e.EmployeeID, o.OrderID
from Employees as e
left join Orders as o
on e.EmployeeID = o.EmployeeID

select * from Orders
select * from Employees
```