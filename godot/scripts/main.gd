extends Node2D

@onready var player: CharacterBody2D = $Player

var move_target := Vector2.ZERO
var touch_active := false
var speed := 155.0

func _ready() -> void:
	move_target = player.position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.position.x < get_viewport_rect().size.x * 0.55:
			touch_active = event.pressed
			move_target = event.position
	elif event is InputEventScreenDrag and touch_active:
		move_target = event.position

func _physics_process(_delta: float) -> void:
	var keyboard := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := keyboard

	if touch_active:
		var delta := move_target - player.position
		if delta.length() > 20.0:
			direction = delta.normalized()
		else:
			direction = Vector2.ZERO

	player.velocity = direction * speed
	player.move_and_slide()
