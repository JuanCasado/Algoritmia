# Algoritmia
Set of common used algorithms in swift

El lenguaje de programación utilizado es [Swift](https://swift.org/about/ "Swift")
Los archivos fuente se encuentran con la extendión .swift
Se incluye el archivo .xcodeproj con el arvhivo .plist incorporado por si se desea abrir el archivo fuente como un proyecto en Xcode

Los archivos .swift pueden ser tanto compilados como ejecutados a modo de script, es necesario tener instalado el lenguaje sobre un entrono UNIX


		./Nombre_encapsulado
		|__
		|	Nombre_proyecto 
		|	|__
		|		*.swift
		|
		|__*.xcodeproj

## Instalación de Swift:

Descargar clang

		$ sudo apt-get install clang libicu-dev

[Descargar](https://swift.org/download/#releases "Descargar") el paquete de swift

Se importan las llaves PG y se descomprime el archivo descargado 

		$ wget -q -O - https://swift.org/keys/all-keys.asc | \gpg --import -
		$ tar xzf swift-<VERSION>-<PLATFORM>.tar.gz

Se debe iniciar el PATH indicando el lugar de la instalación

		$ export PATH=/path/to/usr/bin:"${PATH}"

## Sistemas Windows

Será necesario instalar el [subsistema Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10 "subsistema Linux") una vez hecho la instalación podrá realizarse de modo natural
