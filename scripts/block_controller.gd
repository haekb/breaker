extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var block_score = 1

func _ready():
	
	global_signal_manager.connect("signal_block_hit", self, "on_block_hit")	
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func on_block_hit():
	global_signal_manager.emit_signal("signal_increase_score", block_score)
	pass