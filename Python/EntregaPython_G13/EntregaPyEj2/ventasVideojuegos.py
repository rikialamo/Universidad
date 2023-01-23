class VentaVideoJuego:

    def __init__(self, name, plata, year, genre, editor, salesna, saleseu, salesjp, salesot):
        # Se inicializan los atributos
        self.nombre = name
        self.plataforma = plata
        # El casting a int puede dar problemas porque algunas entradas tienen un año de publicación no definido, es
        # decir, la entrada tiene "N/A" en el campo del año, lo que no puede pasarse a int.
        # El casting a int del año es necesario para el filtrado en Almacén.
        try:
            self.anno = int(year)
        except ValueError:
            self.anno = "N/A"
        self.genero = genre
        self.publicado = editor
        self.ventasNa = float(salesna)
        self.ventasEu = float(saleseu)
        self.ventasJp = float(salesjp)
        self.ventasOt = float(salesot)

    def __str__(self):
        return self.nombre + "\t" + self.plataforma + "\t" + str(self.anno) + "\t" + self.genero + "\t" +\
               self.publicado + "\t" + str(self.ventasNa) + "\t" + str(self.ventasEu) + "\t" + str(self.ventasJp) +\
               "\t" + str(self.ventasOt)
