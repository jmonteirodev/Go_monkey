extends KinematicBody2D
var body = Vector2()
const CHAO = Vector2(0,-1)
const VELOCIDADE = 3830
const GRAVIDADE = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	body = Vector2()

func _physics_process(delta):
	body.y += GRAVIDADE
	if Input.is_action_just_pressed("ui_right"):
			body.x = VELOCIDADE
	elif Input.is_action_just_pressed("ui_left"):
		body.x = -VELOCIDADE
	elif Input.is_action_just_pressed("ui_up"):
		body.y = -900
	else:
		body.x = 0
	body = move_and_slide(body, CHAO)
