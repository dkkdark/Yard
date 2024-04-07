extends Area2D
class_name HighlightClickable


func _input_event(_viewport, event, _shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		HighlightManager.unregister_highlight(self)
		
		await self.can_build_path.call(true)
		
func _process(delta):
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		await self.can_build_path.call(false)
		
func _ready():
	HighlightManager.register_highlight(self)

var draw_highlight: Callable = func():
	pass
var highlight_animation_stop: Callable = func():
	pass
var remove_highlight: Callable = func():
	pass
var can_build_path: Callable = func():
	pass
