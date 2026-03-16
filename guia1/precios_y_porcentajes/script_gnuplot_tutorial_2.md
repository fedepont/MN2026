# Tutorial: Uso de Scripts en Gnuplot (Parte 2)

## Introducción
Este tutorial complementa el archivo `script_gnuplot_tutorial.md` y explica las características adicionales del script `precios_porcentaje.gp`. Solo se detallan los aspectos que no fueron cubiertos en el tutorial anterior.

---

## Explicación del archivo `precios_porcentaje.gp`

### Configuración de datos temporales

En los datos descriptos en datos2.dat, tenemos fechas. Aquí vemos brevemente como tratar esos tipos de datos.

```gnuplot
set xdata time
set timefmt "%m/%y"
set format x "%m/%y"
```
- **`set xdata time`**: Indica que los datos en el eje x son de tipo temporal.
- **`set timefmt`**: Especifica el formato de las fechas en los datos (`%m/%y` para mes/año).
- **`set format x`**: Define cómo se mostrarán las fechas en el eje x.

---

### Uso de `system` para extraer valores

Queremos hacer un gráfico de los datos de aumento en forma porcentual. Para ello queremos extraer el primer dato y basar el aumento respecto de ese dato para cada columna. `awk` es un procesador de linea de comando, que se usa aquí para guardar la segunda linea de cada columna.

```gnuplot
primervalorc2=system("awk 'FNR == 2 {print $2}' datos2.dat" )
primervalorc3=system("awk 'FNR == 2 {print $3}' datos2.dat" )
primervalorc4=system("awk 'FNR == 2 {print $4}' datos2.dat" )
```
- **`system`**: Ejecuta comandos del sistema operativo desde Gnuplot.
- **`awk 'FNR == 2 {print $2}'`**: Extrae el valor de la segunda columna en la segunda línea del archivo `datos2.dat`. `$2` indica la segunda columna.
- **`primervalorc2`, `primervalorc3`, `primervalorc4`**: Almacenan los valores iniciales de las columnas 2, 3 y 4, respectivamente.

### Conversión a números

```gnuplot
primervalorc2 = primervalorc2 + 0.
primervalorc3 = primervalorc3 + 0.
primervalorc4 = primervalorc4 + 0.
```
- **`+ 0.`**: Convierte los valores extraídos a números para realizar cálculos.

---

### Comando `plot` con cálculos

```gnuplot
plot 'datos2.dat' u 1:($2/primervalorc2*100) w lp ps 3 t "Carne", \
     'datos2.dat' u 1:($3/primervalorc3*100) w lp t "Boleto", \
     'datos2.dat' u 1:($4/primervalorc4*100) w lp t "Manzana", \
     'datos2.dat' u 1:($5/155*100) w lp t "sueldo",  ; pause mouse close
```
- **`u 1:($2/primervalorc2*100)`**: Calcula el porcentaje relativo de la columna 2 respecto a su valor inicial.
- **`w lp`**: Dibuja líneas y puntos.
- **`t "Carne"`**: Etiqueta para la leyenda.
- **`pause mouse close`**: Pausa la ejecución hasta que se cierre la ventana con el mouse.

---

### Generación de salida

```gnuplot
set terminal png
set output 'precios_porcentaje.png'
replot
```
- **`set terminal png`**: Cambia el terminal a formato PNG.
- **`set output 'precios_porcentaje.png'`**: Especifica el archivo de salida.
- **`replot`**: Vuelve a graficar con la nueva configuración.

---

## Conclusión
Este tutorial complementa el anterior explicando características avanzadas como el manejo de datos temporales, el uso de comandos del sistema y cálculos dinámicos en Gnuplot.