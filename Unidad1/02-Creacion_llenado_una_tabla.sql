#creacion de la base de datos tienda 1
#Crea la base de datos tienda 1
create database tienda1;

#Utilizar un abase de datos
use tienda1;
#SQL #LDD

create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key(categoriaid),
constraint unico_nombre
unique(nombre)
);

#SQL - ld
#Agregar registros a la tabla categoria
insert into categoria
values(1, 'Carne Fria');

insert into categoria (categoriaid,nombre)
values(2, 'Linea Blanca');

insert into categoria(nombre,categoriaid)
values('Vinos y Licores', 3);

insert into categoria
values (4, 'Ropa'),
		(5, 'Dulces'),
        (6, 'Lacteos');

insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
		('Zapateria', 8),
        ('Jugueteria', 9);

insert into categoria
values (10, 'Panaderia');
        
select * from categoria
order by categoriaid asc;

delete from categoria
where categoriaid = 0