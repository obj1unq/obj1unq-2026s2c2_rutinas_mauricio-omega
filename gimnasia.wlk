class Rutina {
	method caloriasConsumidas(tiempo) = 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()

	method descanso(tiempo)
	method intensidad()
}

class Running inherits Rutina {
	var property intensidadConfigurada

	override method intensidad() = intensidadConfigurada

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
 