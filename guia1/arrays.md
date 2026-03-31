# Arrays en Fortran Moderno

Los arrays son estructuras fundamentales en Fortran que permiten almacenar y manipular colecciones de datos del mismo tipo. A continuación, se describen los conceptos básicos, el uso y las formas comunes de iterar sobre arrays en Fortran moderno.

---

## 1. **Definición de Arrays**
En Fortran, los arrays se pueden definir con dimensiones específicas. Por ejemplo:

```fortran
integer, dimension(5) :: array1D
real, dimension(3,2) :: array2D
character, dimension(3,4,5) :: tensor
```
- `array1D`: Un array unidimensional con 5 elementos.
- `array2D`: Un array bidimensional con 3 filas y 2 columnas.
- `tensor`: Un array tridimensional con 3, 4, 5. Esto es en realidad lo que se llama un tensor. 

También se pueden inicializar directamente:

```fortran
integer, dimension(3) :: array = [1, 2, 3]
```
### Asignacion de las dimensiones en runtime

En muchos casos no conocemos de antemano el tamaño de los vectores o matrices que vamos a tener. Para esos casos existe el par `allocate` y `allocatable`

```fortran
real, allocatable :: A(:,:)

read(*,*) N,M

allocate(A(N,M))
```

Primero definimos un cierto tensor del cual conocemos solo el rango (vector, matriz, tensor, etc), como una variable ` allocatable`. Luego, mientras el codigo esta corriendo se ingresan los valores de las dimensiones de filas `N` y columnas `M` y asignamos esos valores a las dimensiones de la matriz con `allocate(A(N,M))`
 
---

## 2. **Uso de Arrays**
### Asignación de Valores
Los valores de un array se pueden asignar de forma individual o en bloque:

```fortran
array1D(1) = 10
array1D = [10, 11, 12, 13, 14]  ! Asignación en bloque
```

### Acceso a Elementos
Se accede a los elementos de un array utilizando índices:

```fortran
print*, array1D(i)  ! Imprime el elemento i
```

---

## 3. **Iteración sobre Arrays**
### Usando Bucles `do`
El bucle `do` es una forma común de iterar sobre los elementos de un array:

```fortran
integer :: i

! Iterar sobre un array unidimensional
do i = 1, size(array1D)
    print*, 'Elemento ', i, ': ', array1D(i)
end do
```

### Sobre el orden de los índices en Fortran.

En fortran los índices de los arrays bidimensionales toman el sentido siguiente,

$$\begin{bmatrix} 
A(1,1) & A(1,2) & A(1,3) \\
A(2,1) & A(2,2) & A(2,3) 
\end{bmatrix}$$

Es decir `A(i,j)` indica la fila `i` y la columna `j` de la matriz A.  


### Iteración sobre Arrays Multidimensionales
Para arrays multidimensionales, se pueden usar bucles anidados:

```fortran
integer :: i, j

! Iterar sobre un array bidimensional
do i = 1, size(array2D, 1)  ! Iterar sobre filas
    do j = 1, size(array2D, 2)  ! Iterar sobre columnas
        print*, 'Elemento (', i, ',', j, '): ', array2D(i, j)
    end do
end do
```

### Usando Bucles `forall`
El bucle `forall` permite realizar operaciones en paralelo sobre arrays:

```fortran
forall (i = 1:size(array1D))
    array1D(i) = array1D(i) * 2
```

---

## 4. **Operaciones Comunes con Arrays**
Fortran moderno incluye muchas operaciones útiles para trabajar con arrays:

### Reducción
```fortran
sum(array1D)  ! Suma de todos los elementos
maxval(array1D)  ! Valor máximo
minval(array1D)  ! Valor mínimo
```

### Operaciones Elementales
```fortran
array1D = array1D + 1  ! Incrementar todos los elementos en 1
array1D = array1D * 2  ! Multiplicar todos los elementos por 2
```

### Manipulación de Arrays Multidimensionales
```fortran
transpose(array2D)  ! Transponer un array bidimensional
reshape([1, 2, 3, 4], [2, 2])  ! Cambiar la forma del array
```
Veamos como funciona un `reshape`
```fortran
integer, dimension(6) :: array = [1, 2, 3, 4, 5, 6]
integer, dimension(2, 3) :: reshaped_array

! Cambiar la forma del array a 2 filas y 3 columnas
reshaped_array = reshape(array, [2, 3])

print*, 'Array reestructurado:'
do i = 1, 2
    print*, reshaped_array(i, :)
end do
```
En este ejemplo, el array unidimensional `[1, 2, 3, 4, 5, 6]` se transforma en un array bidimensional con 2 filas y 3 columnas:
```
1  2  3
4  5  6
```

---

## 5. **Array Slicing**
El slicing permite acceder a subconjuntos de un array utilizando rangos de índices. Esto es útil para manipular partes específicas de un array y para definirlos.

### Ejemplo de Slicing
```fortran
integer, dimension(5) :: array = [11, 12, 13, 14, 15]
integer, dimension(3) :: subarray

! Extraer los elementos 2, 3 y 4 del array
subarray = array(2:4)
print*, 'Subarray: ', subarray
```
En este ejemplo, `subarray` contendrá los valores `[12, 13, 14]`.

Otro ejemplo puede servir para definir los elementos,
```fortran
integer, dimension(6) :: array 

array(1::2) = 1
array(2::2) = 0
```

Este ejemplo define el array como `[1,0,1,0,1,0]`. La construccion es como sigue
 ```fortran
 array(indiceinicial:indicefinal:salto)
 ```
 , en donde vemos que si omitimos el indice final, como en el ejemplo, se toma hasta el final del valor de ese indice. 

---

## 6. **Construcción `where`**
La construcción `where` permite realizar operaciones condicionales sobre los elementos de un array. Es especialmente útil para modificar solo ciertos elementos que cumplen una condición.

### Ejemplo de `where`
```fortran
real, dimension(5) :: array = [1.0, -2.0, 3.0, -4.0, 5.0]

! Reemplazar los valores negativos por 0
where (array < 0.0)
    array = 0.0
end where

print*, 'Array modificado: ', array
```
En este ejemplo, los valores negativos en `array` se reemplazan por `0.0`, resultando en `[1.0, 0.0, 3.0, 0.0, 5.0]`.

---


---

Este archivo proporciona una introducción básica al uso de arrays en Fortran moderno. Para más detalles, consulta la documentación oficial o ejemplos avanzados.