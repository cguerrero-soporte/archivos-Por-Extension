do {
        $usr = Read-Host "Ingrese numero de Usuario"
        <#-not -> Es el operador de negacion en PowerShell. Se utiliza para negar el resultado de una expresion booleana. En este caso, estamos negando el resultado 
        de [int]::TryParse($usrmex, [ref]$null), lo que significa que estamos comprobando si la conversion NO fue exitosa
        [int]::TryParse -> es un metodo estatico de la clase int en PowerShell. Se utiliza para intentar convertir una cadena en un numero entero. 
        Devuelve un valor booleano que indica si la conversion fue exitosa o no.La expresion [ref]$null se utiliza para pasar una referencia nula 
        al metodo TryParse. Esto significa que el metodo TryParse modificara esa referencia nula y la utilizara para devolver el resultado de la conversion.#>
        if (-not [int]::TryParse($usr, [ref]$null)) {
            Write-Host "Error al ingresar numero de usuario. Ingrese solo el numero de usuario."
        }
    } until ([int]::TryParse($usr, [ref]$null))

do {
    $usuario = $usr
    Write-Host "Opciones de ruta:"
    Write-Host "1. Documentos"
    Write-Host "2. Escritorio"
    $opcionRuta = Read-Host "Ingrese el numero de la opcion seleccionada"

    switch ($opcionRuta) {
        1 { $ruta = "Documents" }
        2 { $ruta = "Desktop" }
        default {
            Write-Host "Opcion no valida. Seleccionando la opcion predeterminada: Documents"
            $ruta = "Documents"
        }
    }

    $carpeta = "C:\Users\Usuario$usuario\$ruta"

    
    Write-Host "Selecciona el tipo extensiones que necesita revisar:"
    Write-Host "1. Todas las extensiones"
    Write-Host "2. Solo documentos Excel WORD TXT"
    Write-Host "3. Extensiones sin PDF"
    Write-Host "4. Extensiones y PDF sin correos msg"
    $opcionExtensiones = Read-Host "Ingrese el numero de la opcion seleccionada"

    
    switch ($opcionExtensiones) {
        1 { $extensiones = "*.xls", "*.xlsx", "*.docx", "*.doc", "*.txt", "*.pdf", "*.xml", "*.msg" }
        2 { $extensiones = "*.xls", "*.xlsx", "*.docx", "*.doc", "*.txt" }
        3 { $extensiones = "*.xls", "*.xlsx", "*.docx", "*.doc", "*.txt", "*.xml" }
        4 { $extensiones = "*.xls", "*.xlsx", "*.docx", "*.doc", "*.txt", "*.pdf", "*.xml" }
        default {
            Write-Host "Opcion no valida. Seleccionando todas las extensiones por defecto."
            $extensiones = "*.xls", "*.xlsx", "*.docx", "*.doc", "*.txt", "*.pdf", "*.xml", "*.msg"
        }
    }

    $size = Get-ChildItem -Path $carpeta -Include $extensiones -Recurse | Measure-Object -Property Length -Sum

    $bytes = $size.Sum
    $kilobytes = $bytes / 1KB
    $megabytes = $bytes / 1MB
    $gigabytes = $bytes / 1GB

    Write-Host "Tamano total de los archivos en la carpeta $carpeta :"
    Write-Host "Bytes: $bytes"
    Write-Host "Kilobytes: $kilobytes" 
    Write-Host "Megabytes: $megabytes" -ForegroundColor DarkRed
    Write-Host  "Gigabytes: $gigabytes" -ForegroundColor Magenta

    $mostrarLista = Read-Host "Mostrar la lista de archivos escaneados (si/no)"

    if ($mostrarLista.ToLower() -eq "si") {
        $archivos = Get-ChildItem -Path $carpeta -Include $extensiones -Recurse
        Write-Host "Lista de archivos escaneados:"
        $archivos | ForEach-Object {
            Write-Host $_.FullName
        }
    }

    
    $realizarOtroEscaneo = Read-Host "Realizar otro escaneo en otra carpeta (si/no)"

    
    if ($realizarOtroEscaneo.ToLower() -ne "si") {
        break
    } else {
        $usuario = ""
    }

} while ($true)
