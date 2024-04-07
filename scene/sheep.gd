extends CharacterBody2D

@onready var highlight_clickable: HighlightClickable = $HighlightClickable
@onready var game_field: TileMap = $"../GameField"

var _width : float = 4.4
var _max_width : float = 5
var _time : float = 0

var is_animation_work = false
var should_draw = false

var moving_allow = false
var moving_position = Vector2(-1, -1)
var wait_path = false

func _ready():
	play_highlight_animation()
	
	highlight_clickable.draw_highlight = Callable(self, "_on_draw_highlight")
	highlight_clickable.remove_highlight = Callable(self, "_on_remove_highlight")
	highlight_clickable.highlight_animation_stop = Callable(self, "_on_highlight_animation_stop")
	highlight_clickable.can_build_path = Callable(self, "_draw_path")

func _move_sprite(path: Array):
	if path.is_empty():
		return
	moving_allow = true
	var current_pos = path[0]
	for el in path:
		var target_destination = Vector2i(
			el.x,
			el.y
		)
		moving_position = game_field.map_to_local(target_destination)
		moving_position = game_field.to_global(moving_position)
		if global_position == moving_position:
			moving_allow = false
		await get_tree().create_timer(0.3).timeout 

func _draw_path(can_build):
	if can_build:
		wait_path = true
	game_field.can_build = can_build

func _on_draw_highlight():
	is_animation_work = true
	should_draw = true
	
func _on_remove_highlight():
	is_animation_work = false
	should_draw = false
	
func _on_highlight_animation_stop():
	is_animation_work = false

func _process(delta : float):
	if wait_path:
		game_field.move_by_path = Callable(self, "_move_sprite")
		wait_path = false
	
	if moving_allow:
		global_position = global_position.move_toward(moving_position, 200*delta)
	
	if is_animation_work:
		animate_highliting(delta)
	else:
		_width = 2
		queue_redraw()
	
func play_highlight_animation():
	$AnimationPlayer.play("highlighting")

func animate_highliting(delta):
	_time += delta
	_width = abs(sin(_time) * _max_width)
	queue_redraw()

func _draw():
	if should_draw:
		var center = Vector2(0, 0)
		var radius = 20
		var points = 30
		var color = Color(255, 255, 255)
		draw_arc(center, radius, 0, TAU, points, color, _width)
				
