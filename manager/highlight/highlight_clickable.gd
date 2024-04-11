extends Area2D
class_name HighlightClickable


func _input_event(_viewport, event, _shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if HighlightManager.is_highlight:
			await self.can_build_path.call(true)
		HighlightManager.unregister_highlight(self)
		
func _process(delta):
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		await self.can_build_path.call(false)
		
func _ready():
	HighlightManager.register_highlight(self)
	turn_on_highlight()
	
func turn_on_highlight():
	HighlightManager.turn_on_highlight()

var draw_highlight: Callable = func(draw):
	pass
var can_build_path: Callable = func():
	pass
