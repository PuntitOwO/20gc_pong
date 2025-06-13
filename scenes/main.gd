extends Node2D

@onready var ball_spawn: Marker2D = $BallSpawn
@onready var ball: Ball = $Ball
@onready var left_goal: Area2D = $LeftGoal
@onready var right_goal: Area2D = $RightGoal

@onready var left_paddle_score := 0
@onready var right_paddle_score := 0

@onready var left_score: Label = $LeftScore
@onready var right_score: Label = $RightScore

func _ready() -> void:
	left_goal.body_entered.connect(_on_left_goal_triggered)
	right_goal.body_entered.connect(_on_right_goal_triggered)

func _on_left_goal_triggered(_ball: Node2D) -> void:
	_reset_ball()
	right_paddle_score += 1
	right_score.text = str(right_paddle_score)

func _on_right_goal_triggered(_ball: Node2D) -> void:
	_reset_ball()
	left_paddle_score += 1
	left_score.text = str(left_paddle_score)

func _reset_ball() -> void:
	ball.compute_initial_velocity()
	ball.position = ball_spawn.position
