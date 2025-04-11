# Practica 1: Base de Datos
## Colecciones e inserts

1. Conectarse con MongoDB

`mongosh`

2. Crear una base de datos llamada Curso

```json
use Cursos
```
3. Mostrar que no existe la base de datos

```json
show dbs
```

4. Crear una colección que se llame facturas y mostrarla

```json
 db.createCollection('facturas')
 show collections
```

5. Insertar un documento con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_Factura | 10 |
| Ciente | Frutas Ramirez |
| Total | 223 |

| Codigo   | Valor   |
|-------------|-------------|
| Cod_Factura | 20 |
| Ciente | Ferreteria Juan |
| Total | 140 |

```json
db.facturas.insertOne(
    {
        Cod_Factura: 10,
        Cliente: 'Frutas Ramirez',
        Total: 223,
    },
    {
        Cod_Factura: 20,
        Cliente: 'Ferreteria Juan',
        Total: 140
    }
)
```

6. Crear una nueva colección pero usando directamente el insertOne.
   insertar un documento en la colección productos con los siguientes datos:

   | Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 1 |
| Nombre | Tornillo x 1" |
| Precio | 2 |

```json
db.createCollection('producto')
db.producto.insertOne(
    {
        Cod_Producto: 1,
        Nombre: 'Tornillo x 1',
        Precio: 2,
    }
)
```
7. Crear un nuevo documento de producto que contenga un array. Con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 2 |
| Nombre | Martillo |
| Precio | 20 |
| Unidades | 50 |
| Fabricantes | fab1, fab2, fab3,fab4 |

```json
db.producto.insertOne(
    {
    Cod_producto: 2,
    Nombre: 'Martillo',
    Precio: 20,
    Unidades: 50,
    Fabricantes: ['fab1', 'fab2', 'fab3', 'fab4']
    }
)
```

8. Borrar la colección Facturas y comprobar que se borro

```json
db.facturas.drop()
show collections
```


9. Insertar un documento en una colección denominada **fabricantes**
   para probar los subdocumentos y la clave _id personalizada

| Codigo   | Valor   |
|-------------|-------------|
| id | 1 |
| Nombre | fab1 |
| Localidad | ciudad: buenos aires, pais: argentina, Calle: Calle pez 27,cod_postal:2900 |

```json
db.createCollection('fabricantes')
db.fabricantes.insertOne(
{
    _id: 1,
    Nombre: 'fab1',
    Localidad:
    {
        Ciudad: 'Buenos Aires',
        Pais: 'Argentina',
        Calle: 'Calle pez 27',
        Cod_Postal: 2900,
    }
}
)
```


10. Realizar una inserción de varios documentos en a colección
    productos

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 3 |
| Nombre | Alicates |
| Precio | 10 |
| Unidades | 25 |
| Fabricantes | fab1, fab2, fab5 |

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 4 |
| Nombre | Arandela |
| Precio | 1 |
| Unidades | 500 |
| Fabricantes | fab2, fab3, fab4 |

```json
db.createCollection('productos')
db.productos.insertMany(
[
    {
        Cod_producto: 3,
        Nombre: 'Alicantes',
        Precio: 10,
        Unidades: 25,
        Fabricantes: ['fab1', 'fab2', 'fab5']
    },
    {
        Cod_producto: 4,
        Nombre: 'Arandela',
        Unidades: 500,
        Fabricantes: ['fab2', 'fab3', 'fab4']
    }
]
)
```