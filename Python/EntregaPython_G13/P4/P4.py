#Diccionario
juegos = {
        'Wii Sports': (1, 'Wii Sports', 'Wii', 2006, 'Sports', 'Nintendo', 41.49, 29.02, 3.77, 8.46),
        'Super Mario Bros.': (2, 'Super Mario Bros.', 'NES', 1985, 'Platform', 'Nintendo', 29.08, 3.58, 6.81, 0.77),
        'Mario Kart Wii': (3, 'Mario Kart Wii', 'Wii', 2008, 'Racing', 'Nintendo', 15.85, 12.88, 3.79, 3.31),
        'Wii Sports Resort': (4, 'Wii Sports Resort', 'Wii', 2009, 'Sports', 'Nintendo', 15.75, 8.89, 3.28, 2.96),
        'Pokemon Red/Pokemon Blue': (5, 'Pokemon Red/Pokemon Blue', 'GB', 1996, 'Wii', 'Role-Playing', 'Nintendo', 11.27, 10.22, 1)
    }

#Función que imprime los juegos en los que la plataforma es la Wii
def filtro(juegos):
    #Usamos la función lambda para seleccionar un valor en la posición indicada en la tupla que conforma los valores del diccionario y con la función filter, filtramos el diccioanrio en base a la función lambda
    print(dict(filter(lambda x: x[1][2] == "Wii", juegos.items())))

#Función que imprime el campo other_sales duplicado 
def doble(juegos):
    #Usamos la función lambda para sumar el valor de la posición indicada a sí mismo y con la función map, aplicamos la función lambda al diccionario y devuelve un nuevo diccionario
    print(dict(map(lambda x: (x[0], x[1][9] + x[1][9]), juegos.items())))

if __name__ == "__main__":
    print("Juegos en los que la plataforma es Wii:")
    filtro(juegos)
    print("Juegos con other_sales duplicado:")
    doble(juegos)
