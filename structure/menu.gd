extends Control

@onready var main := $Main
@onready var play := $Play

func _ready() -> void:
	main.visible = true
	play.visible = false
	main.play_option.pressed.connect(on_play_option)

func on_play_option():
	main.visible = false
	play.visible = true
