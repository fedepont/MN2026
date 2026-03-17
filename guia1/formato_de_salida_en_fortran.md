# Formato de Salida en Fortran

En Fortran, la instrucción `write(*,*)` realiza una salida **sin formato** (list-directed), donde el compilador decide automáticamente cómo mostrar los valores. Sin embargo, para controlar el formato de la salida (como el número de decimales, ancho de campo, alineación, etc.), debes usar una **especificación de formato** en lugar del segundo asterisco.

## Sintaxis básica para salida formateada:
```fortran
write(*, '(especificadores_de_formato)') lista_de_variables
```

- El primer `*` indica salida a la pantalla (unidad estándar de salida).
- En lugar del segundo `*`, colocas una cadena de formato entre comillas simples o dobles, que describe cómo mostrar cada variable.

## Especificadores de formato comunes:
- **Enteros**: `i` (ej. `i5` para un entero de 5 dígitos).
- **Reales**: `f` (fijo), `e` (científico), `g` (general).
  - `f10.3`: 10 caracteres totales, 3 decimales (ej. `12345.678`).
  - `e12.4`: Notación científica con 12 caracteres, 4 decimales.
- **Cadenas**: `a` (ej. `a10` para una cadena de 10 caracteres).
- **Saltos de línea**: `/` para nueva línea.
- **Repetición**: Un número antes del especificador (ej. `2f10.2` para dos reales).

## Ejemplos:
- Para mostrar un número real con 2 decimales:  
  ```fortran
  write(*, '(f8.2)') x
  ```
- Para mostrar un entero y un real en la misma línea:  
  ```fortran
  write(*, '(i5, f10.3)') n, x
  ```
- Para agregar texto y formato:  
  ```fortran
  write(*, '("Potencia ", i2, " de ", f6.2, " =", e12.4)') i, x, potencia
  ```

## Usando sentencias FORMAT:
En lugar de poner el formato en la línea `write`, puedes definirlo por separado:
```fortran
write(*, 100) i, x, potencia
100 format('Potencia ', i2, ' de ', f6.2, ' =', e12.4)
```

En tu código actual (`ej13.f90`), `write(*,*)` funciona, pero si quieres controlar el formato (por ejemplo, limitar decimales o alinear columnas), reemplázalo con algo como `write(*, '(a, i2, a, f6.2, a, f10.4)') 'Potencia ', i, ' de ', x, ' =', potencia`.

Si necesitas un ejemplo específico para tu programa o más detalles sobre un tipo de dato, ¡dime!