import sqlite3
import csv

#Crear conexión
conn = sqlite3.connect('BBDD.sqlite')

#Obtener cursor
cursor = conn.cursor()

#Ejecutar sentencia de creacioón de la tabla
cursor.execute("CREATE TABLE GameSales(rank integer, name text PRIMARY KEY, platform text, year integer, genre text, publisher text, na_sales real, eu_sales real, jp_sales real, other_sales real)")
conn.commit()

#Abrir dataset
f = open('dataset.csv', 'r')
next(f, None)

#Leer dataset
reader = csv.reader(f, delimiter = ',')

#Insertar registros en la tabla
for row in reader:
    cursor.execute("INSERT or IGNORE INTO GameSales VALUES (?,?,?,?,?,?,?,?,?,?)", (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9]))

conn.commit()

#Seleccionar las filas que cumplan la condición
cursor.execute('SELECT name FROM GameSales WHERE platform = "Wii" AND other_sales BETWEEN 1 AND 5 LIMIT 20')
rows = cursor.fetchall()

#Imprimir por pantalla las filas seleccionadas
print("Filas seleccionadas:")
for row in rows:
    print(row)
    
#Actualizar el valor de la columna publisher de aquellas filas en las que platforfm sea PS3 
cursor.execute('UPDATE GameSales set publisher = "UPO" WHERE platform = "PS3" LIMIT 20')
conn.commit()

#Seleccionar el máximo valor de la columna na_sales
cursor.execute('SELECT MAX(na_sales) FROM GameSales')
max = cursor.fetchall()

#Imprimir por pantalla el valor máximo
print("\nValor máximo:", max)

#Cerrar conexión
conn.close()