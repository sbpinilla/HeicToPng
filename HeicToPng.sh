#!/bin/bash

# Rutas de entrada y salida
input_dir="{IN_DIRECTORI}"
output_dir="{OUT_DIRECTORY}"

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