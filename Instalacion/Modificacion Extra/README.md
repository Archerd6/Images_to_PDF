Error de imagemagick    attempt to perform an operation not allowed by the security policy `PDF' @ error/constitute.c/IsCoderAuthorized/408



Solucion

cd ..
cd ..
cd etc
cd ImageMagick-6
sudo nano policy.xml

Well, I added
<policy domain="coder" rights="read | write" pattern="PDF" />
just before </policymap> in /etc/ImageMagick-7/policy.xml and that makes it work again

(Editar con nano, desde el explorador de windows no sale)
salir de nano con ctrl + x