extends KinematicBody2D
const CHAO = Vector2(0,-1)
const VELOCIDADE = 250
const GRAVIDADE = 1200
var player
var initialPosition
var vidas

func _ready():
	player = Vector2()
	vidas = 3
	initialPosition = global_position
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
			player.x = VELOCIDADE
	elif Input.is_action_pressed("ui_left"):
		player.x = -VELOCIDADE
	else:
		player.x = 0
		
	if($identificaTeto.is_colliding()):
		var collider = $identificaTeto.get_collider()
		if(collider.name == "chaoInimigo"):
			if Input.is_action_pressed("ui_up"):		
				player.y = -VELOCIDADE
			else:
				player.y = 0
		if(collider.name == "chão"):
			player.y -= VELOCIDADE
	else:
		player.y = -VELOCIDADE
	player = move_and_slide(player, CHAO)

func returnPositionInitial():
	global_position = initialPosition
	vidas = vidas-1
	if(vidas < 1):
		print("Derrota")
		queue_free()
		
func itemCapturado():
	print('Vitória')
	
func _on_Area2D_body_entered(body):
	if(body.name == 'Item'):
		body.queue_free()
		itemCapturado()


func _on_matarInimigo_body_entered(body):
	if(body.name.substr(0,7) == 'Inimigo'):
		body.queue_free()
