# Conversión de Archivos HEIC a PNG

Este documento proporciona una guía para usar el script Bash que convierte archivos de imagen en formato HEIC a PNG. También se incluye información sobre la instalación de **ImageMagick**, que es la herramienta utilizada para realizar la conversión.

## Requisitos

- **Git Bash** o **Windows Subsystem for Linux (WSL)**.
- **ImageMagick** instalado y accesible desde la línea de comandos.

## Instalación de ImageMagick

### En Windows

1. **Descargar ImageMagick**:
   - Ve a la [página oficial de descarga de ImageMagick](https://imagemagick.org/script/download.php).
   - Selecciona el instalador para Windows (elige la versión de 64 bits si tu sistema es de 64 bits).

2. **Instalar ImageMagick**:
   - Ejecuta el instalador descargado.
   - Durante la instalación, asegúrate de seleccionar la opción "Add to PATH" (Agregar al PATH) para que puedas ejecutar el comando `magick` desde cualquier terminal.

3. **Verificar la instalación**:
   - Abre **Git Bash** o **CMD** y ejecuta:
     ```bash
     magick --version
     ```
   - Esto debería mostrar la versión de **ImageMagick** instalada.

## Script de Conversión

### Descripción

El script `convert_heic_to_png.sh` convierte todos los archivos `.HEIC` en un directorio especificado a archivos `.PNG`, manteniendo el mismo nombre. Los archivos convertidos se guardan en un directorio de salida.

### Estructura del Script

```bash
#!/bin/bash

# Rutas de entrada y salida
input_dir="/d/Imagenes/Iphone"
output_dir="/d/Imagenes/IphonePNG"

# Crear el directorio de salida si no existe
mkdir -p "$output_dir"

# Contar los archivos .HEIC
total_files=$(find "$input_dir" -type f -iname "*.heic" | wc -l)
echo "Archivos HEIC encontrados: $total_files"

# Inicializar contador de progreso
converted_count=0

# Recorrer los archivos .HEIC en el directorio de entrada
for heic_file in "$input_dir"/*.HEIC "$input_dir"/*.heic; do
    if [ -f "$heic_file" ]; then
        # Obtener el nombre base del archivo sin extensión
        base_name=$(basename "$heic_file" .HEIC)
        base_name=$(basename "$base_name" .heic)
        
        # Definir el nombre del archivo de salida
        output_file="$output_dir/${base_name}.png"

        # Mostrar el progreso
        ((converted_count++))
        echo "Convirtiendo archivo $converted_count de $total_files: $(basename "$heic_file") -> $(basename "$output_file")"

        # Ejecutar el comando 'magick' para convertir HEIC a PNG
        magick "$heic_file" "$output_file"

        # Comprobar si el archivo fue creado correctamente
        if [ -f "$output_file" ]; then
            echo "Conversión exitosa: $(basename "$output_file")"
        else
            echo "Error al convertir: $(basename "$heic_file")"
        fi
    fi
done

echo "Archivos convertidos con éxito: $converted_count de $total_files"