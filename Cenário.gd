extends Node2D
var game_init

# Called when the node enters the scene tree for the first time.
func _ready():
	game_init = false

func _on_fim_body_entered(body):
	if body.name == "player" :
		game_init = false


func _on_inicio_body_entered(body):
	if body.name == "player" :
		game_init = true
