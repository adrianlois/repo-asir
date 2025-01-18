##########################
# Ejercicios IMSO - ASIR #
##########################

# Cargar las librerías para el formulario
[void][System.reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

# Creamos un nuevo formulario a partir de la libería de forms
$formulario = New-Object System.Windows.Forms.Form

$etqtext = New-Object System.Windows.Forms.Label
$etqtext.text = "Aún no pulsaste"
$etqtext.autosize = $true
$formulario.controls.add($etqtext)

$boton = New-Object System.Windows.Forms.Button
$boton.text = "Púlsame y verás"
$boton.location = New-Object System.Drawing.point(50,50)
$boton.size = New-Object System.Drawing.Size(200,50)

# Añadimos el boton creado al formulario
$formulario.controls.add($boton)

# add_click es un evento
$boton.add_click({
    $etqtext.text = "No tienes nada mejor que hacer..."
})

$check = New-Object System.Windows.Forms.Checkbox
$check.location = New-Object System.Drawing.point(10,200)
$check.size = New-object System.Drawing.Size(200,20)
$check.text = "Prueba"

# Añadimos el check creado al formulario
$formulario.controls.add($check)

$check.add_click({
    if ($check.checked -eq $true) {
        $etqtext.text = "El check está marcado"
    } 
    else {
        $etqtext.text = "El check no está marcado" 
      }
})

# Mostramos el formulario (siempre después de cargar todos los objetos)
$formulario.showdialog()
