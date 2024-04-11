extends Node2D
class_name StepsHandler

var idle = 0
var steps = 0
var is_on_idle_place = false

func count_step():
	StepsManager.register_step(self)

func _ready():
	StepsManager.add_steps_reducer(self)
	
var go_away: Callable = func():
	pass
