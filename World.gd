extends Node2D
var contadorObjetos
var initialPositionYObjeto
var initialPositionPlayer

func _ready():
	contadorObjetos = 0
	initialPositionPlayer = $player.global_position
	initialPositionYObjeto = $Objetos/Objeto.global_position.y

func _physics_process(delta):
	contadorObjetos += 1
	lancarObjeto()
	
func lancarObjeto():
	if(contadorObjetos == 600):
		$Objetos/Objeto.global_position.x = $player.global_position.x
		$Objetos/Objeto.global_position.y = initialPositionYObjeto
		contadorObjetos = 0