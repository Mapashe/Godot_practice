extends Control

@onready var btn = $btn_rapido
@onready var timer = $DesaparicionTimer
@onready var resultado = $result
@onready var endgame = $endgame_timer

func _ready():
	resultado.visible = false
	btn.disabled = false
	mover_btn()
	timer.start()
	endgame.start()

func mover_btn():
	var screen_size = get_viewport_rect().size
	var lim_x = screen_size.x - btn.size.x
	var lim_y = screen_size.y - btn.size.y
	btn.position = Vector2(
		randi() % int(lim_x),
		randi() % int(lim_y)
	)

func _on_btn_rapido_pressed():
	btn.disabled = true
	timer.stop()
	endgame.stop()
	resultado.text = "Ganaste!"
	resultado.visible = true
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_desaparicion_timer_timeout():
	resultado.visible = true
	mover_btn()
	timer.start()


func _on_endgame_timer_timeout():
	btn.disabled = true
	resultado.text = "Perdiste!"
	btn.visible = false
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
