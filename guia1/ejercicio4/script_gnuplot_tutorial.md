# Tutorial: Uso de Scripts en Gnuplot

## Introducción
Gnuplot es una herramienta poderosa para la generación de gráficos a partir de datos y funciones matemáticas. Este tutorial explica cómo ejecutar un script de Gnuplot desde la línea de comandos y detalla cada parte del archivo `ej4.gp`.

---

## Cómo ejecutar un script de Gnuplot

1. **Abrir una terminal**: Asegúrate de estar en el directorio donde se encuentra el archivo `ej4.gp`.
2. **Ejecutar el script**: Usa el siguiente comando:

   ```bash
   gnuplot ej4.gp
   ```

   Esto ejecutará el script y generará las salidas especificadas en el archivo.

---

## Explicación del archivo `ej4.gp`

### Configuración inicial

```gnuplot
set terminal wxt size 800,600 enhanced font 'Helvetica,12' persist
```
- **`set terminal wxt`**: Define el terminal gráfico interactivo.
- **`size 800,600`**: Establece el tamaño de la ventana.
- **`enhanced font 'Helvetica,12'`**: Configura la fuente y el tamaño del texto.
- **`persist`**: Mantiene la ventana abierta después de ejecutar el script.

---

### Definición de funciones

```gnuplot
f(x)=0.5*x+1.
g(x)=0.4*x+1.2
```
- **`f(x)` y `g(x)`**: Define dos funciones lineales. Notar  que aun las constantes como $1$ se definen con un punto decimal para que gnuplot las interprete como numeros de punto flotante.

---

### Configuración de etiquetas y título

```gnuplot
set xlabel 'x'
set ylabel 'y'
set title 'Funciones lineales'
set grid
```
- **`set xlabel` y `set ylabel`**: Etiquetas para los ejes.
- **`set title`**: Título del gráfico.
- **`set grid`**: Activa una cuadrícula en el gráfico.

---

### Configuración de la leyenda

```gnuplot
set key box
set key left top vertical opaque width 1.5 height 1.5
```
- **`set key box`**: Muestra la leyenda dentro de un recuadro.
- **`set key left top`**: Posiciona la leyenda en la esquina superior izquierda.
- **`vertical`**: Organiza las entradas de la leyenda en columnas.
- **`opaque`**: Hace que el fondo de la leyenda sea opaco.
- **`width` y `height`**: Ajusta el tamaño del recuadro.

---

### Comando `plot`

```gnuplot
plot 'datos.dat' u 1:2 w p ps 5, \
     'datos.dat' u 1:3 w p, \
     f(x) w l lw 4 lc rgb "blue" t 'linea', \
     g(x) w l
```
- **`'datos.dat'`**: Archivo de datos a graficar.
- **`u 1:2`**: Usa la primera y segunda columna del archivo.
- **`w p`**: Dibuja puntos.
- **`ps 5`**: Tamaño de los puntos.
- **`f(x)` y `g(x)`**: Grafica las funciones definidas anteriormente.
- **`w l`**: Dibuja líneas.
- **`lw 4`**: Ancho de línea.
- **`lc rgb "blue"`**: Color de línea azul.
- **`t 'linea'`**: Título de la función en la leyenda.

---

### Generación de salidas

```gnuplot
set terminal png
set output 'p4.png'
replot
```
- **`set terminal png`**: Cambia el terminal a formato PNG.
- **`set output 'p4.png'`**: Especifica el archivo de salida.
- **`replot`**: Vuelve a graficar con la nueva configuración.

El script genera gráficos en varios formatos:

1. **PNG**: `p4.png`
2. **PDF**: `p4.pdf`
3. **PostScript blanco y negro**: `p4_byn.ps`
4. **PostScript color**: `p4_color.ps`
