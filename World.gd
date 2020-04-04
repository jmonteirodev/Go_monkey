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
	if($player != null):
		$HUD/CanvasLayer/pontuacao.text = str($player.pontuacao)
		$HUD/CanvasLayer/vidas.text = str($player.vidas)
	if(contadorObjetos == 600):
		lancarObjeto()
	
func lancarObjeto():
	if($player != null):
		$Objetos/Objeto.global_position.x = $player.global_position.x
		$Objetos/Objeto.global_position.y = initialPositionYObjeto
		contadorObjetos = 0