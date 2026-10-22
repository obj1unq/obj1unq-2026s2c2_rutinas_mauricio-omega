//=======================================
//1. Rutinas
//=======================================

class Rutina {
	method caloriasConsumidas(tiempo) = 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()

	method descanso(tiempo)
	method intensidad()
}

class Running inherits Rutina {
	var property intensidad

	override method descanso(tiempo) = if (tiempo > 20) 5 else 2
}


class Maraton inherits Running {
	override method caloriasConsumidas(tiempo) = super(tiempo) * 2
}

class Remo inherits Rutina {
	override method descanso(tiempo) = tiempo / 5
	override method intensidad() = 1.3
}


class RemoDeCompeticion inherits Remo {
	override method descanso(tiempo) = (super(tiempo) - 3).max(2)
	override method intensidad() = 1.7
}

//=======================================
//2. Personas
//=======================================
class Persona {
	var property peso = 0

	method aplicarRutina(rutina) {
		self.validarAplicarRutina(rutina)
		peso = peso - self.pesoPerdido(rutina)
	}
	method validarAplicarRutina(rutina) {
		if (!self.sePuedeAplicarRutina(rutina)){
			self.error("No es posible aplicar la rutina")
		}
	}
	method sePuedeAplicarRutina(rutina)  

	method pesoPerdido(rutina) = rutina.caloriasConsumidas(self.tiempoQueEjercita()) / self.caloriasPorKilo()

	method caloriasPorKilo()  

	method tiempoQueEjercita() 

	//mensaje para predio:
	method caloriasConsumidaEnRutina(rutina) = rutina.caloriasConsumidas(self.tiempoQueEjercita())
}

class PersonaSedentario inherits Persona {	
	var property tiempoQueEjercita

	override method sePuedeAplicarRutina(rutina) = peso > 50

	override method caloriasPorKilo() = 7000

}

class PersonaAtleta inherits Persona {
	override method tiempoQueEjercita() = 90 

	override method sePuedeAplicarRutina(rutina) = rutina.caloriasConsumidas(self.tiempoQueEjercita()) > 10000

	override method pesoPerdido(rutina) = super(rutina) - 1
	override method caloriasPorKilo() = 8000
}

// =========Punto 3

class Club{
	const predios = []

	//3.1
	method mejorPredioPara(persona) = predios.max({predio => predio.caloriasConsumidasEnTodasRutinasPor(persona)})  

	//3.2
	method prediosTranquisPara(persona) = predios.filter({predio => predio.hayRutinaQueGastaMenosCaloriasPor(persona)}) 

	//3.3
	method rutinasMasExigentesPara(persona) = predios.map({predio => predio.rutinaMasExigentePara(persona)}) 
}

class Predio {
	const rutinas = []

	//3.1
	method caloriasConsumidasEnTodasRutinasPor(persona) = rutinas.sum({rutina => persona.caloriasConsumidaEnRutina(rutina)}) 

	//3.2
	method hayRutinaQueGastaMenosCaloriasPor(persona) =  rutinas.any({rutina => persona.caloriasConsumidaEnRutina(rutina) < self.caloriasMaximas()})
	method caloriasMaximas() = 500 

	//3.3
	method rutinaMasExigentePara(persona) = rutinas.max({rutina => persona.caloriasConsumidaEnRutina(rutina)}) 

}