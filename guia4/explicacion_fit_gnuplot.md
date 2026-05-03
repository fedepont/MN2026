# Ajuste no lineal y `fit.log` en Gnuplot  
## Desde Levenberg–Marquardt hasta la interpretación completa

---

# 1. Problema de mínimos cuadrados no lineales

Dado un conjunto de datos $(x_i, y_i)$, queremos ajustar un modelo:

$$
y = f(x; \theta)
$$

donde $\theta = (\theta_1, \theta_2, \dots, \theta_p)$ son parámetros.

Se define la función objetivo:

$$
S(\theta) = \sum_{i=1}^{N} r_i^2
\quad \text{con} \quad
r_i = y_i - f(x_i; \theta)
$$

El objetivo es:

$$
\min_\theta S(\theta)
$$

---

# 2. Método de Levenberg–Marquardt (LM)

## 2.1 Idea general

El método LM es un algoritmo iterativo para minimizar $S(\theta)$, combinando:

- Gauss–Newton (rápido cerca del mínimo)
- Descenso por gradiente (estable lejos del mínimo)

---

## 2.2 Linealización local

Cerca de un punto $\theta^{(k)}$, se aproxima:

$$
r(\theta + \Delta \theta) \approx r(\theta) + J \Delta \theta
$$

donde:

- $r$ es el vector de residuos
- $J$ es el Jacobiano:

$$
J_{i,j} = \frac{\partial r_i}{\partial \theta_j}
$$

---

## 2.3 Sistema a resolver

LM resuelve en cada iteración:

$$
(J^T J + \lambda I)\,\Delta \theta = J^T r
$$

donde:

- $J^T J$: aproximación del Hessiano
- $\lambda$: parámetro de amortiguación
- $I$: matriz identidad

---

## 2.4 Actualización

$$
\theta^{(k+1)} = \theta^{(k)} + \Delta \theta
$$

---

## 2.5 Rol del parámetro \(\lambda\)

- $\lambda \to 0$: comportamiento Gauss–Newton
- $\lambda$ grande: comportamiento tipo gradiente

Regla adaptativa:

- Si el paso mejora → disminuir $\lambda$
- Si empeora → aumentar $\lambda$

---

# 3. Cantidades internas del algoritmo

## 3.1 Residuos

$$
r_i = y_i - f(x_i;\theta)
$$

---

## 3.2 Jacobiano

$$
J_{i,j} = \frac{\partial r_i}{\partial \theta_j}
$$

---

## 3.3 Función objetivo

$$
S = \sum_i r_i^2
$$

---

## 3.4 Aproximación del Hessiano

$$
H \approx J^T J
$$

---

## 3.5 Matriz de covarianza

$$
\text{Cov}(\theta) \approx \sigma^2 (J^T J)^{-1}
$$

donde:

$$
\sigma^2 = \frac{S}{N - p}
$$

$N$ es el número de puntos y $p$ es la cantidad de parámetros de la función no lineal.

---

# 4. Estructura del `fit.log` de Gnuplot

---

## 4.1 Iteraciones

Ejemplo:

~~~
iter chisq delta/lim lambda
0 12.345678 0.00e+00 1.00e+00
1 3.456789 -6.40e-01 1.00e-01
2 1.567890 -5.46e-01 1.00e-02
~~~

### iter
Número de iteración.

---

### chisq

$$
\chi^2 = \sum_i r_i^2
$$

(si hay pesos: $r_i/\sigma_i$).

---

### delta/lim

Cambio relativo de la función objetivo:

$$
\frac{\Delta S}{S}
$$

Se usa como criterio de convergencia.

---

### lambda

Parámetro de amortiguación del algoritmo LM.

---

## 4.2 Parámetros finales
~~~
a = 2.03456 +/- 0.12345 (6.06%)
~~~

### Valor del parámetro
Resultado del ajuste.

---

### Error estándar

$$
\sigma_a = \sqrt{\text{Cov}(a,a)}
$$

en donde $\text{Cov}(a,b)=⟨(a−\bar{a})(b−\bar{b})⟩$ es la covarianza. Mide cómo cambian juntos cuando hay incertidumbre en el ajuste. 

Si $\text{Cov}(a,b)>0$ entonces cuando $a$ aumenta, $b$ aumenta.

Si $\text{Cov}(a,b)<0$ entonces cuando $a$ aumenta, $b$ disminuye.

Si $\text{Cov}(a,b)=0$ entonces cuando $a$ y $b$ son independientes. Lo que sería lo ideal en este contexto.

La covarianza depende de las unidades, por eso se usa más:

$$
\rho_{ab}=\frac{\text{Cov}(a,b)}{\sigma_a \sigma_b}
$$	​



---

### Error relativo

$$
\frac{\sigma_a}{a} \times 100 = (\%\, \textrm{de variación})
$$

---

## 4.3 Suma de cuadrados final

~~~
Final sum of squares of residuals : 1.23456
~~~

$$
S = \sum_i r_i^2
$$

---

## 4.4 Grados de libertad

Degrees of freedom (ndf) : 8


$$
\text{ndf} = N - p
$$

$N$ es el número de puntos y $p$ es la cantidad de parámetros de la función no lineal.

---

## 4.5 RMS de residuos

~~~
RMS of residuals : 0.39284
~~~

$$
\text{RMS} = \sqrt{\frac{S}{\text{ndf}}}
$$

---

## 4.6 Chi-cuadrado reducido
~~~
reduced chi-square = 0.15432
~~~

$$
\chi^2_{\text{red}} = \frac{\chi^2}{\text{ndf}}
$$

Interpretación:

- $\approx$ 1 → buen ajuste
- $\ll$ 1 → sobreajuste o errores grandes
- $\gg$ 1 → mal modelo o errores pequeños



---

## 4.7 Matriz de correlación

~~~
correlation matrix of the fit parameters:
    a     b
a 1.000
b -0.987 1.000
~~~

$$\rho_{ab}=\frac{\text{Cov}(a,b)}{\sigma_a \sigma_b}$$	​

Interpretación:

- $0$ → independientes
- $\pm1$ → altamente correlacionados

en donde $\text{Cov}(a,b)=⟨(a−\bar{a})(b−\bar{b})⟩$ es la covarianza. Mide cómo cambian juntos cuando hay incertidumbre en el ajuste. 

Si $\text{Cov}(a,b)>0$ entonces cuando $a$ aumenta, $b$ aumenta.

Si $\text{Cov}(a,b)<0$ entonces cuando $a$ aumenta, $b$ disminuye.

Si $\text{Cov}(a,b)=0$ entonces cuando $a$ y $b$ son independientes. Lo que sería lo ideal en este contexto.

La covarianza depende de las unidades, por eso se usa más la matriz de correlación.

---

## 4.8 Valores iniciales

~~~
initial values:
a = 1
b = 0.1
~~~

Condiciones iniciales del algoritmo.

---

## 4.9 Mensajes de convergencia


Indican el criterio de parada:

- convergencia alcanzada
- paso demasiado pequeño
- límite de iteraciones

---

# 5. Interpretación global

El `fit.log` refleja:

- Evolución de $S$
- Ajuste dinámico de $\lambda$
- Geometría local del mínimo (errores)
- Dependencia entre parámetros (correlaciones)

---
