extends Node2D

@onready var ball_spawn: Marker2D = $BallSpawn
@onready var ball: Ball = $Ball
@onready var left_goal: Area2D = $LeftGoal
@onready var right_goal: Area2D = $RightGoal

@onready var left_paddle: Paddle = $LeftPaddle
@onready var right_paddle: Paddle = $RightPaddle

@onready var left_paddle_score := 0:
	set(value):
		left_paddle_score = value
		left_score.text = str(value)
@onready var right_paddle_score := 0:
	set(value):
		right_paddle_score = value
		right_score.text = str(value)

@onready var left_score: Label = $LeftScore
@onready var right_score: Label = $RightScore

@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var menu: Menu = $Menu

func _ready() -> void:
	left_goal.body_entered.connect(_on_left_goal_triggered)
	right_goal.body_entered.connect(_on_right_goal_triggered)
	menu.pvp_pressed.connect(_pvp)
	menu.pvc_pressed.connect(_pvc)
	menu.cvc_pressed.connect(_cvc)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		menu.pause()

func _on_left_goal_triggered(_ball: Node2D) -> void:
	_reset_ball()
	right_paddle_score += 1
	sfx.pitch_scale = randf_range(0.8, 1.6)
	sfx.play()

func _on_right_goal_triggered(_ball: Node2D) -> void:
	_reset_ball()
	left_paddle_score += 1
	sfx.pitch_scale = randf_range(0.8, 1.6)
	sfx.play()

func _reset_ball() -> void:
	ball.compute_initial_velocity()
	ball.position = ball_spawn.position

func _set_game(left_type: String, right_type: String) -> void:
	left_paddle_score = 0
	right_paddle_score = 0
	_reset_ball()
	left_paddle.global_position.y = ball_spawn.global_position.y
	right_paddle.global_position.y = ball_spawn.global_position.y
	left_paddle.paddle = left_type
	right_paddle.paddle = right_type

func _pvp() -> void:
	_set_game("left", "right")

func _pvc() -> void:
	_set_game("left", "cpu")

func _cvc() -> void:
	_set_game("cpu", "cpu")
