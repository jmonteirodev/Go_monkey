extends StaticBody2D
var sumir
func _ready():
	sumir = false
func _physics_process(delta):
	if(get_parent().jogando):
		$AnimatedSprite.playing = true
		if(sumir):
			sumir()
		else:
			aparecer()
	else:
		$AnimatedSprite.playing = false
func sumir():
	$corpo.disabled = true
	visible = false
func aparecer():
	$corpo.disabled = false
	visible = true

