extends KinematicBody2D
var objeto = Vector2()
const GRAVIDADE = 3
var initialPositionYObjeto = global_position.y - 600
var jogo_iniciado = false
var pedra_jogada = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if jogo_iniciado && pedra_jogada :
		global_position.y += GRAVIDADE
		objeto = move_and_slide(objeto)

func _on_Area2D_body_entered(body):
	if(body.name == 'player'):
		global_position.y = initialPositionYObjeto
		body.returnPositionInitial()
