extends Control

@onready var label := $Label 

func _ready() -> void:
	Controls.gems_changed.connect(change)
	change()
	
func change():
	label.text = "%s/%s" % [Controls.gems, Controls.level_gems]
