# Errores comunes en programación Fortran — ejemplos mínimos

## Falta el `implicit none`

```fortran
program ejemplo
  x = 3.0
  print *, y
end program
```

---

## Falta indentación en `if-then-else` o `do-enddo`

```fortran
if (x > 0.0) then
print *, "positivo"
else
print *, "negativo"
endif
```

---

## Formatos incorrectos de salida

```fortran
real :: x = 3.14159
print '(I5)', x
```

---

## Repetición innecesaria de formatos

```fortran
print '(E17.9E2,E17.9E2,E17.9E2,E17.9E2,E17.9E2)', a,b,c,d,e
```

Mejor:

```fortran
print '(5(E17.9E2))', a,b,c,d,e
```

---

## Definición agrupada de variables sin organización

```fortran
real :: x, y, error, raiz, h, derivada, suma
integer :: i, j, n, iter
```

---

## Evaluar muchas veces la misma función

```fortran
if (f(x) > 0.0) then
  print *, f(x)
  y = f(x) + 1.0
endif
```

Mejor:

```fortran
fx=f(x)
if (fx > 0.0) then
  print *, fx
  y = fx + 1.0
endif
```
---

## Condición que nunca se evalúa a true o nunca cambia

```fortran
do i = 1, n
  if (i >= 1) then
    print *, i
  endif
  if (i >= n) then
    print *, i
  endif
enddo
```

---

## Faltan encabezados

```fortran
program ejercicio
```

Sin descripción del programa, autor, fecha, etc.

---

## Variables no inicializadas

Incorrecto:

```fortran
real :: suma

do i=1,n
    suma = suma + 1.0
enddo
```
Correcto:

```fortran
real :: suma

suma=0.0
do i=1,n
    suma = suma + 1.0
enddo
```
---

## Criterio de convergencia erróneo o incompleto

```fortran
do while (abs(x1-x0) > tol)
```
Pero es,
```fortran
err_rel=valor_inicial_de_errel

do while (err_rel > tol)
.
.
.
err_rel=abs((x1-x0)/(x1))
.
.
.
enddo
```


---

## Enteros definidos como `real`

```fortran
real :: i

do i = 1, 10
```

---

## No especificar precisión en números

```fortran
real(pr) :: x

x = 1.0/3.0
```

Mejor:

```fortran
x = 1.0_pr/3.0_pr
```

---

## Usar `dp` en lugar de `pr`

```fortran
integer, parameter :: dp = kind(1.d0)
```

Puede ser confuso si luego se cambia de precisión. Mejor definir ene l modulo esta variable como `pr`

---

## Código extra que no hace nada

```fortran
contains

function regula_falsi(x)
  real :: regula_falsi, x
  regula_falsi = x
end function
```

Nunca se usa.

---

## Variables definidas y no utilizadas

```fortran
real :: x, y, z

x = 1.0
y = 2.0
```

`z` nunca se usa.

---

## No cerrar archivos

```fortran
subroutine XXX
.
.
.
open(unit=10, file="datos.dat")

write(10,*) x
.
.
.
end subroutine XXX
```

Falta:

```fortran
close(10)
```

---

## No considerar división por cero

```fortran
y = 1.0/x
```

---

## Error en el cálculo de la derivada

Analítico, no de FORTRAN.

---

## Graficar error absoluto en lugar del relativo

```fortran
error = abs(x1-x0)
```

Cuando se pidió:

```fortran
error = abs((x1-x0)/x1)
```

---

## Decir que la secante converge cuadráticamente

```text
"La secante converge cuadráticamente."
```

Incorrecto: converge superlinealmente.

---

## No avisar si se alcanza `maxite`

```fortran
if (iter == maxite) exit
```

Sin mensaje de advertencia.

---

## Cálculo erróneo

```fortran
error = abs(x1-x0/x1)
```

Faltan paréntesis.

---

## No definir límite máximo de iteraciones

```fortran
do while (error > tol)
```

Puede quedar infinito.

---

## Subrutinas llaman directamente a funciones

```fortran
call biseccion(a,b)

contains

function f(x)
```

La función está fija dentro del código y no se pasa como argumento.
