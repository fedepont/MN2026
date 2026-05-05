# Incertidumbres en un ajuste lineal sin incertidumbres explícitas

En un **ajuste lineal** se busca una recta de la forma:

$$
y = ax + b
$$

donde:

- $a$ es la **pendiente**.
- $b$ es la **ordenada al origen**.
- $x_i, y_i$ son los datos medidos.

Aunque los datos no tengan incertidumbres explícitas, el ajuste puede estimar una incertidumbre usando la **dispersión de los puntos alrededor de la recta**.


---

## 1. Cálculo de la recta ajustada

Para $N$ puntos $(x_i, y_i)$, la pendiente y la ordenada al origen se pueden escribir como:

$$
a =
\frac{\sum_i (x_i-\bar{x})(y_i-\bar{y})}
{\sum_i (x_i-\bar{x})^2}
\\ {}
\\= \frac{\sum_i (x_i-\bar{x})y_i + \sum_i(x_i-\bar{x})\bar{y}}
{\sum_i (x_i-\bar{x})^2}
\\ {}
\\= \frac{\sum_i (x_i-\bar{x})y_i + (\sum_i(x_i)-N\bar{x})\bar{y}}
{\sum_i (x_i-\bar{x})^2}
\\ {}
\\= \frac{\sum_i (x_i-\bar{x})y_i + (N\bar{x}-N\bar{x})\bar{y}}
{\sum_i (x_i-\bar{x})^2}
\\ {}
\\=\frac{\sum_i (x_i-\bar{x})y_i}
{\sum_i (x_i-\bar{x})^2}
$$

$$
b = \bar{y} - a\bar{x}
$$

donde $\bar{x}$ y $\bar{y}$ son los promedios de los datos.

También se define:

$$
S_{xx} = \sum_i (x_i-\bar{x})^2 \equiv  \sum_i (x_i-\bar{x})(x_i-\bar{x}) \equiv (N-1) \textrm{Cov}(x,x) \equiv (N-1)\textrm{Var(x)}
$$

---

## 2. ¿De dónde sale la incertidumbre si los datos no tienen incertidumbre?

Si no se conoce la incertidumbre de cada punto, se supone que todos los puntos tienen una dispersión similar respecto de la recta. Esa dispersión se estima con los **residuos**:

$$
r_i = y_i - (ax_i+b)
$$

Luego se calcula la desviación típica residual:

$$
s =
\sqrt{
\frac{\sum_i r_i^2}{N-2}
}
$$

El factor $N-2$ aparece porque el ajuste ya usó dos parámetros: $a$ y $b$.

Esta cantidad $s$ se usa como estimación de la incertidumbre común $\sigma$ de los puntos en la dirección $y$.

---

# Incertidumbre de la pendiente

## 3. Fórmula de la incertidumbre de la pendiente

La incertidumbre de la pendiente es:

$$
\sigma_a =
\frac{s}
{\sqrt{\sum_i (x_i-\bar{x})^2}}
$$

Usando $S_{xx}$:

$$
\sigma_a = \frac{s}{\sqrt{S_{xx}}}
$$

---

## 4. Derivación de la incertidumbre de la pendiente

Se parte de que la pendiente ajustada por mínimos cuadrados puede escribirse como:

$$
a =
\frac{1}{S_{xx}}
\sum_i (x_i-\bar{x})y_i
$$

Esto muestra que $a$ es una combinación lineal de los $y_i$.

Aplicando propagación de errores con derivadas parciales:

$$
\sigma_a^2 =
\sum_i
\left(
\frac{\partial a}{\partial y_i}
\right)^2
\sigma_{y_i}^2
$$

Como:

$$
\frac{\partial a}{\partial y_i}=
\frac{x_i-\bar{x}}{S_{xx}}
$$

Ahora para simplificar asumamos por un momento que todas las incertidumbres $\sigma_{y_i}$ son iguales:

$$
\sigma_{y_i}=\sigma
$$

por lo tanto

$$
\sigma_a^2 =
\sum_i
\left(
\frac{x_i-\bar{x}}{S_{xx}}
\right)^2
\sigma^2
$$

$$
\sigma_a^2 =
\frac{\sigma^2}{S_{xx}^2}
\sum_i (x_i-\bar{x})^2
= \frac{\sigma^2}{S_{xx}^2}
S_{xx}
=\frac{\sigma^2}{S_{xx}}
$$

Por lo tanto:

$$
\sigma_a =
\frac{\sigma}{\sqrt{S_{xx}}}
$$

Como normalmente no conocemos $\sigma$, se reemplaza por la estimación de la desviación típica de los residuos $s$:

$$
\sigma_a =
\frac{s}{\sqrt{S_{xx}}}
$$

---

## 5. Interpretación de la incertidumbre de la pendiente

La incertidumbre de la pendiente mide cuánto podría variar la pendiente si se repitiera el experimento con datos similares.

Si:

$$
a = 2.50 \pm 0.10
$$

significa que la pendiente estimada es $2.50$, pero valores como $2.40$ o $2.60$ serían razonables dentro de la dispersión de los datos.

La fórmula:

$$
\sigma_a = \frac{s}{\sqrt{S_{xx}}}
$$

muestra que la incertidumbre depende de dos cosas:

1. El numerador $s$, que mide cuánto se dispersan los puntos alrededor de la recta.
2. El denominador $S_{xx}$, que mide cuánto están separados los valores de $x$.

Si los puntos están muy dispersos, $s$ es grande y la pendiente queda peor determinada.

Si los valores de $x$ cubren un rango grande, $S_{xx}$ es grande y la pendiente queda mejor determinada.

---

