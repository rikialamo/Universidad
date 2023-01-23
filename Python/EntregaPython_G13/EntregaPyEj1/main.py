import csv
dic = {}


def vista():
    # Función que muestra el menú con el que se interactúa por terminal, y que lleva a cabo las funciones del menú
    # también, porque son bastante simples.
    barra = "-" * 12
    print(barra)
    print("----Menú----")
    print(barra)
    opciones = 'Opciones:\n1. Agregar un nuevo videojuego \n2. Buscar un videojuego por nombre y mostrar sus valores ' \
               '\n3. Borrar un videojuego a partir de su clave \n4. Listar todos los videojuegos en formato de tabla' \
               '\n5. Salir '
    opc = 0
    while opc != 5:
        print(opciones)
        opc = int(input("Seleccione una opción: "))

        if opc == 1:
            print("Insertar nuevo juego.")
            # Datos del juego.
            nombre = input("Nombre: ")
            if nombre in dic.keys():
                print("Ese juego ya se ha introducido.")
            else:
                plat = input("Plataforma: ")
                anno = input("Año: ")
                gen = input("Género: ")
                editor = input("Publicado por: ")
                print("Ventas (en millones)")
                ventasNA = input("Ventas en Norteamérica: ")
                ventasEU = input("Ventas en Europa: ")
                ventasJP = input("Ventas en Japón: ")
                ventasO = input("Ventas en otras regiones: ")
                dic[nombre] = (nombre, plat, anno, gen, editor, ventasNA, ventasEU, ventasJP, ventasO)

        elif opc == 2:
            print("Buscar registro.")
            nombre = input("Nombre: ")
            if nombre in dic.keys():
                print(dic[nombre])
            else:
                print("Error: Juego no registrado.")

        elif opc == 3:
            print("Borrar registro.")
            nombre = input("Nombre: ")
            if nombre in dic.keys():
                dic.pop(nombre)
            else:
                print("Error: Juego no registrado.")
        elif opc == 4:
            print("Listar registros.")
            strFormat = "{:<80} " + "{:<15} " * 3 + "{:<40} " + "{:<15} " * 4
            print(strFormat.format('Nombre', 'Plataforma', 'Año', 'Género', 'Publicado por', 'Ventas_NA', 'Ventas_EU',
                                   'Ventas_JP', 'Ventas_Otro'))
            for key in dic.keys():
                atributos = dic[key]
                if len(key) < 80:
                    x = key
                else:
                    x = key[:75] + "..."
                print(strFormat.format(x, atributos[1], atributos[2], atributos[3], atributos[4],
                                       atributos[5], atributos[6], atributos[7], atributos[8]))

        elif opc == 5:
            print("Salir.")
        else:
            print("Opción no válida.")


def leer():  # Función que pasa el csv a un diccionario.
    # Abre el fichero.
    fh = open("13_GameSales.csv", "r", encoding='UTF8')
    leeCSV = csv.reader(fh, delimiter=',')
    # Salta la primera línea del fichero, que tiene los nombres de las columnas.
    next(leeCSV)
    # Bucle que añade las entradas al diccionario
    for line in leeCSV:
        dic[line[1]] = (line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9])
    fh.close()


if __name__ == "_main_":
    leer()
    vista()
