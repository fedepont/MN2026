## Acumulación de errores en sumas de punto flotante

Se pide calcular en precision simple las siguientes sumas equivalentes en algebra exacta,

 a) $10^6*0.1$
 
 b) $\sum_{1}^{10^6} 0.1$

 c) $\sum_{1}^{1000}\left(\sum_{1}^{1000}0.1\right)$

 Si hacemos eso se obtiene,

 ```
 a) 100000.000       b) 100958.344       c) 99999.8359
 ```
Es decir la suma b tiene un error relativo del $0.96\%$, mientras que la c tiene un $0.00016\%$.

### Primer termino de la suma

Luego de la primer suma (0.1+0.1), si le pedimos a fortran muchos mas digitos de los permitidos para simple precision tenemos,

```
0.100000001490116119384765625000
```
y el producto 2*0.1 da

```
0.100000001490116119384765625000
```
es decir exactamente lo mismo. La representacion en precision simple de Fortran es $\mathbb{F}(2,24,-125,128)\equiv F_s$ en donde $\mathbb{F}$(base, mantisa, menor exp, mayor exp).

Esos numeros extras que aparecen tiene que ver con que los numeros de punto flotante son finitos y $0.1$ no es un numero de punto flotante representable exactamente. De hecho su representacion binaria es periódica, por lo que indefectiblemente queda truncada al pasar a binario. 

$$
(0.1)_{10}=(0.000\overline{1100})_2
$$

La representacion que tendremos de 0.1 en $F_s$ es entonces,

$$0.1100\, 1100\, 1100\, 1100\, 1101\times 2^{-3}$$

y, (ya no tan) sorprendentemente si pasamos ese numero a decimal obtenemos

$0.100000001490116119384765625$

Este es el numero mas cercano a 0.1 en la representacion $F_2$.

### Primeros terminos de la suma

Los siguientes terminos dan,

```
1 0.100000001490116119384765625000 0.100000001490116119384765625000
2 0.200000002980232238769531250000 0.200000002980232238769531250000
3 0.300000011920928955078125000000 0.300000011920928955078125000000
4 0.400000005960464477539062500000 0.400000005960464477539062500000
5 0.500000000000000000000000000000 0.500000000000000000000000000000
6 0.600000023841857910156250000000 0.600000023841857910156250000000
7 0.700000047683715820312500000000 0.699999988079071044921875000000
8 0.800000071525573730468750000000 0.800000011920928955078125000000
9 0.900000095367431640625000000000 0.900000035762786865234375000000
10 1.000000119209289550781250000000 1.000000000000000000000000000000
```

La primer columna es el numero de termino, la segunda la suma secuencial y la tercera la multiplicacion de la primera por 0.1 en $F_2$.

Vemos que al pasar de $n=1$ a $n=2$, se suma el "error". Pero en $n=3$ ya no sucede eso. Esto se debe a que la suma se realiza en la representacion binaria, y los resultados pueden diferir de hacerlos en decimal ya que siempre tenemos representaciones de cada numero en $F_2$.

En particular $n=5$ es "Exacto". Sucede que justo se da que la suma de esos primeros 5 terminos da un $2^{-1}$ que pertenece al conjunto de numeros $F_2$ y por lo tanto es representable exactamente.

Todo esto es en general muy dependiente del valor $0.1$. De hecho, puede hacer la prueba, si lo cambia los valores van a cambiar.


### Analisis de la sumas

El error que se comete en la multiplicacion es mucho menor, ya que es una sola operacion, por lo tanto el resultado a) es muy preciso. El b) se aleja considerablemente y el c) es mejor. La razon de ello es que se realiza la suma solo mil veces, en lugar de un millon de veces, ese numero tiene error, pero mucho menor que el otro. Ademas luego sumamos numeros grandes entre si. Esto hace que no perdamos cifras significativas, ya que si sumamos 1000000.0 + 0.1 necesitamos al menos 8 cifras significativas lo cual esta en el borde de lo que podemos representar en $F_2$, $\approx 10^{-8}$.

## Error en 0.1

El intervalo de exponentes en que cae 0.1 en $F_2$ es (ver apunte de santamaria)

$[2^{e},2^{e+1}]=[2^{-4},2^{-3}]=[0.0625,0.125]$

el espaciamiento de numeros en $F_2$ en ese intervalo es $2^{-(t-1)-e}=2^{-27}$ lo que es equivalente a $10^{-8.129}$ aproximadamente. Ese es el error que aparece en general en cada suma, por lo tanto si sumamos un millon de veces,

$$10^6 \times 10^{-8} \approx 0.01 \equiv 1.0 \%$$

## Otra estrategia

La lista 

```
1 0.100000001490116119384765625000 0.100000001490116119384765625000
2 0.200000002980232238769531250000 0.200000002980232238769531250000
3 0.300000011920928955078125000000 0.300000011920928955078125000000
4 0.400000005960464477539062500000 0.400000005960464477539062500000
5 0.500000000000000000000000000000 0.500000000000000000000000000000
6 0.600000023841857910156250000000 0.600000023841857910156250000000
7 0.700000047683715820312500000000 0.699999988079071044921875000000
8 0.800000071525573730468750000000 0.800000011920928955078125000000
9 0.900000095367431640625000000000 0.900000035762786865234375000000
10 1.000000119209289550781250000000 1.000000000000000000000000000000
```

nos hace ver una posible estrategia de mejoría. Para $n=5$, la representacion es exacta. Lo que nos hace sospechar que si hacemos,

$\sum_{1}^{200000}\left(\sum_{1}^{5}0.1\right)$

quizas obtengamos mas precision, ya que cada suma interna es exacta. De hecho, el resultado es,

```
100000.000000000000000000000000000000
```

Es decir, es exacto.