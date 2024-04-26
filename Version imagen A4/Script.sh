#!/bin/bash

# Ruta de la carpeta que contiene las imágenes
input_folder="./input"
# Iterar sobre las imágenes y rotar según la orientación
for image in "$input_folder"/*; do
    exiftran -ai "$image"
done

# Ruta de la carpeta de salida para las imágenes convertidas
output_folder="./output"
# Primero, elimina la carpeta de salida si existe
rm -rf "$output_folder"
# Luego, crea la carpeta de salida
mkdir -p "$output_folder"

# Iterar sobre todas las imágenes en la carpeta de entrada
for file in "$input_folder"/*
do
    # Nombre del archivo sin la ruta
    filename=$(basename "$file")
    
    # Ruta completa del archivo de salida con extensión .png
    output_file="$output_folder/${filename%.*}.png"
    
    # Obtener las dimensiones originales de la imagen
    width=$(identify -format "%w" "$file")
    height=$(identify -format "%h" "$file")
    
    # Calcular la relación de aspecto actual
    aspect_ratio=$(awk "BEGIN {printf \"%.2f\", $width/$height}")
    
    # Verificar si la imagen ya tiene una relación de aspecto de 16:9
    if [ "$aspect_ratio" = "0.707" ]; then
        echo "La imagen $filename ya tiene una relación de aspecto de 16:9. No se realizarán cambios."
        continue
    fi
    
    # Calcular el ancho y la altura para una relación de aspecto de 16:9
    # if [ "$aspect_ratio" < "1.78" ]; then
    #     target_width=$width
    #     target_height=$((width * 9 / 16))
    # else
        target_width=$((height * 210 / 297))
        target_height=$height
    # fi
    
    # Calcular el tamaño del relleno en los lados
    padding=$((target_width - width))
    


    # Asigna un valor a la variable padding (cambia el valor según sea necesario)

    # Verifica si padding es menor que 0
    if [ "$padding" -lt 0 ]; then
        echo "La variable padding es menor que 0."

        # Calcular la nueva altura para mantener la relación de aspecto original (16:9)
        new_height=$((width * 297 / 210))

        # Añadir fondo transparente a los lados y guardar en formato PNG con la nueva altura
        convert "$file" -alpha set -background none -gravity center -extent "${width}x${new_height}" "$output_file"


    else
        echo "La variable padding no es menor que 0."
        padding_left=$((padding / 2))
        padding_right=$((padding - padding_left))

        # Añadir fondo transparente a los lados y guardar en formato PNG
        convert "$file" -alpha set -background none -gravity west -splice "$padding_left"x0 -gravity east -splice "$padding_right"x0 "$output_file"
    fi




    
    echo "Imagen transformada: $output_file"
done

echo "Todas las imagenes terminadas"


