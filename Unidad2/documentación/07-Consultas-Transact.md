#EJERCICIOS DE FUNCIONES DE CADENA
--Las funciones de cadena permite manipular tipos de datos como varchar, nvarchar, char, nchar.

```sql
--FUNCIONES DE CADENA


--Declaraci�n de una variable
--Primera forma

DECLARE @Numero int;
SET @Numero = 10;
print @Numero;

--Segunda forma
DECLARE @Texto varchar(50) = 'Hola Mundo!';
Go

--Obtener el tama�o de la cadena almacenada en la variable Texto
--Funci�n LEN -> Devuelve la longitud de una cadena
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select len(@Texto) as Longitud
Go

--Funcion LEFT -> Extrae un numero esspecifico de caracteres desde el inico de la cadena. (variable, posici�n desde la izquierda)
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select left(@Texto, 4) as Inicio
Go

--Funci�n RIGHT -> Extrae un determinado n�mero de caracteres del final de la cadena. (variable, posici�n desde la derecha)
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select right(@Texto, 6) as Final
Go

--Funcion SUBSTRING -> Extrae una parte de la cadena. (variable, posici�n donde inica, recorrido donde termina)
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select SUBSTRING(@Texto, 7,5) as [Una Parte]
Go

--Funci�n REPLACE -> reemplaza una subcadena por otra. (cadena, cadena a reemplazar, reemplazo de la cadena)
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select replace(@Texto, 'Mundo', 'Amigo') as reemplazo
Go

--Funci�n CHARINDEX -> Busca y devuelve la posici�n del carcarter que se requiere. (cadena, variable)
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select charindex('Mundo', @Texto) as Posicion
Go

--Funci�n OPER -> Combierte una cadena en mayusculas. (variable)
DECLARE @Texto varchar(50) = 'Hola Mundo!';
select upper(@Texto) as Mayusculas
select Concat(LEFT(@Texto,6), upper(SUBSTRING(@Texto, 7,5)), RIGHT(@Texto, 1)) as TextoNuevo
Go

--Funci�n TRIM -> Permite quitar espacios en blanco de una cadena
DECLARE @Texto varchar(50) = ' Hola Mundo! ';
select trim (@Texto) as result;

SELECT TRIM( '     test    ') AS Result;
Go





select CompanyName, len(CompanyName) as tama�o,
left (companyName, 4) as Inicio,
right(CompanyName, 6) as Final,
SUBSTRING(CompanyName, 7,4) as Subcadena
from Customers;

--UPDATE
update Customers
set CompanyName = Upper(CompanyName)
where country in ('Mexico', 'Germany')
select * from Customers


-- Funciones de Fecha
```