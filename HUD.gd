extends Node2D
var reiniciar = false
var inicio
var tela_atual

func _ready():
	reiniciar = false
	inicio = true
	tela_atual = 'inicio'
	
func _physics_process(delta):
	if(tela_atual == 'inicio'):
		if($CanvasLayer/Inicio.frame == 3):
			$CanvasLayer/Inicio.playing = false
		else:
			$CanvasLayer/Inicio.playing = true
func reiniciar():
	$CanvasLayer/Vitoria.visible = false
	$CanvasLayer/Derrota.visible = false
	reiniciar = false
func atualiza_vidas(vidas):
	$CanvasLayer/vidas.text = str(vidas)
	$CanvasLayer/v1.visible = true
	$CanvasLayer/v2.visible = true
	$CanvasLayer/v3.visible = true
	if(vidas == 2):
		$CanvasLayer/v3.visible = false
	elif(vidas == 1):
		$CanvasLayer/v3.visible = false
		$CanvasLayer/v2.visible = false
	elif(vidas <= 0):
		$CanvasLayer/v3.visible = false
		$CanvasLayer/v2.visible = false
		$CanvasLayer/v1.visible = false
		derrota()

func derrota():
	$CanvasLayer/Derrota.visible = true
	get_parent().jogando = false
func vitoria():
	$CanvasLayer/Vitoria.visible = true
func _on_Button_pressed():
	reiniciar = true
	get_parent().jogando = true


func _on_Jogar_pressed():
	$CanvasLayer/Inicio.visible = false
	get_parent().jogando = true
	tela_atual = 'play'


func _on_Como_Jogar_pressed():
	tela_atual = 'como_jogar'
	$CanvasLayer/Inicio.visible = false
	$CanvasLayer/comoJogar.visible = true
	$CanvasLayer/comoJogar/andar_direita.playing = true
	$CanvasLayer/comoJogar/andar_esquerda.playing = true
	$CanvasLayer/comoJogar/subir.playing = true
	$CanvasLayer/comoJogar/atacar.playing = true
	$CanvasLayer/comoJogar/Derrotar_lagarto.playing = true


func _on_Creditos_pressed():
	pass # Replace with function body.


func _on_Voltar_pressed():
	tela_atual = 'inicio'
	$CanvasLayer/Inicio.frame = 0
	$CanvasLayer/Inicio.visible = true
	$CanvasLayer/comoJogar.visible = false
	$CanvasLayer/comoJogar/andar_direita.playing = false
	$CanvasLayer/comoJogar/andar_esquerda.playing = false
	$CanvasLayer/comoJogar/subir.playing = false
	$CanvasLayer/comoJogar/atacar.playing = false
