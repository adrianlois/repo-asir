##########################
# Ejercicios IMSO - ASIR #
##########################

<#
Operadores de comparación
    -lt less than (menor que)
    -gt greater than (mayor que)
    -eq equal (igual)
    -le less or equal (menor o igual)
    -ge greater or equal (mayor o igual)
    -ne no equal (no igual)
    
    -like (como) permite comodines like "*texto"
    -nolike
    -match permite usar expresiones regulares -match "cla[a-z]"
    -nomatch no cumple con la expresión regular
    -replace sustituye parte de una palabra por otra "pepe perez" -raplace "pepe "jose"
    
Operadores lógicos
    -and
    -or
    -not
    -xor
    ! no logico(igual que -not)
    
Tipo de flujos
    Flujo condicional
        
        if (condicion) {
            operaciones
        }
        elseif (condicion) {
            operaciones
        }
        elseif (condicion) {
            operaciones
        }
        else {
            operaciones
        }
#>

# Cargar las librerías para el formulario
[void][System.reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

# Crear el formulario en una variable
$formulario = New-Object System.Windows.Forms.Form

# Cuadro de texto para número uno
$textbox1 = New-Object System.Windows.Forms.Textbox
$textbox1.location = New-Object System.Drawing.point(40,30)
$textbox1.size = New-Object System.Drawing.Size(80,50)
$textbox1.text = ""
$formulario.controls.add($textbox1)

# Cuadro de texto para número dos
$textbox2 = New-Object System.Windows.Forms.Textbox
$textbox2.location = New-Object System.Drawing.point(160,30)
$textbox2.size = New-Object System.Drawing.Size(80,50)
$textbox2.text = ""
$formulario.controls.add($textbox2)

# Botón
$boton = New-Object System.Windows.Forms.Button
$boton.text = "Comparar"
$boton.location = New-Object System.Drawing.point(40,60)
$boton.size = New-Object System.Drawing.Size(200,30)
$formulario.controls.add($boton)

# Texto
$etqtext = New-Object System.Windows.Forms.Label
$etqtext.text = ""
$etqtext.autosize = $true
$etqtext.location = New-Object System.Drawing.point(40,100)
$formulario.controls.add($etqtext)

# Realizamos la comparación al hacer click en el evento del botón
$boton.add_click({
    $num1 = [int]$textbox1.text
    $num2 = [int]$textbox2.text

        if ([int]$num1 -eq $num2) {
                $etqtext.text = "Los números $num1 y $num2 son iguales"
            } elseif ($num1 -lt $num2) {
                $etqtext.text = "El número $num1 es menor que el número $num2"
            } else {
                $etqtext.text = "El número $num1 es mayor que el número $num2"
            }
})

# Mostramos el diálogo del formulario
$formulario.showdialog()
