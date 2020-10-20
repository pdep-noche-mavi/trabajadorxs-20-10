ss Trabajador {
	var cuenta = 0 
	method basico(ganancia)
	
	method impuestos(basico) = basico * 0.05
	
	
	
	method sueldoPara(ganancia) = {
		const basico = self.basico(ganancia)
		return basico - self.impuestos(basico)
	}
	
	method cobrarSueldo(ganancia){
		cuenta += self.sueldoPara(ganancia)
	}
	
	method gastar(monto){
		if(monto > cuenta){
			throw new DomainException(message="Saldo insuficiente")
		}
		cuenta -= monto
	}
}

class Cooperativista inherits Trabajador{
	
	const sociesCooperativa
	method cuenta() = cuenta
	override method basico(ganancia) = ganancia / sociesCooperativa
	
	
}

class Empleade inherits Trabajador{
	var ausencias = 0
	var adelantos = 0
	
	method cuenta() = cuenta
	method faltarUnDia() { ausencias = ausencias + 1 }
	
	override method basico(ganancia) = ganancia * 0.01
	
	method cobraPresentismo() = ausencias == 0
	
	method presentismo(basico) = if(self.cobraPresentismo()) basico / 12 else 0
	
	method pedirAdelanto(monto) {
		cuenta = cuenta + monto
		adelantos = adelantos + monto
	}
	
	method adelantos() = adelantos
	
	override method sueldoPara(ganancia) {
		const basico = self.basico(ganancia)
		return super(ganancia) - self.adelantos() + self.presentismo(basico)
	}
	
	override method gastar(monto){
		super(monto)
		
		if(cuenta < 500){
			self.pedirAdelanto(1000)
		}
		
	}
	

}

class Emprendedor inherits Trabajador{
	
 	override method basico(ganancia) = 5000
 
 	
}

class Empresarie inherits Trabajador{
	
	method presentismo(basico) =  basico / 12
	
	override method basico(ganancia) = ganancia * 0.8
	
	override method sueldoPara(ganancia){
		const basico = self.basico(ganancia)
		return super(ganancia) + self.presentismo(basico)
	}
	
}