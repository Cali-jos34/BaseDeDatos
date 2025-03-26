--Crear un Store procedure para seleccionar todos los clientes
--Conjunto de instrucciones que se guarda en sql y se puede utilizar para 
create or alter proc
Go
create or alter procedure spu_mostrar_clientes
as
begin
	select * from Customers;
end;
Go

--Ejecutar un store en transact
exec spu_mostrar_clientes;
execute spu_mostrar_clientes;
go

--crear un sp que muestre los clientes por país 

create or alter proc spu_Customersporpais
@pais nvarchar(15) --Parametro de entrada

AS
begin
	select * from Customers
	where country = @pais;
end;
exec spu_Customersporpais 'UK'
Go

create or alter proc spu_Customersporpais
@pais nvarchar(15), 
@pais2 nvarchar(15) --Parametro de entrada

AS
begin
	select * from Customers
	where country in (@pais, @pais2);
end;
exec spu_Customersporpais @pais, @pais2;
Go

--
Declare @p1 nvarchar(15) = 'italy';
Declare @p2 nvarchar(15) = 'germany';

exec spu_Customersporpais @p1, @p2;
Go

--Generar un reporte que permita visualizar los estados de compra de un determinado cliente en un rango de fechas,
--mostrando el monto total de compras por producto, mediante un sp.

create or alter proc spu_InformeVentasClientes
@nombre nvarchar(40) = 'Berglunds snabbköp', --Parametro de entrada con valor por default
@fechaInicial DateTime,
@fechaFinal DateTime
AS
begin
	select [Nombre del producto], [Nombre del cliente], sum(importe) as [Monto Total]
	from VistaOrdenesCompra
	where [Nombre del cliente] = @nombre
	and [Fecha de orden] between @fechaInicial and @fechaFinal
	group by [Nombre del producto], [Nombre del cliente]
end;
Go

select * from Customers
select * from Orders
select getdate()

--Ejecución de un store con parametros de entrada
exec spu_InformeVentasClientes 'Berglunds snabbköp', 
							   '1996-07-04', '1997-01-01';

--Ejecucion de un sp con parametros en diferente posición
exec spu_InformeVentasClientes @fechaFinal= '1997-01-01',
							   @nombre= 'Berglunds snabbköp',
							   @fechaInicial= '1996-07-04'; 

--ejecución de un sp con parametros de entrada con un campo que tiene un valor por default
exec spu_InformeVentasClientes @fechaInicial= '1996-07-04',
							   @fechaFinal= '1997-01-01';
Go
							
--Sp con parametros de salida

create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), -- Parametro de entrada
@totalCustomers int output -- Parametro de salida
AS
begin
	select @totalCustomers = count(*) from Customers
	where CustomerID = @customerid
end;
Go

declare @numero as int;
exec spu_obtener_numero_clientes @customerid = 'ANATR',
								 @totalCustomers = @numero output;
print @numero;
Go


/*
int x=3
if(x>=9)
print 'bien',
else
print 'mal';
*/

--&& -> and
--|| -> or
--! -> not

--Crear un sp que permita saber si un alumno aprobo o reprobo

create or alter proc spu_comparar_calificacion
@calif decimal(10,2) --Parametro de entrada
AS
begin
	if @calif>=0 and @calif<=10
    begin
		if @calif>=8
			print 'La calificación es aprobatoria'
		else
			print 'La calificación es reprobatoria'
    end
    else
		print 'Calificación no valida'
end;
Go

exec spu_comparar_calificacion @calif = 8

--Crear un sp que permita verificar si un cliente existe antes de devolver su información (1 = el existente del primer dato)

create or alter proc spu_obtener_cliente_exite
@numerocliente nchar(5)
AS
begin
	if exists (select 1 from Customers where CustomerID = @numerocliente)
		select * from Customers where CustomerID = @numerocliente;
	else
		print 'el cliente no existe'
end;
Go

exec  spu_obtener_cliente_exite @numerocliente = 'arout'

select * from Customers
select 1 from Customers where CustomerID = 'arout'

--Crear un sp que permita insertar un cliente pero se debe verificar primero que no exista

create or alter proc spu_agregar_cliente
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
AS
begin
	if exists(select 1 from Customers where customerID = @id)
	begin
		print ('El cliente ya existe')
		return 1
	end

	insert into Customers (CustomerID, CompanyName)
	values (@id, @nombre);
	print ('Cliente insertado exitosamente');
	return 0;
end;
GO

exec spu_agregar_cliente 'ALFKI', 'Patito de hule'
exec spu_agregar_cliente 'JOVE', 'Pato'
GO

create or alter proc spu_agregar_cliente_try_catch
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
AS
begin
	begin try 
		insert into Customers (CustomerID, CompanyName)
		values (@id, @nombre)
		print ('Cliente insertado exitosamente');
	end try

	begin catch
		print ('El cliente ya existe');
	end catch
end;
GO

exec spu_agregar_cliente_try_catch 'JOVE', 'Pato'
exec spu_agregar_cliente_try_catch 'ALFKIC', 'Muñeca'

--Manejo de ciclos en sp

--Imprimir el nuemro de veces que indique el usuario

create or alter proc spu_imprimir
@numero int
AS
begin
	if @numero <=0
	begin
		print('El numero no puede ser 0 o negativo')
		return
	end

	declare @i int
	SET @i = 1
	while(@i<=@numero)
	begin
		print concat('Numero ' , @i)
		SET @i = @i + 1
	end;
end;
GO

exec spu_imprimir 9