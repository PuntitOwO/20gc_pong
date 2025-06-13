class_name Menu
extends CanvasLayer

signal pvp_pressed
signal pvc_pressed
signal cvc_pressed

@onready var resume_button: Button = $Control/MarginContainer/VBoxContainer/Button
@onready var pvp_button: Button = $Control/MarginContainer/VBoxContainer/Button4
@onready var pvc_button: Button = $Control/MarginContainer/VBoxContainer/Button2
@onready var cvc_button: Button = $Control/MarginContainer/VBoxContainer/Button3

func _ready() -> void:
	resume_button.pressed.connect(_resume)
	pvp_button.pressed.connect(_pvp)
	pvc_button.pressed.connect(_pvc)
	cvc_button.pressed.connect(_cvc)
	pause()

func pause() -> void:
	get_tree().paused = true
	show()
	var resume_available = not resume_button.disabled
	if resume_available:
		resume_button.grab_focus()
	else:
		pvp_button.grab_focus()

func _resume() -> void:
	get_tree().paused = false
	hide()

func _pvp() -> void:
	_resume()
	resume_button.disabled = false
	pvp_pressed.emit()

func _pvc() -> void:
	_resume()
	resume_button.disabled = false
	pvc_pressed.emit()

func _cvc() -> void:
	_resume()
	resume_button.disabled = false
	cvc_pressed.emit()
