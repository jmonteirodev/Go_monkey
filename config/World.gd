extends Node2D

var contadorObjeto
var contadorAguia
var positions_cipos = []
var jogo_iniciado
var jogando

func _ready():
	$player.posicao_inicial = $inicio.global_position
	jogo_iniciado = false
	set_limites_camera()
	preencher_positions_cipos()
	iniciar_jogo()
	jogando = false
	
	contadorObjeto = 0
	contadorAguia = 0


func _physics_process(delta):
	if($HUD.tela_atual == 'play' && jogando):
		$Pause/ParallaxBackground/Button.visible = true
	else:
		$Pause/ParallaxBackground/Button.visible = false
		
	if(jogando):
		jogo_iniciado = $"Cenário".game_init
		if($HUD.reiniciar):
			$HUD.reiniciarJogo()
			reiniciar()
		if($player.item_capturado):
			$HUD.vitoria()
		if(str($player.vidas) != $HUD/CanvasLayer/vidas.text):
			dano_player()
		$HUD/CanvasLayer/pontuacao.text = str($player.pontuacao)
		if (jogo_iniciado == true) :
			contadorAguia += 1
			$Aguia.distanciar_do_player($player.global_position, -380)
			if($Aguia.atacando == true):
				if($Aguia.ultrapassou($"Cenário/max".position.x + 300)):
					$Aguia.atacando = false
					contadorAguia = 0
			if(contadorAguia == 500):
				ataque_aguia()
	
func ataque_aguia():
	$Aguia.atacar($player, $"Cenário/min".position.x - 300)
		
func iniciar_jogo():
	$player.voltar_inicio()
	$player.vidas = 3
func reiniciar():
	$player.item_capturado = false
	$player.vidas = 3
	$player.pontuacao = 0
	$Item.capturado = false
	$player.voltar_inicio()
	for node in $Inimigos.get_children():
		node.morreu = false
func dano_player():
	$HUD.atualiza_vidas($player.vidas)
	$"Cenário".game_init = false
	$Aguia.visible = false
	$Objeto.visible = false
	$Objeto.global_position.x = $"Cenário/min".position.x - 300
	$Aguia.global_position.x = $"Cenário/min".position.x - 300
	contadorAguia = 0
	
func set_limites_camera():
	$player/Camera2D.set_limit(MARGIN_LEFT, $"Cenário/min".position.x)
	$player/Camera2D.set_limit(MARGIN_TOP, $"Cenário/min".position.y)
	$player/Camera2D.set_limit(MARGIN_RIGHT, $"Cenário/max".position.x)
	$player/Camera2D.set_limit(MARGIN_BOTTOM, $"Cenário/max".position.x)

func preencher_positions_cipos():
	positions_cipos.append($"Cenário/cipo/0/Position2D".global_position.x)
	positions_cipos.append($"Cenário/cipo/1/Position2D".global_position.x)
	positions_cipos.append($"Cenário/cipo/2/Position2D".global_position.x)
	positions_cipos.append($"Cenário/cipo/3/Position2D".global_position.x)
	positions_cipos.append($"Cenário/cipo/4/Position2D".global_position.x)
	positions_cipos.append($"Cenário/cipo/5/Position2D".global_position.x)

func lancar_objeto():
	$Objeto.lancar_objeto($player.global_position, -250)


func _on_Button_pressed():
	$HUD/somPause.play()
	jogando = false
	$HUD/CanvasLayer/Pause.visible = true
