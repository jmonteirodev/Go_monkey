extends KinematicBody2D
var atacando
var posicao_player
var pedra_lancada
var frame_animacao_atual
var lancou_pedra

# Called when the node enters the scene tree for the first time.
func _ready():
	posicao_player = global_position
	atacando = false
	lancou_pedra = false
func _physics_process(delta):
	if(get_parent().jogando && atacando):
		$animacao.playing = true
		global_position.x += 5
		if(get_parent().jogo_iniciado):
			if(pedra_lancada):
				$animacao.play("sem pedra")
				if(!lancou_pedra):
					$animacao.frame = frame_animacao_atual
					lancou_pedra = true
			else:
				$animacao.play("com pedra")
				frame_animacao_atual = $animacao.frame
			if(ultrapassou(posicao_player.x)):
				lancar_pedra()
	else:
		$animacao.playing = false

func atacar(player, inicio):
	posicao_player = player.global_position
	visible = true
	atacando = true
	global_position.x = inicio
	pedra_lancada = false
	
func lancar_pedra():
	if(pedra_lancada == false):
		get_parent().lancar_objeto()
	pedra_lancada = true
	
func ultrapassou(posicao):
	return global_position.x >= posicao
	
func distanciar_do_player(posicao_do_player, distancia_do_player):
	posicao_player = posicao_do_player
	global_position.y = posicao_player.y + distancia_do_player
