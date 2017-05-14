extends Node

# Member variables
var screen_size
var paddle_size
var direction = Vector2(1.0, 0.0)
var hitbox
var has_ball = true



var paddle_movement = Vector2(0,0)

# Constant for pad speed (in pixels/second)
const INITIAL_BALL_SPEED = 80
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 400

func _ready():
    screen_size = get_viewport_rect().size
    hitbox = get_node("Hitbox")

    paddle_size = hitbox.get_node("Sprite").get_texture().get_size()

    set_process_input(true)
    set_fixed_process(true)

func _input(event):
	var movement = null
	
	if(event.is_echo()):
		return
	
	# This doesn't seem like the best way to do this...
	if(get_move() == -1 && event.is_action_released("game_move_left") ||
	   get_move() == 1  && event.is_action_released("game_move_right")):
		movement = 0

	if (event.is_action_pressed("game_move_left")):
		#print("Left")
		movement = -1
	if (event.is_action_pressed("game_move_right")):
		#print("Right")
		movement = 1
		
	if (event.is_action_pressed("game_action")):
		print("Action")
		release_ball()
		
	if(movement != null):
		apply_move(movement)

func get_move():
	return paddle_movement.x

func apply_move(dir):
	paddle_movement.x = dir
	
func release_ball():
	if (has_ball):
		global_signal_manager.emit_signal("signal_release_ball")
		has_ball = false

func _fixed_process(delta):
	hitbox = get_node("Hitbox")
	var paddle = hitbox.get_node("Sprite")
	var paddle_pos = paddle.get_pos()
	var movement = Vector2(0,0)

	movement.x =  paddle_movement.x * (paddle_pos.x + (PAD_SPEED * delta))

	hitbox.move( movement )