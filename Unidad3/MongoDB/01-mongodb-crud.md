# MongoDB Crud

## Abrir mongo en terminal
`mongosh`
`{} = datos`
`[] = documentos`


## Crear una base de datos
**Solo se crea si contiene por lo menos una colección**

```json
use base de datos
```


## Crear una colección

`use db1
db.createCollection('Empleado')`


## Mostrar colecciones

`show collections`


## Inserción de un documento
```json
db.Empleado.insertOne(
    {
    nombre:'Soyla',
    apellido: 'Vaca',
    edad: 32,
    ciudad: 'San Miguel de las piedras'
    }
)
```


## Inserción de un documento más complejo con array
```json
db.Empleado.insertOne(
    {
    nombre: 'Ivan',
    apellido: 'Baltazar',
    apellido2: 'Rodriguez',
    aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir']
    }
)
```

**Eliminar una colección**
db.coleccion.drop()

```json
__Ejemplo__

db.empleado.drop()
```


## Inserción de documentos mas complejos con anidados, arrays y ID
```json
db.alumnos.insertOne(
    {
        nombre: 'Jose Luis',
        apellido: 'Herrera',
        apellido2: 'Gallardo',
        edad: 41,
        estudios:[
            'Ingeniería en Sistemas Computacionales',
            'Maestría en Administración de Tecnologías de Información'
        ],
        experiencia: 
        {
            lenguaje: 'SQL',
            sgb: 'SQLServer',
            anios_experiencia: 20
        }
    }
)
```


## Generar un Id personalizado
```json
db.alumnos.insertOne(
    {
        _id:3,
        nombre: 'Sergio',
        apellido:'Ramos',
        equipo: 'Monterrey',
        aficiones:['Dinero', 'Hombres', 'Fiesta'],
        talentos:
        {
            futbol: true,
            bañarse: false
        }
    }
)
```


## Insertar multiples documentos
```json
db.alumnos.insertMany(
    [
        {
            _id:12,
            nombre:'Osgualdo',
            apellido:'Venado',
            edad: 20,
            descripción: 'Es un quejunbroso'
        },
        {
            nombre:'Maritza',
            apellido:'Rechicken',
            edad: 20,
            habilidades:
            [
                'Ser vibora', 'Ilusionar', 'Caguamear'
            ],
            direccion:
            {
                calle: 'Del infierno',
                numero: 666
            },
            esposos:
            [
                {
                    nombre: 'Joshua',
                    edad: 20,
                    pension: -34,
                    hijos:['Ivan', 'Jose']
                },
                {
                    nombre: 'Lana',
                    edad: 19,
                    pension: 70,
                    complaciente: true
                }
            ]
        }
    ]
)
```


## Búsquedas. Condiciones simples de igualdad Método find()

1. Seleccionar todos los documentos de la colección libros
```json
db.libros.find({})
```
2. Seleccionar todo los documentos que sean de la editorial biblio
```json
db.libros.find({editorial:'Biblio'})
```
3. Mostrar todos los documentos que el precio sea 25
```json
db.libros.find({precio: 25})
```
4. Seleccionar todos los documentos donde el titulo sea json para todos
```json
db.libros.find({titulo: 'JSON para todos'})
```

## Operadores de comparación
[Operadores de comparación](https://www.mongodb.com/docs/manual/reference/operator/query/)

`== $eq` `> $gt` `< $lt` `>= $gte` `<= $lte`
![Operadores de Comparación](./img/operadores-Relacionales.png)

1. Mostrar todos los documentos donde el precio sea mayor a 25 (mayor a)
```json
db.libros.find({precio:{$gt:25}})
```

2. Mostrar los documentos donde el precio sea 25 (igual a)
```json
db.libros.find({precio:{$eq:25}})
```

3. Mostrar los documentos cuya cantidad sea menor a 5 (menor a)
```json
db.libros.find({cantidad:{$lt:5}})
```

4. Mostrar los documentos que pertenecen a la editorial Biblio o Planeta (esta en)
```json
db.libros.find({editorial: {$in:['Biblio', "Planeta"]}})
```

5. Mostrar todos los documentos de libros que cuesten 20 o 25 (esta en)
```json
db.libros.find({precio: {$in:[20, 25]}})
```

6. Mostrar todos los documentos que no cuesten 20 o 25 (no esta en)
```json
db.libros.find({precio: {$nin:[20, 25]}})
```

## Instrucción findOne

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condición)
```json
db.libros.findOne({precio: {$in:[20, 25]}})
```

