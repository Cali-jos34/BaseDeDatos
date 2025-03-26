select pr.Descripcion, pr.Precio, pr.Id_fab, pe.Fab, pr.Id_producto,pe.Producto from Pedidos as pe
inner join Productos as pr
on pe.Fab = pr.Id_fab
and pe.Producto = pr.Id_producto
