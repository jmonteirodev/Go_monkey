extends KinematicBody2D
const CHAO = Vector2(0,-1)
const VELOCIDADE = 250
const GRAVIDADE = 1200
var player
var initialPosition
var contador_atacar = 0
var vidas
var subir = true
var contador_subir = 0
var pontuacao = 0

func _ready():
	player = Vector2()
	vidas = 3
	initialPosition = global_position
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$player.play("andar");
		player.x = 150
		$player.flip_h = false
		$player.position.x = -10
	elif Input.is_action_pressed("ui_left"):
		player.x = -150
		$player.play("andar");
		$player.flip_h = true
		$player.position.x = 10
	else:
		player.x = 0
		$player.play("parado");
		
	if($identificaTeto.is_colliding()):
		var collider = $identificaTeto.get_collider()
		if(collider.name == "chaoInimigo"):
			if Input.is_action_just_pressed("ui_up"):
				contador_subir = 0
				pontuacao += 10
			else:
				player.y = 0
	else:
		player.x = 0
		player.y = -VELOCIDADE
	if Input.is_action_just_pressed("atacar"):
		contador_atacar = 0
	
	contador_atacar += 4
	if(contador_subir < 100):
		player.y = -VELOCIDADE
	contador_subir += 5
	player = move_and_slide(player, CHAO)

func returnPositionInitial():
	global_position = initialPosition
	vidas = vidas-1
	
	if(vidas < 1):
		print("Derrota")
		queue_free()
		
func itemCapturado():
	pontuacao += 1000
	print('Vitória')
	
func _on_Area2D_body_entered(body):
	if(body.name == 'Item'):
		body.queue_free()
		itemCapturado()


func _on_matarInimigo_body_entered(body):
	var bodies = $matarInimigo.get_overlapping_bodies();
	
	if(body.name.substr(0,7) == 'Inimigo'):
		if(contador_atacar > 100):
			print('a')
			returnPositionInitial()
		else:
			pontuacao += 50
			body.queue_free()