## Operadores Lógicos

[Operadores Lógicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

 `AND $and`  `NOT $not`  `NOR $nor`  `OR $or`

 ### Operador AND
 - Dos posibles opciones

 1. La simple, mediante condiciones separadas ppor comas
    - db.libros.find({condicion1, condicion2, ...}) -> Con esto asume que es una AND

2. Usando el operador $AND
    -db.libros.find({$and:[{condicion1}, {condicion2}, {...}]})

1. Mostrar todos aquellos libros que cuesten más de 25 y cuya cantidad sea inferior a 15
```json
db.libros.find({$and:[{precio:{$gt:25}}, {cantidad:{$lt:15}}]})
```
```json
db.libros.find(
    {
        $and:[
                {precio:{$gt:25}},
                {cantidad:{$lt:15}}
            ]
    }
)
```

### Operador OR

-Mostrar todos aquellos libros que cuesten mas de 25 o cuya cantidad sea inferior a 15

```json
db.libros.find({$or:[{precio:{$gt:25}}, {cantidad:{$lt:15}}]})
```



***Ejemplo con and y or combinados***

-Mostrar los libros de la editorial Biblia, con precio mayor a 40 o libros con la editorial Planeta con precio mayor a 30.

```json
db.libros.find
({$and:[{precio:$gt:40},{editorial: {$in: ['Biblia', 'Planeta' ]}},{$or:[{precio:$gt:30}]]})
```
```json
db.libros.find( 
{
    $and: [
        { $or: [ { editorial:'Biblio'}, {precio:{$gt:30}}]},
        { $or: [ { editorial:{$eq:'Planeta'}}, {precio:{$gt:20}}]}
    ]
} 
)
```


### Proyeccion (ver ciertas columnas)
***Sintaxis***
```json
db.conexion.find(filtro, columnas)
```
- Seleccionar todos los libros, solo mostrando el titulo.
1) db.libros.find({}, {titulo:1}) 
2) db.libros.find({titulo:1,_id:0})


### Operador Exist(permite saber si un campo se encuentra o no en un documento)
```json
db.libros.find({eitorial:{$exist:true}})

db.libros.find({eitorial:{$exist:true}})
```

### Operador Type (permite solicitar a MongoDB si un campo corresponde a un tipo)

