extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var score = 0
var score_label

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	score_label = get_node("Game Objects").get_node("Score")
	global_signal_manager.connect("signal_increase_score", self, "on_score_increase")
	set_score_label()
	
	pass

func on_score_increase(score_increase):
	score += score_increase
	set_score_label()
	
	
func set_score_label():
	score_label.set_text("Score: "+str(score))