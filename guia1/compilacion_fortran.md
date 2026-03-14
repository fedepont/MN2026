# Proceso de compilación de código Fortran

## 1) Compilar un solo archivo

Supongamos que tenemos un archivo principal llamado `main.f90` en nuestro directorio de trabajo `~/my_folder`. Para compilarlo y ejecutarlo, podemos usar los siguientes comandos en la terminal:

**Compilación:**

```bash
# Moverse al directorio de trabajo
usuario@localhost:~$ cd ~/my_folder
# Compilar
usuario@localhost:~/my_folder/$ gfortran main.f90 -o main.o
```

**Ejecución:**

```bash
# Ejecutar el programa compilado
usuario@localhost:~/my_folder/$ ./main.o
```
    
**Notas:**

- Primero ver que `gfortran` transforma codigo fuente (`.f90`) en un ejecutable (`.o`).
- No son la misma cosa, hay diferencias entre archivo fuente y archivo ejecutable.

## 2) Agregar advertencias del compilador

El script usa advertencias importantes:

- `-Wall -Wextra -Wconversion -pedantic`

**Ejemplo:**

```bash
# Compilar con advertencias
usuario@localhost:~/my_folder/$ gfortran -Wall -Wextra -Wconversion -pedantic main.f90 -o main  .o
```

**Notas:**

- Las advertencias ayudan a detectar errores logicos temprano.
- No siempre frenan la compilacion, pero son senales que hay que revisar.

## 3) Compilar con un módulo

Si el programa usa un módulo (por ejemplo `my_module.f90`), hay que compilar ambos archivos juntos en el orden correcto.

**Ejemplo:**

```bash
# Compilar con un modulo
usuario@localhost:~/my_folder/$ gfortran my_module.f90 main.f90 -o main.o
```

**Notas:**

- Los módulos generan archivos `.mod` y el programa principal depende de ellos.
- Practicar que pasa si el módulo no se compila o se compila en orden incorrecto.

## 4) Modo debug: priorizar deteccion de errores

Se pueden agregar flags para detectar errores en tiempo de ejecucion, por ejemplo:

- `-std=f2018`
- `-ffpe-trap=zero -ffpe-trap=overflow -ffpe-trap=underflow`
- `-g -fbacktrace -fbounds-check -O0`

**Ejemplo:**

```bash
# Compilar en modo debug y detectar errores
usuario@localhost:~/my_folder/$ gfortran -std=f2018 -Wall -Wextra -Wconversion -pedantic \
  -ffpe-trap=zero -ffpe-trap=overflow -ffpe-trap=underflow \
  -g -fbacktrace -fbounds-check -O0 \
  my_module.f90 main.f90 -o main.o
```

**Notas:**

- Compilar con flags de debug es ideal para la etapa de desarrollo y correccion.
- Ayuda a atrapar division por cero, overflow, underflow y errores de indices (... y más).

## 5) ¿Qué hace cada flag?

### Flags de estandar y advertencias

- `-std=f2018`: fuerza al compilador a verificar el estandar Fortran 2018.
- `-Wall`: activa un conjunto general de advertencias comunes.
- `-Wextra`: agrega advertencias adicionales (mas estrictas que `-Wall`).
- `-Wconversion`: avisa conversiones de tipo potencialmente peligrosas (por ejemplo, `real` a `integer`).
- `-pedantic`: marca extensiones no estandar o usos que se apartan del estandar.

### Flags de debug (detectar errores)

- `-ffpe-trap=zero`: detiene el programa ante division por cero en punto flotante.
- `-ffpe-trap=overflow`: detiene el programa ante overflow de punto flotante.
- `-ffpe-trap=underflow`: detiene el programa ante underflow de punto flotante.
- `-g`: agrega informacion de depuracion (simbolos) para diagnostico.
- `-fbacktrace`: muestra traza de llamadas cuando ocurre error en ejecucion.
- `-fbounds-check`: verifica en runtime limites de arreglos (evita accesos fuera de rango).
- `-O0`: desactiva optimizaciones para facilitar depuracion y trazabilidad.

**Nota:**

- Existe información muy detallada de qué es lo que hace cada flag en la documentación oficial de gfortran: [The GNU Fortran Compiler](https://gcc.gnu.org/onlinedocs/gfortran/Option-Summary.html), pueden consultar también desde la terminal con `man gfortran` o `gfortran --help` para ver un resumen de opciones.
- También existen flags de optimizacion (`-O2`, `-O3`, etc.) que mejoran rendimiento pero pueden dificultar depuracion. Por eso se recomienda usarlos solo en etapas finales de desarrollo, no en la fase de aprendizaje inicial.

## 6) Automatizar con un script en Bash

Una vez que entienden los comandos manuales, este proceso se puede meter en un script (`my_run_script.sh`) para no escribir todo cada vez. El script podría verse así:

```bash
#!/bin/bash

# Add one or more module names separated by spaces (without .f90)
module_names="./my_module_name_01 ./my_module_name_02"
code_name="my_code_name"    # (without .f90)

# 1 = use module file, 0 = compile only main code
use_module=1

# Select compilation mode: debug (debug) or normal (normal)
mode="debug"

if [[ "${mode}" == "debug" ]]; then
    # Common warnings
    flg_warning="-Wall -Wextra -Wconversion -pedantic"
    # Debug flags
    flg_debugging="-ffpe-trap=zero -ffpe-trap=overflow -ffpe-trap=underflow -g -fbacktrace -fbounds-check -O0"
    # Join flags for debugging
    flags="-std=f2018 ${flg_warning} ${flg_debugging}"
else
  flags=" "
fi

code_file="${code_name}.f90"    # building the main code file
exe_file="${code_name}.o"       # building the executable file

module_files=""
for mod in ${module_names}; do
  module_files+=" ${mod}.f90"   # building the module files (if any)
done

echo "Compiling..."
echo "Mode: ${mode}"
if [[ "${use_module}" -eq 1 ]]; then
  gfortran ${flags} -o "${exe_file}" ${module_files} "${code_file}"
else
  gfortran ${flags} -o "${exe_file}" "${code_file}"
fi

echo "Compilation done."
```

Para ejecutar el script, primero hay que darle permisos de ejecución y luego correrlo:

```bash
# Darle permisos de ejecución
usuario@localhost:~/my_folder/$ chmod +x my_run_script.sh
# Ejecutar el script
usuario@localhost:~/my_folder/$ ./my_run_script.sh
``