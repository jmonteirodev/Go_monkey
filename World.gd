extends Node2D
var contadorObjeto
var contadorAguia
var initialPositionYObjeto
var initialPositionPlayer
var positions_vinha = []
var jogo_iniciado = false
var frame_atual = 0
func _ready():
	contadorObjeto = 0
	contadorAguia = 0
	initialPositionPlayer = $player.global_position
	initialPositionYObjeto = $Objetos/Objeto.global_position.y
	$player/Camera2D.set_limit(MARGIN_LEFT, $"Cenário/min".position.x)
	$player/Camera2D.set_limit(MARGIN_TOP, $"Cenário/min".position.y)
	$player/Camera2D.set_limit(MARGIN_RIGHT, $"Cenário/max".position.x)
	$player/Camera2D.set_limit(MARGIN_BOTTOM, $"Cenário/max".position.x)
	positions_vinha.append($"Cenário/vinha/0/Position2D".global_position.x)
	positions_vinha.append($"Cenário/vinha/1/Position2D".global_position.x)
	positions_vinha.append($"Cenário/vinha/2/Position2D".global_position.x)
	positions_vinha.append($"Cenário/vinha/3/Position2D".global_position.x)
	positions_vinha.append($"Cenário/vinha/4/Position2D".global_position.x)
	positions_vinha.append($"Cenário/vinha/5/Position2D".global_position.x)


func _physics_process(delta):
	jogo_iniciado = $"Cenário".game_init
	if($player != null):
		$Aguia.global_position.y = $player.global_position.y - 380
		if($player.vidas > 0):
			if(str($player.vidas) != $HUD/CanvasLayer/vidas.text):
				jogo_iniciado = false
				$"Cenário".game_init = false
				$Aguia.visible = false
				$Objetos/Objeto.visible = false
				$Objetos/Objeto.pedra_jogada = false
				$Objetos/Objeto.global_position.x = $"Cenário/max".position.x + 300
				$Aguia.global_position.x = $"Cenário/min".position.x - 300
				contadorAguia = 0
		$HUD/CanvasLayer/pontuacao.text = str($player.pontuacao)
		$HUD/CanvasLayer/vidas.text = str($player.vidas)
	if (jogo_iniciado == true) :
		contadorAguia += 1
		if(contadorAguia >= 300):
			lancarObjeto()
	
func lancarObjeto():
	$Aguia.visible = true
	$Objetos/Objeto.visible = true
	if($Aguia.global_position.x >= $"Cenário/max".position.x + 300):
		$Aguia.global_position.x = $"Cenário/min".position.x - 300
		contadorAguia = 0
		$Objetos/Objeto.pedra_jogada = false
		$Objetos/Objeto.visible = false
	$Aguia.global_position.x += 5
	if($player != null && $Aguia.global_position.x >= $player.global_position.x):
		$Aguia/AnimatedSprite.play("sem pedra")
		if($Objetos/Objeto.pedra_jogada == false):
			$Aguia/AnimatedSprite.frame = frame_atual
			$Aguia/AnimatedSprite.play("sem pedra")
			$Objetos/Objeto.jogo_iniciado = jogo_iniciado
			$Objetos/Objeto.pedra_jogada = true
			$Objetos/Objeto.visible = true
			$Objetos/Objeto.global_position.x = $player.global_position.x
			$Objetos/Objeto.global_position.y = $player.global_position.y - 250
	else:
		$Aguia/AnimatedSprite.play("com pedra")
		frame_atual = $Aguia/AnimatedSprite.frame