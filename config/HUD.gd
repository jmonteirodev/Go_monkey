extends Node2D
var reiniciar = false
var inicio
var tela_atual
var tela_antiga

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
func reiniciarJogo():
	$clique.play()
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
	$derrota.play()
	$CanvasLayer/Derrota.visible = true
	get_parent().jogando = false
	
func vitoria():
	$vitoria.play()
	$CanvasLayer/Vitoria.visible = true
	get_parent().jogando = false
	
func _on_Button_pressed():
	$clique.play()
	reiniciar = true
	get_parent().jogando = true


func _on_Jogar_pressed():
	$clique.play()
	$SomJogando.play()
	$SomInicio.stop()
	$CanvasLayer/Inicio.visible = false
	$CanvasLayer/Pause.visible = false
	get_parent().jogando = true
	tela_atual = 'play'


func _on_Como_Jogar_pressed():
	tela_antiga = tela_atual
	tela_atual = 'como_jogar'
	$clique.play()
	$CanvasLayer/comoJogar.visible = true
	for node in $CanvasLayer/comoJogar.get_children():
		node.visible = true
		if node is AnimatedSprite:
			node.playing = true


func _on_Creditos_pressed():
	tela_antiga = tela_atual
	tela_atual = 'creditos'
	$clique.play()
	$CanvasLayer/creditos.visible = true


func _on_Voltar_pressed():
	tela_atual = tela_antiga
	$clique.play()
	$CanvasLayer/Inicio.frame = 0
	$CanvasLayer/comoJogar.visible = false
	$CanvasLayer/creditos.visible = false
	for node in $CanvasLayer/comoJogar.get_children():
		node.visible = false
		if node is AnimatedSprite:
			node.playing = false


func _on_recomecar_pressed():
	$clique.play()
	reiniciar = true
	get_parent().jogando = true


func _on_Sair_pressed():
	get_parent().get_tree().quit()
