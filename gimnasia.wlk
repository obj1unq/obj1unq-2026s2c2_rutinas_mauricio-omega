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
	const intensidad = 1.3
	
	override method descanso(tiempo) = tiempo / 5
	override method intensidad() = intensidad
}


class RemoDeCompeticion inherits Remo {
	override method intensidad() = 1.7

	override method descanso(tiempo) = (super(tiempo) - 3).max(2)
}


class Persona {
	var property peso = 0

	method aplicarRutina(rutina) {
		self.validarAplicarRutina(rutina)
		peso = peso - self.pesoPerdido(rutina)
	}
	method validarAplicarRutina(rutina) {
		if (!self.sePuedeaplicarRutina(rutina)){
			self.error("No es posible aplicar la rutina.")
		}
	}
	method sePuedeaplicarRutina(rutina)  

	method pesoPerdido(rutina) = rutina.caloriasConsumidas(self.tiempo()) / self.caloriasPorKilo()

	method caloriasPorKilo()  

	method tiempo()  

	method rutina()
}

class PersonaSedentario inherits Persona {	
	var property tiempoQueEjercita
	
	override method tiempo() = tiempoQueEjercita 

	override method sePuedeaplicarRutina(rutina) = peso > 50

	override method caloriasPorKilo() = 7000

}

class PersonaAtleta inherits Persona {
	const tiempoQueEjercita = 90

	method tiempoQueEjercita() = tiempoQueEjercita 

	override method tiempo() = tiempoQueEjercita 

	override method sePuedeaplicarRutina(rutina) = rutina.caloriasConsumidas(tiempoQueEjercita) > 10000

	override method pesoPerdido(rutina) = super(rutina) - 1
	override method caloriasPorKilo() = 8000
}

// =========Punto 3

class Club{
	const predios = []

	//3.1
	method mejorPredioPara(persona) = self.predioQueQuemaMasCalorias(persona)
	method predioQueQuemaMasCalorias(persona) = predios.max({predio => predio.caloriasConsumidasEnTodasRutinasPor(persona)})  

	//3.2
	method prediosTranquisPara(persona) = predios.filter({predio => predio.hayRutinaQueGastaMenosCaloriasPor(persona)}) 

	//3.3
	method rutinasMasExigentesPara(persona) = predios.map({predio => predio.rutinaMasExigentePara(persona)}) 
}

class Predio {
	const rutinas = []

	//3.1
	method caloriasConsumidasEnTodasRutinasPor(persona) = rutinas.sum({rutina => rutina.caloriasConsumidas(persona.tiempoQueEjercita())}) 

	//3.2
	method hayRutinaQueGastaMenosCaloriasPor(persona) = 
		rutinas.any({rutina => rutina.caloriasConsumidas(persona.tiempoQueEjercita()) < self.caloriasMaximas()})
	method caloriasMaximas() = 500 

	//3.3
	method rutinaMasExigentePara(persona) = rutinas.max({rutina => rutina.caloriasConsumidas(persona.tiempoQueEjercita())}) 

}