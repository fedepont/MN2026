# Problema 13: estructura de la corrida

Este archivo resume como se organiza la compilacion y ejecucion del problema 13.

## 1. Corriendo todo en un único código
En `main_all_together.f90` se puede ver todo el código junto, sin modularizar. El código se ve de la siguiente manera

```fortran
program main_all_together
    implicit none
    integer, parameter  :: dp = kind(1.0d0) ! Doble precisión
    real(dp)            :: base
    integer             :: i

    print *, "Input a real number:"
    read *, base

    do i = 1, 5
        write(*,'("Power", I3, ": ", F12.4)') i, pow(base, i)
    end do

    contains
        function pow(x, n) result(res)
            real(dp),   intent(in)  :: x
            integer,    intent(in)  :: n
            real(dp)                :: res
            integer :: i
            res = x**n
        end function pow
end program main_all_together
```

este código se compila de forma usual como sigue
```bash
gfortran main_all_together.f90 -o main_all_together.o
```

Y si ejecutamos el programa nos da, por ejemplo, la siguiente salida
```bash
user@hostname:~/my_folder$ ./main_all_together.o 
 Input a real number:
2
Power  1:       2.0000
Power  2:       4.0000
Power  3:       8.0000
Power  4:      16.0000
Power  5:      32.0000
```

## 2. Modularizando el código
Ahora bien, en el ejercicio nos piden modularizar el código, lo que implica separar la definición de parámetros y funciones en módulos independientes. Esto nos lleva a tener tres archivos principales: `module_parameters.f90`, `module_functions.f90` y `code.f90`.

Cada uno de los archivos tiene una responsabilidad específica: `module_parameters.f90` define los parámetros globales, `module_functions.f90` contiene las funciones matemáticas reutilizables, y `code.f90` es el programa principal que utiliza ambos módulos para ejecutar la lógica del programa.

El módulo parameters se puede ver de la siguiente manera:

```fortran
module module_parameters
    implicit none
    integer, parameter :: dp = kind(1.0d0) ! Doble precisión
end module module_parameters
```

El módulo functions se ve así:

```fortran
module module_functions
    use module_parameters
    implicit none
    contains
        function pow(x, n) result(res)
            real(dp),   intent(in)  :: x
            integer,    intent(in)  :: n
            real(dp)                :: res
            res = x**n
        end function pow
end module module_functions
```

Y el programa principal `code.f90` se ve de la siguiente manera:

```fortran
program main
    use module_parameters
    use module_functions
    implicit none
    real(dp)    :: base
    integer     :: i

    print *, "Input a real number:"
    read *, base

    do i = 1, 5
        write(*,'("Power", I3, ": ", F12.4)') i, pow(base, i)
    end do
end program main
```

El proceso de compilacion ahora requiere compilar los tres archivos juntos, respetando el orden de dependencias. El comando de compilacion es el siguiente:

```bash
user@hostname:~/my_folder$ gfortran module_parameters.f90 module_functions.f90 code.f90 -o code.o
```

El orden es importante por dependencias:

1. `module_parameters.f90` primero, porque define `dp`.
2. `module_functions.f90` despues, porque hace `use module_parameters`.
3. `code.f90` al final, porque usa ambos modulos.

Si el orden se altera, el compilador puede fallar al no encontrar los modulos necesarios.

## Módulo de precisión

Usualmente en Fortran se define un módulo específico para manejar la precisión de los números reales, lo que facilita cambiar la precisión en todo el programa simplemente modificando un solo lugar. Este módulo se puede definir de la siguiente manera:

```fortran
module module_precision
	implicit none
	integer, parameter :: sp=selected_real_kind(p=6,r=37)	 ! simple presicion (sp) class
	integer, parameter :: dp=selected_real_kind(p=15,r=307)  ! double presicion (dp) class
	integer, parameter :: qp=selected_real_kind(p=33,r=4931) ! quad presicion (dp) class
end module module_precision
```
Aquí se definen tres tipos de precisión: simple (sp), doble (dp) y cuádruple (qp). Cada uno de estos parámetros se puede usar en el resto del programa para declarar variables con la precisión deseada. Por ejemplo, si queremos usar doble precisión, simplemente declaramos nuestras variables como `real(dp)`. Esto hace que el código sea más flexible y fácil de mantener, ya que si en algún momento queremos cambiar la precisión, solo necesitamos modificar el módulo `module_precision` sin tener que buscar y cambiar cada declaración de variable en el programa.

Los parámetros `p` y `r` en la función `selected_real_kind` especifican la precisión en términos de dígitos decimales (`p`) y el rango de exponentes (`r`). Esto asegura que las variables declaradas con estos tipos tengan la precisión y el rango adecuados para los cálculos que se realizarán en el programa.

Sin embargo, es muy comun utilizar el estandar de Fortran 2008 para definir la precisión, que es más simple y directo, utilizando el módulo `iso_fortran_env` que ya viene con el compilador. En este caso, el módulo de precisión se puede definir de la siguiente manera:

```fortran
module module_precision
    use iso_fortran_env, only: sp => real32, dp => real64, qp => real128
    implicit none
end module module_precision
```

aquí se asignan los tipos de precisión directamente a los tipos de datos estándar definidos en `iso_fortran_env`, lo que simplifica aún más la gestión de la precisión en el programa. En este caso, `dp` se asigna a `real64`, que es la representación estándar de doble precisión en Fortran, y es comúnmente utilizada en aplicaciones científicas y de ingeniería debido a su equilibrio entre precisión y rendimiento.

Una ventaja de esta última forma es que es más clara y menos propensa a errores, ya que no requiere especificar manualmente los dígitos de precisión y el rango de exponentes, lo que puede ser complicado y propenso a errores si no se hace correctamente. Además, al utilizar los tipos de datos estándar, se garantiza la portabilidad del código entre diferentes plataformas y compiladores, ya que estos tipos están definidos de manera consistente en el estándar de Fortran.