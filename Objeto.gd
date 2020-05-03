extends KinematicBody2D
var objeto = Vector2()
const GRAVIDADE = 4
var pedra_jogada
var distancia_queda
var max_distancia_queda

func _ready():
	max_distancia_queda = 500
	distancia_queda = 0
	pedra_jogada = false


func _physics_process(delta):
	if(get_parent().jogando):
		objeto = move_and_slide(objeto)
		if get_parent().jogo_iniciado && pedra_jogada :
			global_position.y += GRAVIDADE
			if(distancia_queda >= max_distancia_queda):
				distancia_queda = 0
				sumir()

func lancar_objeto(position_player, distancia_do_player):
	visible = true
	global_position.x = position_player.x
	global_position.y = position_player.y + distancia_do_player
	pedra_jogada = true

func sumir():
	visible = false
	pedra_jogada = false

func _on_zona_ataque_body_entered(body):
	if(body.is_in_group("Jogador")):
		body.perder_vida()
