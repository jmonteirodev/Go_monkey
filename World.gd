extends Node2D
var contadorObjetos
var initialPositionYObjeto
var initialPositionPlayer
var jogo_iniciado = false

func _ready():
	contadorObjetos = 0
	initialPositionPlayer = $player.global_position
	initialPositionYObjeto = $Objetos/Objeto.global_position.y
	$player/Camera2D.set_limit(MARGIN_LEFT, $"Cenário/min".position.x)
	$player/Camera2D.set_limit(MARGIN_TOP, $"Cenário/min".position.y)
	$player/Camera2D.set_limit(MARGIN_RIGHT, $"Cenário/max".position.x)
	$player/Camera2D.set_limit(MARGIN_BOTTOM, $"Cenário/max".position.x)

func _physics_process(delta):
	jogo_iniciado = $"Cenário".game_init
	if($player != null):
		if($player.vidas > 0):
			if(str($player.vidas) != $HUD/CanvasLayer/vidas.text):
				jogo_iniciado = false
		$HUD/CanvasLayer/pontuacao.text = str($player.pontuacao)
		$HUD/CanvasLayer/vidas.text = str($player.vidas)
	if (jogo_iniciado == true) :
		contadorObjetos += 1
		if(contadorObjetos == 600):
			lancarObjeto()
	
func lancarObjeto():
	if($player != null):
		$Objetos/Objeto.jogo_iniciado = jogo_iniciado
		$Objetos/Objeto.global_position.x = $player.global_position.x
		$Objetos/Objeto.global_position.y = initialPositionYObjeto
		contadorObjetos = 0