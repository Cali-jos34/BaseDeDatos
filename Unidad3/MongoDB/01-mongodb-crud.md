# MongoDB Crud

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
db.Empleado.insertOne(
    {
    nombre:'Soyla',
    apellido: 'Vaca',
    edad: 32,
    ciudad: 'San Miguel de las piedras'
    }
)