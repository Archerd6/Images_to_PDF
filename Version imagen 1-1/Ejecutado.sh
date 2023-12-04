#!/bin/bash

input_folder="./input"
# Iterar sobre las imágenes y rotar según la orientación
for image in "$input_folder"/*; do
    exiftran -ai "$image"
done


output_folder="./output"
# Primero, elimina la carpeta de salida si existe
rm -rf "$output_folder"
# Luego, crea la carpeta de salida
mkdir -p "$output_folder"

for file in "$input_folder"/*; do
    filename=$(basename "$file")
    output_file="$output_folder/${filename%.*}_square.png"

    width=$(identify -format "%w" "$file")
    height=$(identify -format "%h" "$file")

    # Verificar si la imagen ya tiene una relación de aspecto de 1:1
    if [ "$width" -eq "$height" ]; then
        echo "La imagen $filename ya tiene una relación de aspecto de 1:1. Copiando la imagen a la carpeta de salida."
        cp "$file" "$output_file"
        continue
    fi

    # Calcular el lado más largo para obtener una relación de aspecto de 1:1
    max_side=$(awk "BEGIN {print int($width > $height ? $width : $height)}")

    # Calcular el tamaño del relleno para hacer la imagen cuadrada
    padding=$((max_side - (width > height ? height : width)))
    padding_left=$((padding / 2))
    padding_top=$((padding / 2))

    # Añadir fondo transparente y ajustar el tamaño manteniendo la relación de aspecto
    convert "$file" -background none -gravity center -extent "${max_side}x${max_side}" "$output_file"

    echo "Imagen transformada: $output_file"
done








# Cambia al directorio de salida
cd "$output_folder"


# Renombrar los archivos PNG en orden numérico
ls -v *.png | cat -n | while read n f; do mv -n "$f" "$(printf "%03d.png" $n)"; done

# Convertir PNG a PDF
convert *.png -page 888x888 NoOCR.pdf

echo "PDF sin OCR creado"

ocrmypdf -l spa NoOCR.pdf OCR.pdf
echo "PDF con OCR creado"
