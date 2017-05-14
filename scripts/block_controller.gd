extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var block_score = 1
var blockbox

func _ready():
	blockbox = get_node("Blockbox")
	global_signal_manager.connect("signal_block_hit", self, "on_block_hit")	
	# Called every time the node is added to the scene.
	# Initialization here

func on_block_hit(other):
	# Ignore others
	if(other != blockbox):
		return
		
	#print("score increase! "+ str(block_score))
	global_signal_manager.emit_signal("signal_increase_score", block_score)
	# remove the blockbox
	blockbox.free()

