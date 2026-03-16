set terminal wxt size 800,600 enhanced font 'Helvetica,12'

set xlabel 'fechas'
set ylabel 'Porcentaje de aumento'
set title 'Aumentos en algunos precios'
set grid

#Mover las leyendas arriba  a la izquierda, con fondo blanco y sin transparencia
set key box
set key left top vertical opaque width 1.5 height 1.5 

set xdata time
set timefmt "%m/%y"
set format x "%m/%y"

# Extraer la primer linea con head y usar awk para sacar el valor de la 2da columna ($2)
primervalorc2=system("awk 'FNR == 2 {print $2}' datos2.dat" )
primervalorc3=system("awk 'FNR == 2 {print $3}' datos2.dat" )
primervalorc4=system("awk 'FNR == 2 {print $4}' datos2.dat" )

# If the result needs to be treated as a number, add 0 to it
primervalorc2 = primervalorc2 + 0.
primervalorc3 = primervalorc3 + 0.
primervalorc4 = primervalorc4 + 0.

plot 'datos2.dat' u 1:($2/primervalorc2*100) w lp ps 3 t "Carne", \
'datos2.dat' u 1:($3/primervalorc3*100) w lp t "Boleto", \
'datos2.dat' u 1:($4/primervalorc4*100) w lp t "Manzana", \
'datos2.dat' u 1:($5/155*100) w lp t "sueldo",  ; pause mouse close

#Formato largo
# plot 'datos.dat' using 1:2 with points ps 5, \
#  'datos.dat' using 1:3 with points ps 5, \
#  f(x) with lines linewidth 4 linecolor rgb "blue" title 'linea', \
#  g(x) with lines


set terminal png
set output 'precios_porcentaje.png'
replot


