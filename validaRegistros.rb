##############################################################################
# ARCHIVO             : validaRegistros.rb
# AUTOR/ES            : Norman Ruiz
# VERSION             : 0.01 beta.
# FECHA DE CREACION   : 21/11/2019.
# ULTIMA ACTUALIZACION: 21/11/2019.
# LICENCIA            : GPL (General Public License) - Version 3.
#
#  **************************************************************************
#  * El software libre no es una cuestion economica sino una cuestion etica *
#  **************************************************************************
#
# Este programa es software libre;  puede redistribuirlo  o  modificarlo bajo
# los terminos de la Licencia Publica General de GNU  tal como se publica por
# la  Free Software Foundation;  ya sea la version 3 de la Licencia,  o (a su
# eleccion) cualquier version posterior.
#
# Este programa se distribuye con la esperanza  de que le sea util,  pero SIN
# NINGUNA  GARANTIA;  sin  incluso  la garantia implicita de MERCANTILIDAD  o
# IDONEIDAD PARA UN PROPOSITO PARTICULAR.
#
# Vea la Licencia Publica General GNU para mas detalles.
#
# Deberia haber recibido una copia de la Licencia Publica General de GNU junto
# con este proyecto, si no es asi, escriba a la Free Software Foundation, Inc,
# 59 Temple Place - Suite 330, Boston, MA 02111-1307, EE.UU.

#=============================================================================
# SISTEMA OPERATIVO   : Microsoft Windows 10 Pro
# IDE                 : Visual Studio Code Version: 1.40.1
# COMPILADOR          : ruby 2.6.5p114 (2019-10-01 revision 67812) [x64-mingw32]
# LICENCIA            : GPL (General Public License) - Version 3.
#=============================================================================
# DESCRIPCION:
#              Este script automatiza la validacion de registros 
#              en los archivos de liquidacion del conciliador.
#
##############################################################################

#*****************************************************************************
#                             INCLUSIONES ESTANDAR
#=============================================================================

#*****************************************************************************
#                             INCLUSIONES PERSONALES
#=============================================================================

#*****************************************************************************
# DEFINICION DE LAS FUNCIONES
#=============================================================================

#=============================================================================
# FUNCION : ValidaRegistros().
# ACCION : Lee el archivo especificado y almacena los registros contados en 
#          un arreglo que luego devuelve.
# PARAMETROS: listaAux, un arreglo de int con la lista de tipos de registros.
#             archivo, una cadena con el nombre de archivo a leer.
# DEVUELVE : contadoraux, un arreglo con los totales de registros por tipo, 
#            total general y registros desconocidos.
#-----------------------------------------------------------------------------
def ValidaRegistros(nombreArchivoAux)
    print "\tValidaddo registros...\n"
    contadorRegistrosaux = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    File.open(nombreArchivoAux, 'r') do |datos|
        while regaux = datos.gets
            prefijo = regaux[0] + regaux[1] + regaux[2]
            case prefijo
            when "1CL"
                contadorRegistrosaux[0] += 1
            when "2CL"
                contadorRegistrosaux[1] += 1
            when "3CL"
                contadorRegistrosaux[2] += 1
            when "6CL"
                contadorRegistrosaux[3] += 1
            when "7CL"
                contadorRegistrosaux[4] += 1
            when "8CL"
                contadorRegistrosaux[5] += 1
            when "9CL"
                contadorRegistrosaux[6] += 1
            else
                contadorRegistrosaux[7] += 1
            end
            contadorRegistrosaux[8] += 1
        end
    end
    print "\tProceso finalizado...\n"
    print "\n"
    return contadorRegistrosaux
end

#=============================================================================
# FUNCION : VerResumen().
# ACCION : Genera el detalle de registros encontrados
# PARAMETROS: listaAux, un arreglo de int con la lista de tipos de registros.
#             contadoraux, un arreglo con los totales de registros por tipo, 
#             total general y registros desconocidos.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
def VerResumen(contadorRegistrosAux)
    print "\tGenerando detalle...\n"
    print "\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
    print "\t Total de registros: ", contadorRegistrosAux[8], "\n"
    print "\t Registros 1: ", contadorRegistrosAux[0], "\n"
    print "\t Registros 2: ", contadorRegistrosAux[1], "\n"
    print "\t Registros 3: ", contadorRegistrosAux[2], "\n"
    print "\t Registros 6: ", contadorRegistrosAux[3], "\n"
    print "\t Registros 7: ", contadorRegistrosAux[4], "\n"
    print "\t Registros 8: ", contadorRegistrosAux[5], "\n"
    print "\t Registros 9: ", contadorRegistrosAux[6], "\n"
    print "\t Registros desconocidos: ", contadorRegistrosAux[7], "\n"
    print "\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
end

#=============================================================================
# FUNCION : Main().
# ACCION : Esta es la funcion principal del script.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
def Main()
    if ARGV.length == 1
        if File.exist?(ARGV[0])
            system('cls')
            print "\n"
            print " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
            print "   Iniciando validacion de registros...\n"
            print " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
            print "\n"
            print "\tProcesando archivo: \n"
            print "\t", ARGV[0], "\n"
            print "\n"
            # Capturo el nombre del archivo desde los parametros 
            nombreArchivo = ARGV[0]
            # Declaro un arreglo iniciado en 0 para sus siete posiciones 
            # correspondiente a los tipos de registros 
            contadorRegistros = [0, 0, 0, 0, 0, 0, 0, 0, 0]
            # Llamo la funcion ValidaRegistros que validara los registros 
            # pasados por parametro y los guardara en un arreglo para su 
            # posterior procesado.
            contadorRegistros = ValidaRegistros(nombreArchivo)
            # Llamo a la funcion VerResumen y le paso como parametro el arreglo 
            # donde se contabilisaron los registros pra generar un resumen y 
            # exponerlo por pantalla.
            VerResumen(contadorRegistros)
            print "\n"
            print " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
            print "   Proceso finalizado.\n"
            print " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
            print "\n"
        else
            print "\n"
        print "Nombre de archivo incorrecto o inexistente, Proceso cancelado.\n"
        print "\n"
        print "Modo de uso: ruby validaRegistros.rb <nombre del archivo>\n"
        print "Ejemplo: ruby validaRegistros.rb ARGSP001.S20190430094337.txt\n"
        print "\n"
        end
    else
        print "\n"
        print "Parametros incorrectos, Proceso cancelado.\n"
        print "\n"
        print "Modo de uso: ruby validaRegistros.rb <nombre del archivo>\n"
        print "Ejemplo: ruby validaRegistros.rb ARGSP001.S20190430094337.txt\n"
        print "\n"
    end
end
# Llamo a la funcion Main que depliega el script
Main()

#=============================================================================
#                            FIN DE ARCHIVO
##############################################################################