# Incertidumbre de la ordenada al origen

## 6. Fórmula de la incertidumbre de la ordenada al origen

La incertidumbre de la ordenada al origen es:

$$
\sigma_b =
s
\sqrt{
\frac{1}{N}
+
\frac{\bar{x}^2}{\sum_i (x_i-\bar{x})^2}
}
$$

Usando $S_{xx}$:

$$
\sigma_b =
s
\sqrt{
\frac{1}{N}
+
\frac{\bar{x}^2}{S_{xx}}
}
$$

---

## 7. Derivación de la incertidumbre de la ordenada al origen

Partimos de:

$$
b = \bar{y} - a\bar{x}
$$

La pendiente ajustada es:

$$
a =
\frac{\sum_i (x_i-\bar{x})y_i}{S_{xx}}
$$

Entonces:

$$
b =
\bar{y}
-
\bar{x}
\frac{\sum_i (x_i-\bar{x})y_i}{S_{xx}}
$$

Como:

$$
\bar{y} = \frac{1}{N}\sum_i y_i
$$

queda:

$$
b =
\sum_i
\left[
\frac{1}{N}
-
\frac{\bar{x}(x_i-\bar{x})}{S_{xx}}
\right] y_i
$$

Esto muestra que $b$ también es una combinación lineal de los $y_i$.

Aplicamos propagación de errores:

$$
\sigma_b^2 =
\sum_i
\left(
\frac{\partial b}{\partial y_i}
\right)^2
\sigma_{y_i}^2
$$

La derivada es:

$$
\frac{\partial b}{\partial y_i}
=
\frac{1}{N}
-
\frac{\bar{x}(x_i-\bar{x})}{S_{xx}}
$$

Si todos los puntos tienen la misma incertidumbre en $y$:

$$
\sigma_{y_i}=\sigma
$$

entonces:

$$
\sigma_b^2 =
\sigma^2
\sum_i
\left[
\frac{1}{N}
-
\frac{\bar{x}(x_i-\bar{x})}{S_{xx}}
\right]^2
$$

Expandimos el cuadrado:

$$
\sigma_b^2 =
\sigma^2
\sum_i
\left[
\frac{1}{N^2}
-
\frac{2\bar{x}}{N S_{xx}}(x_i-\bar{x})
+
\frac{\bar{x}^2}{S_{xx}^2}(x_i-\bar{x})^2
\right]
$$

Usamos las identidades:

$$
\sum_i (x_i-\bar{x}) = 0
$$

$$
\sum_i (x_i-\bar{x})^2 = S_{xx}
$$

Entonces:

$$
\sigma_b^2 =
\sigma^2
\left[
\frac{N}{N^2}
+
0
+
\frac{\bar{x}^2}{S_{xx}^2}S_{xx}
\right]
$$

$$
\sigma_b^2 =
\sigma^2
\left[
\frac{1}{N}
+
\frac{\bar{x}^2}{S_{xx}}
\right]
$$

Por lo tanto:

$$
\sigma_b =
\sigma
\sqrt{
\frac{1}{N}
+
\frac{\bar{x}^2}{S_{xx}}
}
$$

Como normalmente no conocemos $\sigma$, usamos la estimación a partir de los residuos:

$$
s =
\sqrt{
\frac{\sum_i r_i^2}{N-2}
}
$$

Entonces:

$$
\sigma_b =
s
\sqrt{
\frac{1}{N}
+
\frac{\bar{x}^2}{S_{xx}}
}
$$

---

## 8. Interpretación de la incertidumbre de la ordenada al origen

La incertidumbre de $b$ mide cuán bien está determinado el valor de la recta en $x=0$.

Si:

$$
b = 1.2 \pm 0.5
$$

significa que el corte con el eje $y$ no está determinado con tanta precisión.

La fórmula:

$$
\sigma_b =
s
\sqrt{
\frac{1}{N}
+
\frac{\bar{x}^2}{S_{xx}}
}
$$

contiene dos contribuciones:

### Término $1/N$

$$
\frac{1}{N}
$$

Este término disminuye al tener más puntos.

### Término $\bar{x}^2/S_{xx}$

$$
\frac{\bar{x}^2}{S_{xx}}
$$

Este término aparece porque:

$$
b = \bar{y} - a\bar{x}
$$

Entonces la incertidumbre de la pendiente también afecta a la ordenada al origen.

Cuanto más lejos esté el promedio de los datos de $x=0$, más se amplifica la incertidumbre de $a$ al extrapolar hasta el eje $y$.

Por eso, si tus datos están cerca de $x=0$, $b$ suele quedar bien determinado. Si todos tus datos están lejos de $x=0$, la ordenada al origen puede tener una incertidumbre grande, aunque la recta ajuste bastante bien.

---

# Resumen final

Para un ajuste lineal:

$$
y = ax + b
$$

se calculan los residuos:

$$
r_i = y_i - (ax_i+b)
$$

La desviación residual es:

$$
s =
\sqrt{
\frac{\sum_i r_i^2}{N-2}
}
$$

La incertidumbre de la pendiente es:

$$
\sigma_a =
\frac{s}{\sqrt{\sum_i (x_i-\bar{x})^2}}
$$

La incertidumbre de la ordenada al origen es:

$$
\sigma_b =
s
\sqrt{
\frac{1}{N}
+
\frac{\bar{x}^2}{\sum_i (x_i-\bar{x})^2}
}
$$

Ambas fórmulas pueden entenderse como una aplicación de **propagación de errores**, asumiendo que todos los puntos tienen la misma incertidumbre en $y$ y que esa incertidumbre puede estimarse a partir de la dispersión de los residuos.

