# Poder de un compilador (clase de Nico en CP) #

Este es un ejemplo simple de como un compilador, a traves de sus flags, puede crear un codigo en lenguaje ensamblador
que puede ser muy superior a la estructura de nuestro programa.

Vamos a construir un código que sume los numeros de `1` a `10000`. El resultado de esta suma es `10000*(10001)/2=50005000`.

Estes es el código,

```
    program sum_natural

    implicit none
    integer :: sum_val, i

    
    do n=1,100000
        sum_val = 0
        do i = 1, 10000 
            sum_val = sum_val + i
        end do
    enddo
    
    print *,sum_val

    end program sum_natural
```

El códgio lo hace unas 100 mil veces a la suma, para que demore un rato y podamos ver la diferencia de tiempos luego. Ahora lo vamos a compilar utilizando,

```
gfortran test.f90
```

Lo que produce un file `a.out`. Para ver cuanto demora al correrlo hacemos

```
time ./a.out
```

y responde algo como,

```
real    0m2,051s
user    0m2,043s
sys     0m0,008s
```

Ahora si compilamos con `gfortran -O3 test.f90` y medimos el tiempo de corrida, se obtiene,

```
real    0m0,010s
user    0m0,002s
sys     0m0,008s
```

Con lo cual el compilador realmente optimizo la estructura de mi código y la hizo mucho mas eficiente.

Pero si uno indaga más, en realidad hizo mucho más que eso. El siguiente comando muestra el código assembler (ensamblador) que son las instrucciones que mi programa pasa al procesador.

```
gfortran -g -c -Wa,-alh test.f90 | less
```

La salida es algo como esto,

```
35                    .L4:
  36                    .LBB3:
  37                            .loc 1 13 14 is_stmt 0 discriminator 1
^LGAS LISTING /tmp/cc8rwOWj.s                   page 2


  38 0031 817DFC10              cmpl    $10000, -4(%rbp)
  38      270000
  39 0038 0F9FC0                setg    %al
  40 003b 0FB6C0                movzbl  %al, %eax
  41 003e 85C0                  testl   %eax, %eax
  42 0040 7511                  jne     .L7
  14:test.f90      ****             sum_val = sum_val + i
  43                            .loc 1 14 33 is_stmt 1
  44 0042 8B55F4                movl    -12(%rbp), %edx
  45 0045 8B45FC                movl    -4(%rbp), %eax
  46 0048 01D0                  addl    %edx, %eax
  47 004a 8945F4                movl    %eax, -12(%rbp)
  13:test.f90      ****         do i = 1, 10000 
  48                            .loc 1 13 14 discriminator 2
  49 004d 8345FC01              addl    $1, -4(%rbp)
  50                    .LBE3:
  13:test.f90      ****         do i = 1, 10000 
  51                            .loc 1 13 14 is_stmt 0
  52 0051 EBDE                  jmp     .L4

```
A la izquierda tenemos numeros de linea, luego unas direcciones de memoria `004d 8345FC01`, a veces hay flags que marcan lineas como `.L4:`, y tambien código pegado que me indica en que lugar de lo que escribimos estamos `do i = 1, 10000`. En muchas lineas se indica tambien una instruccion del procesador y las variables que modifica, como por ejemplo `movl    -12(%rbp), %edx`, que mueve el valor del registro `-12(%rbp)` al registro `%edx`, hay otras instrucciones como `addl, jmp` que son suma y salto de a una linea.

Solo vamos a notar que de la linea 52 salta (jmp .L4)  a la 35. Y ahi esta nuestro loop interno.

Puede decir que sucede con el código mirando la salida del assembler con `-O3`?

<!-- ```
32 0023 C744240C              movl    $50005000, 12(%rsp)
``` -->

<!-- La linea 32 muestra el resultado de la suma! Es decir el compilador, "sabe" cual es la suma de los primeros `N` naturales, y directamente detecta eso en el codigo y escribe el resultado. NO HACE LA SUMA! -->
