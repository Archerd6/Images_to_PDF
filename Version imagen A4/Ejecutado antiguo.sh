#!/bin/bash

input_folder="./output"
# Iterar sobre las imágenes y rotar según la orientación
for image in "$input_folder"/*; do
    exiftran -ai "$image"
done

# Cambia al directorio de salida
cd "$input_folder"

# Convertir PNG a PDF
convert -density 30 *.png -page 420x594 NoOCR.pdf

# Cambiar -page segun las necesidades

echo "PDF sin OCR creado"

ocrmypdf -l spa NoOCR.pdf OCR.pdf
echo "PDF con OCR creado"
