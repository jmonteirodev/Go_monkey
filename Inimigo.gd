extends KinematicBody2D
var body = Vector2()
const CHAO = Vector2(0,1)
const GRAVIDADE = 30
var contador = 0
var numero_aleatorio = randi()%2-1
var direcao = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if(numero_aleatorio == 0): 
		$AnimatedSprite.flip_h = true
		$RayCast2D.cast_to.x = 260
		direcao = 1
	else:
		$AnimatedSprite.flip_h = false
		$RayCast2D.cast_to.x = -260
		direcao = numero_aleatorio


func _physics_process(delta):
	body.y += GRAVIDADE
	body.x = direcao*80
	var collider = ""
	if($RayCast2D.is_colliding()):
		collider = $RayCast2D.get_collider().name;
	if(contador == 200 || contador == -200 || collider == 'chão'):
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$RayCast2D.cast_to.x *= -1
		direcao *= -1
		contador = 0
	contador += direcao
	body = move_and_slide(body)

func _on_causaDano_body_entered(body):
	if(body.name == 'player'):
		body.returnPositionInitial()