[Operador Type : https://www.mongodb.com/docs/manual/reference/operator/query/type/#mongodb-query-op.-type]

1. Mostrar todos los dcumentos donde el precio sea de tipo double o entero o cualquier otro tipo de dato
```json
db.libros.find(
    {
        precio:{$type:16}
    }
)

db.libros.find(
    {
        precio:{$type:"int"}
    }   
)

db.libros.insertMany(
[
{
    _id:12,
    titulo:'IA',
    editorial:'Terra',
    precio:125,
    cantidad:20,
},
{
_id:13,
titulo:'Python para todos',
editorial: 2001,
precio: 200,
cantidad: 30
}
])
```

2. Selccionar todo los docuementos de los libros donde los valores de la editorial sean string
```json
db.libros.find({editorial:{$type:2}})
db.libros.find({editorial:{$type:'string'}})
db.libros.find({editorial:{$type:16}})
db.libros.find({editorial:{$type:"int"}})
```


## Modificando Documentos
### Comandos importantes

1.Update->Modifica un solo documento.

2.UpdateMany->Modificar multiples documentos.

3.ReplaceOne->Sustituir el contenido completo de un documento

***tiene el siguiente formato***
```json
db.collections.updateOne(
{filtro},
{operadores:}
)
```
#### Operadores $set

1. Mmodificar un documento
```json
db.libros.updateOne({titulo:'Python para todos'}, {$set:{titulo:'Java para todos'}})
```
```json
db.libros.insertOne(
    {
_id:10,
titulo: 'Mongo en Negocios Digitales',
editorial:'Terra',
precio:125
}
)
```

2. Modificar el documento con id 10, estableciendo el precio en 100 y la cantidad en 50
```json
db.libros.updateOne({_id:10}, {$set:{Precio:100}, {Cantidad:50}})
```

3. Utilizando el updateMany, modificar todos los libros donde el precio sea mayor a 100 cambiarlo por 150

```json
db.libros.updateMany({precio:{gt:100}, {$set{precio:150}}})
```

### Operadores $inc y $mul

1. Incrementar todos los precios de los libros en 5

```json
db.libros.updateMany({editorial: 'Terra'}, {$inc:{precio:5}})
```

2. Multiplicar todos los libros donde la cantidad sea mayor a 20, en su cantidad por 2

```json
db.libros.updateMany({cantidad:{$gt:20}}, {$mul:{cantidad: 2}})
```
`
db.libros.find({_id:{$in:[1,7,10,13]}})
`
Consultar todos a la vez para no usar (or)

3. Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libro donde el precio sea mayor a 20

```json
db.libros .updateMany({precio:{$gt: 20}}, {$mul:{cantidad:2, precio:2}})
```

### Reemplazar doumentos (replaceOne)

1. Actualizar todo el documento del id 2 por el titulo: De la Tierra a la Luna, autor: Julio Verne, editorial: Terra, precio: 100
```json
db.libros.replaceOne({_id:2}, 
{
    titulo: 'De la Tierra a la Luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
})
```
### Borrar Documentos
- Elimina un solo documento `deleteOne`
- Elimina multiples documentos `deleteMany`

1. Eliminar el documento con el id 2
```json
db.libros.deleteOne({_id:2})
```

2. Eliminar todos los libros donde la cantidad es mayor a 150 
```json
db.libros.deleteMany({cantidad: {$gt:150}})
```

### Expresiones Regulares

1. Seleccionar todos los libros que contengan una (t)
```json
db.libros.find({titulo:/t/})
```

2. Seleccionar todos los libros que en el titulo contenga la palabra (json)
```json
db.libros.find({titulo:/json/})
```

3. Seleccionar todos los libros que en el titulo terminen con (tos)
```json
db.libros.find({titulo:/tos$/})
```

4. Seleccionar todos los titulos que comiences con (j)
```json
db.libros.find({titulo:/^J/})
```

## Operador $regex
[Operadores Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

1. Seleccionar los libros que contengan la palabra "para" en el titulo

```json
db.libros.find({titulo:{$regex: 'para'}})

db.libros.find({titulo:{$regex: /para/}})
```

2. Seleccionar todos los titulos que contengan la palabra Json

```json
db.libros.find({titulo:{$regex:/JSON/}})

db.libros.find({titulo:{$regex:'JSON'}})
```
- Distingur entre mayusculas y minusculas (dos formas)

```json
db.libros.find({titulo:{$regex:/json/i}})

db.libros.find({titulo:{$regex:'json', $options: 'i'}})
```
3. Seleccionar todos los documentos de libros donde el titulo comience con j y no distinga entre mayusculas y minusculas

```json
db.libros.find({titulo:{$regex:^j/, $options: 'i'}})
```

4. Seleccionar todos los documentos de libros donde el titulo termine con "es" y no distinga entre mayusculas y minusculas

```json
db.libros.find({titulo:{$regex:/es%/, $options: 'i'}})
```
### Método sort (Ordenar Documentos)

1. Ordenar los libros de manera ascendente / descendente por el precio

```json
1. Ascendente
db.libros.find({},{_id:0, titulo: 1, precio:1}).sort({precio:1})

2. Descendente
db.libros.find({},{_id:0, titulo: 1, precio:1}).sort({precio:-1})
```

2. Ordenar los libros de manera ascendente por la editorial y de forma descendente por el precio, mostrando el precio y la editorial

```json
1. Ascendente
db.libros.find({},{_id:0, editorial: 1, precio:1}).sort({editorial:1, precio:-1})
```

### Otros métodos (skip, limit, size)

- size: Saber cuantos tengo
db.libros.find({}).size()

```json
db.libros.find({titulo:{$regex:/^j/, $options: 'i'}}).size()
```

- limit: Dar un limite
db.libros.find({}).limit(1,2,...)

```json
db.libros.find({}).limit(2)
```

- skip: Saltarse datos
db.libros.find({}).skip(2)

### Borrar colecciones y base de datos

```json
db.libros.drop()

db.dropDatabase()
```