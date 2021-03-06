extends KinematicBody2D

onready var trail = $Trail

var move_pressed = false

# movement variables
var destination = Vector2()
var target_position = Vector2()
var velocity = Vector2()
var speed = 0
var max_speed = 500
var acceleration = 500
var is_moving = false

func _ready():
	var planets = get_tree().get_nodes_in_group("planets")
	for planet in planets:
		planet.connect("click_move", self, "_update_destination")

	var trades = get_tree().get_nodes_in_group("trade")
	for trade in trades:
		trade.connect("trade_amount", self, "_conduct_trade")

# Updates the ships destination
func _update_destination(target_position):
	destination = target_position
	is_moving = true

# Moves the ship to the target destination at the set speed
func _physics_process(delta):
	_movement_loop(delta)
		
func _movement_loop(delta):
	var new_scale = 1
	if is_moving == false:
		speed = 0
		trail.emitting = false
	else:
		speed += acceleration * delta
		trail.emitting = true
		if speed > max_speed:
			speed = max_speed
		new_scale = 1 + 2.5 * (speed / max_speed)
	scale = Vector2(new_scale, new_scale)
	
	velocity = position.direction_to(destination) * speed
	look_at(destination)
	if position.distance_to(destination) > 5:
		velocity = move_and_slide(velocity)
	else:
		is_moving = false
