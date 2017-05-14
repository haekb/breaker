extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hitbox
var ball

var ballbox
const BALL_INITIAL_SPEED = 200
var ball_direction

var ball_released = false
var ball_speed = BALL_INITIAL_SPEED

var bounce = 0.65

func _ready():
	print("Ball Ready")
	ballbox = get_node("Ballbox")
	
	ball_direction = Vector2(ceil(rand_range(-2,1)), -1)
	
	# FIXME: This ain't right
	hitbox = get_parent().get_node("Hitbox")
	ball = ballbox.get_node("Sprite")
	global_signal_manager.connect("signal_release_ball", self, "on_ball_release")

	set_fixed_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
	
func _fixed_process(delta):
	if(!ball_released):
		# Move the ball with the paddle until the ball is freee
		ballbox.set_pos(hitbox.get_pos())
		return
		
	var ball_pos = ball.get_pos()
	var movement = Vector2(0,0)

	movement.x = ball_direction.x * (ball_pos.x + (ball_speed * delta))
	movement.y = ball_direction.y * (ball_pos.y + (ball_speed * delta))
	
	if(ballbox.is_colliding()):
		var normal = ballbox.get_collision_normal()
		movement = normal.reflect(movement) * bounce
		ball_direction = normal.reflect(ball_direction)
		global_signal_manager.emit_signal("signal_block_hit", ballbox.get_collider())




	ballbox.move( movement )
	

func on_ball_release():
	print("RELEASE THE BALLL")
	ball_released = true