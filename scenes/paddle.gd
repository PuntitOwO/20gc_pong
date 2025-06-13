class_name Paddle
extends CharacterBody2D

@export_enum("left", "right", "cpu") var paddle := "left"
@onready var up_action := paddle + "_paddle_up"
@onready var down_action := paddle + "_paddle_down"
@onready var ball: Ball = $"../Ball"

var cpu_controlled : bool:
	get:
		return paddle == "cpu"

var x :float

const SPEED := 500
const CPU_SPEED := 150

func _ready() -> void:
	x = global_position.x

func _physics_process(_delta: float) -> void:
	velocity.y = _get_cpu_velocity() if cpu_controlled else _get_player_velocity()
	move_and_slide()
	# X coordinate fixing
	global_position.x = x

func _get_player_velocity() -> float:
	return Input.get_axis(up_action, down_action) * SPEED

func _get_cpu_velocity() -> float:
	return signf(ball.global_position.y - global_position.y) * CPU_SPEED
