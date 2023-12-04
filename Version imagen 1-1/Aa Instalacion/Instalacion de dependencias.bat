REM Ejecutable de wsl para instalar las dependencias

wsl -e bash -lic "sudo apt-get update"

wsl -e bash -lic "sudo apt-get upgrade"

wsl -e bash -lic "sudo apt install python3-pip"

wsl -e bash -lic "sudo pip3 install ocrmypdf"

wsl -e bash -lic "sudo apt-get install tesseract-ocr-spa"

wsl -e bash -lic "sudo apt install poppler-utils"

wsl -e bash -lic "sudo apt install imagemagick"

wsl -e bash -lic "sudo apt install libimage-exiftool-perl"

wsl -e bash -lic "sudo apt install exiftran"

cmd /k