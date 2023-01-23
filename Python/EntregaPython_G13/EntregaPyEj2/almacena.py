import csv
from ventasVideojuegos import VentaVideoJuego


class Almacen:

    def __init__(self):
        # Se inicializa la lista
        self.datos = []

    def altaVenta(self, name, plata, year, genre, editor, salesna, saleseu, salesjp, salesot):
        encontrado = False
        # Bucle que comprueba si ya existe un videojuego con ese nombre en la lista.
        for venta in self.datos:
            if not encontrado:
                if venta.nombre == name:
                    encontrado = True
        # Si existe un videojuego con ese nombre en la lista, no se añade.
        if encontrado:
            return "DUPLICADO"
        # Si no existe, se añade.
        else:
            self.datos.append(VentaVideoJuego(name, plata, year, genre, editor, salesna, saleseu, salesjp, salesot))
            return "OK"

    def bajaVenta(self, name):
        hecho = False
        # Bucle que busca la entrada de la lista a borrar.
        for venta in self.datos:
            if not hecho:
                if venta.nombre == name:
                    hecho = True
                    self.datos.remove(venta)
        # Se devuelve OK si se ha borrado una entrada.
        if hecho:
            return "OK"
        # Se devuelve NO LOCALIZADO si no hay ninguna entrada con ese nombre.
        else:
            return "NO LOCALIZADO"

    def listadoVentas(self):
        # Devuelve un string con los datos de la lista en forma de tabla
        devolver = 'Nombre' + "\t" + 'Plataforma' + "\t" + 'Año' + "\t" + 'Género' + "\t" + 'Publicado por' + "\t" +\
                   'Ventas_NA' + "\t" + 'Ventas_EU' + "\t" + 'Ventas_JP' + "\t" + 'Ventas_Otro' + '\n'
        for venta in self.datos:
            devolver += venta.__str__()
            devolver += '\n'

        return devolver

    def filtradoVentasFecha(self, anno1, anno2):
        # Algunas entradas tiene un String en el campo de año de publicación, saco esas entradas, ya que dan problemas.
        aux = list(filter(lambda venta: isinstance(venta.anno, int), self.datos))
        # Utilizo filter() para conseguir una lista formada por las entradas que están entre los años de publicación
        # dados.
        if anno1 == anno2:
            devolver = list(filter(lambda venta: venta.anno == anno1, aux))
        elif anno1 < anno2:
            devolver = list(filter(lambda venta: anno1 <= venta.anno <= anno2, aux))
        else:
            devolver = list(filter(lambda venta: anno2 <= venta.anno <= anno1, aux))
        # Devuelvo la lista.
        return devolver

    def fromCSV(self, pathcsv):
        # Abre el fichero.
        fh = open(pathcsv, "r")
        # Utilizo la funcionalidad del paquete csv para leer el fichero más fácilmente.
        leeCSV = csv.reader(fh, delimiter=',')
        # Salta la primera línea del fichero, que tiene los nombres de las columnas.
        next(leeCSV)
        for line in leeCSV:
            # Bucle que recorre el fichero y añade las entradas a la lista.
            aux = VentaVideoJuego(line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9])
            self.datos.append(aux)

    def toCSV(self, pathcsv):
        # Abre el fichero.
        fh = open(pathcsv, "w", encoding='UTF8')
        # Utilizo la funcionalidad del paquete csv para escribir el fichero más fácilmente.
        escribeCSV = csv.writer(fh, delimiter=',')
        # Escribo el header.
        escribeCSV.writerow(['Nombre', 'Plataforma', 'Año', 'Género', 'Publicado por', 'Ventas_NA', 'Ventas_EU',
                             'Ventas_JP', 'Ventas_Otro'])
        for venta in self.datos:
            # Bucle que va añadiendo las entradas de la lista al fichero.
            escribeCSV.writerow([venta.nombre, venta.plataforma, venta.anno, venta.genero, venta.publicado,
                                 venta.ventasNa, venta.ventasEu, venta.ventasJp, venta.ventasOt])
