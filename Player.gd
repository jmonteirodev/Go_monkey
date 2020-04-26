extends KinematicBody2D
const CHAO = Vector2(0,-1)
const VELOCIDADE = 250
const GRAVIDADE = 1200
var player
var initialPosition
var contador_atacar = 100
var vidas
var subir = true
var contador_subir = 100
var pontuacao = 0
var position_subir = 0
var fim_atacar = true;

func _ready():
	player = Vector2()
	vidas = 3
	initialPosition = global_position
	
func _physics_process(delta):
	player = move_and_slide(player, CHAO)		
	if($identificaTeto.is_colliding()):
		if(fim_atacar):
			$player.position.y = 10.057
			if Input.is_action_pressed("atacar"):
				 fim_atacar = false;
			elif Input.is_action_pressed("ui_right"):
				$player.play("andar");
				player.x = 150
				$player.flip_h = false
				$player.position.x = 25
			elif Input.is_action_pressed("ui_left"):
				player.x = -150
				$player.play("andar");
				$player.flip_h = true
				$player.position.x = -25
			else:
				player.x = 0
				player.y = 0;
				$player.play("parado");
				if($player.flip_h):
					$player.position.x = -25
				else:
					$player.position.x = 25
			var collider = $identificaTeto.get_collider()
			if(collider.name == "chaoInimigo"):
				if Input.is_action_pressed("ui_up"):
					$identificaTeto.enabled = false;
					contador_subir = 0
					pontuacao += 10
		else:
			$player.position.y = 8
			$player.play("atacar")
			if($player.frame == 6):
				fim_atacar = true;
			player.x = 0
			player.y = 0;
			if($player.flip_h):
				$player.position.x = 4
			else:
				$player.position.x = -4
	else:
		if(position_subir != 0):
			global_position.x = position_subir
		player.x = 0
		player.y = -VELOCIDADE
		$player.position.x = 0
		$player.play("subir");
	
	if(contador_subir > 150):
		$identificaTeto.enabled = true;
	contador_subir += 5

func returnPositionInitial():
	global_position = initialPosition
	contador_subir = 150
	vidas = vidas - 1
	
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



func _on_Area2D_area_entered(area):
	if(area.name != 'inicio' && area.name != 'Area2D'):
		position_subir = get_parent().positions_vinha[int(area.name)]


func _on_Area2D_area_exited(area):
	position_subir = 0
