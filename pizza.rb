@ingreso={ nombre: 'Nombre', puntos:'Puntos' }
@personas =[{
                nombre:"Nombre", puntos: "Puntos", aporte:"Aporte"
            }]
@options = [
    "1) Ingresar Estudiante",
    "2) Ver puntos",
    "3) Agregar punto(s)",
    "4) Calcular pizza",
    "5) Reiniciar puntos",
    "6) Borrar estudiante",
    "7) Salir"
]
@file_path= "lista.txt"
@band = false

 def menu

    loop do
      clear
      @options.each { |option| puts option }
      choice = gets.chomp
      case choice
        when '1'
          ingreso
        when '2'
          ver_puntos
        when '3'
          addpunto
        when '4'
          calcula_pizza
        when '5'
          reset_points
        when '6'
          delete_est
        when '7'
          puts "Chao..."
          break

        else
          puts "Ingrese una opcion correcta" if choice!='1' || choice!='2' || choice!='3' || choice!='4' || choice!='5'|| choice!='6' || choice!='7'

      end
    end
 end

def delete_est
  choice=0
  l=@personas.length.to_i
  if l==1
    pust "No hay datos para eliminar"
  end
  ver_puntos
  puts "Ingrese el numero de la persona a borrar"
  loop do
  choice=gets.chomp.to_i
    if choice>0 && choice<l
      break
    else
      puts "Ingrese una opcion valida"
    end
  end
  if @personas.delete_at(choice)
      puts "Registro borrado, presione enter para continuar"
  else
      puts "Registro no borrado, presione enter para continuar"

  end
  save_in_file
  gets.chomp
end
#-----------Funcion de carga

def load
  nombre=""
  puntos=""
  aporte=''
  cont=0
  File.foreach(@file_path) do |line|
    if cont>0
    nombre, puntos, aporte  = line.split(' - ')
    @personas.push({nombre:nombre, puntos:puntos, aporte:aporte})
    end
    cont=cont+1
    #comics[name] = url.strip

  end

end

#----------Funcion de guardado

def save_in_file()
  File.open(@file_path, "w") do |file|
    file.write("")
  end
  @personas.each do |persona|
    File.open(@file_path, "a") do |file|
      file.write("#{persona[:nombre]} - #{persona[:puntos]} - #{persona[:aporte]}\n")
    end
  end



end

#------Funcion para agregar gente


def ingreso
  puts "Ingrese el nombre del estudiante"
  nombre=gets.chomp
  @personas.push({nombre:nombre, puntos:0, aporte:0})
  save_in_file()
end


#-------Funcion que carga la lista

def ver_puntos
    #@personas.each do |persona|
     # persona[:nombre]=""
     # persona[:puntos]=""
    #end
    #@personas.delete
    nombre=""
    puntos=""
    #File.foreach(@file_path) do |line|
      #nombre, puntos  = line.split(' - ')
      #comics[name] = url.strip
     # @personas.push({nombre:nombre, puntos:puntos})
    #end
    #puts "Nombre - Puntos"
    puts "-------------------------------------------------------------------"
    @personas.each_with_index do |persona, index|
      if index>=1
        puts "#{index} - #{persona[:nombre]} - #{persona[:puntos]} - $#{persona[:aporte]}"
      else
        puts "No. - #{persona[:nombre]} - #{persona[:puntos]} - #{persona[:aporte]}"
      end
    end
    puts "-------------------------------------------------------------------"
    puts "Presione Enter para continuar"
    gets.chomp
end
#--------Funcion para agregar puntos

def addpunto

  cant=0
  p=0
  l=0
  #puts "No. - Nombre - Puntos"
  #@personas.each_with_index do |persona, index|
    #puts "#{index} - #{persona[:nombre]} - #{persona[:puntos]}"
  #end
  ver_puntos
  puts "Ingrese el numero de la persona"
  l=(@personas.length)-1
  loop do
    p=gets.chomp.to_i

    if (p>0 && p<= l)
      break
    else
      puts 'Ingrese una opcion válida'
    end
  end

  puts 'Cuantos puntos?'
  cant=gets.chomp.to_i
  @personas[p][:puntos]=@personas[p][:puntos].to_i+cant
  save_in_file()
end

#---------Calculo de la cuota

def calcula_pizza
  totalp=0
  totald=0
  f=0
  @personas.each do |persona|
    totalp=persona[:puntos].to_i + totalp
  end
  if(totalp==0)
    puts "No hay puntos"
    gets.chomp
    menu
  end
  puts "Ingrese el valor de la pizza"
  loop do
    totald=gets.chomp.to_i
    if(0<totald && totald<999999999999999999999)
      break
    else
      puts "Ingrese informacion valida"
    end
  end
  f=totald/totalp
  @personas.each_with_index do |persona, index|
    if index >= 1
    persona[:aporte]=persona[:puntos].to_i*f
    end
  end
  save_in_file()
  ver_puntos
end

#-------funcion para borrar puntos y aportes

def reset_points
    cont=0
    @personas.each_with_index do |persona, index|
      if index >= 1
      persona[:puntos]=0
      persona[:aporte]=0
      else
      end
    end
    save_in_file
    puts "Puntos y aportes borrados, presione enter para continuar"
    gets.chomp
end

#----funcion para limpiar la pantalla
def clear
  system('clear')

end
  load
  menu




