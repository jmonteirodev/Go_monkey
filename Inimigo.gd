extends KinematicBody2D
var body = Vector2()
const CHAO = Vector2(0,1)
const GRAVIDADE = 30
var contador = 0
var numero_aleatorio = randi()%2-1
var direcao = 0
var sumir = false

func sumir():
	$corpo.disabled = true
	visible = false
func aparecer():
	$corpo.disabled = false
	visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if(numero_aleatorio == 0): 
		$AnimatedSprite.flip_h = true
		$frente.cast_to.x = 260
		$corpo.position.x = 72.273
		direcao = 1
	else:
		$AnimatedSprite.flip_h = false
		$frente.cast_to.x = -260
		$corpo.position.x = -72.273
		direcao = -1


func _physics_process(delta):
	if(get_parent().get_parent().jogando):
		$AnimatedSprite.playing = true
		if(sumir):
			sumir()
			$AnimatedSprite.playing = false
		else:
			aparecer()
			$AnimatedSprite.playing = true
			body.y += GRAVIDADE
			body.x = direcao*80
			var collider = ""
			if($frente.is_colliding()):
				collider = $frente.get_collider().name;
			if(contador == 200 || contador == -200 || collider == 'parede'):
				$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
				$corpo.position.x *= -1
				$frente.cast_to.x *= -1
				direcao *= -1
				contador = 0
			contador += direcao
			body = move_and_slide(body)
	else:
		$AnimatedSprite.playing = false