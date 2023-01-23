from almacena import Almacen

if __name__ == "__main__":
    # Se crea el objeto Almacén.
    alm = Almacen()
    # Carga los datos del CSV.
    alm.fromCSV("13_GameSales.csv")

    # Imprime los registros cargados del CSV a la lista.
    print("Ventas de Videojuegos: ")
    print(alm.listadoVentas())

    # Da de alta una entrada de datos de ventas de un videojuego y muestra la salida por pantalla.
    print(alm.altaVenta("SuperPepe Bros", "Wee", 2022, "Aventura", "Acme", 14.2, 10.8, 2.8, 0.3))

    # Intenta volver a insertar el mismo juego en la lista y muestra la salida por pantalla.
    print(alm.altaVenta("SuperPepe Bros", "Wee", 2022, "Aventura", "Acme", 14.2, 10.8, 2.8, 0.3)+'\n')

    # Imprime los datos de ventas de los juegos publicados entre 2020 y 2022.
    print('Nombre' + "\t" + 'Plataforma' + "\t" + 'Año' + "\t" + 'Género' + "\t" + 'Publicado por' + "\t" + 'Ventas_NA'
          + "\t" + 'Ventas_EU' + "\t" + 'Ventas_JP' + "\t" + 'Ventas_Otro')
    for venta in alm.filtradoVentasFecha(2020, 2022):
        print(venta)
    print('\n')

    # Da de baja una entrada de la lista y muestra la salida por pantalla.
    print(alm.bajaVenta("SuperPepe Bros"))

    # Intenta dar de baja una entrada que no está en la lista.
    print(alm.bajaVenta("SuperPepe Bros"))

    # Exporta los datos guardados en la lista del almacén a un fichero CSV.
    alm.toCSV("ventaJuegos.csv")
