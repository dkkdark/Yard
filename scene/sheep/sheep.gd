extends CharacterBody2D

@onready var highlight_clickable: HighlightClickable = $HighlightClickable
@onready var game_field: TileMap = $"../GameField"
@onready var steps_handler: StepsHandler = $StepsHandler

var should_draw = false

var moving_path_allow = false
var moving_position = Vector2(-1, -1)
var wait_path = false

var is_go_away = false
var go_away_pos = Vector2(-1, -1)

func _ready():	
	highlight_clickable.draw_highlight = Callable(self, "_on_draw_highlight")
	highlight_clickable.can_build_path = Callable(self, "_draw_path")
	steps_handler.go_away = Callable(self, "_on_go_away")

func _on_go_away():
	var current_pos = game_field.local_to_map(position)
	var target_destination = Vector2i(
		current_pos.x + 0,
		current_pos.y + 1
	)
	var local_pos = game_field.map_to_local(target_destination)
	go_away_pos = game_field.to_global(local_pos)
	is_go_away = true
	await get_tree().create_timer(0.5).timeout 
	is_go_away = false

func _move_sprite(path: Array):
	if path.is_empty():
		highlight_clickable.turn_on_highlight()
		return
		
	for el in path:
		var target_destination = Vector2i(
			el.x,
			el.y
		)
		var local_pos = game_field.map_to_local(target_destination)
		moving_position = game_field.to_global(local_pos)
		moving_path_allow = true
		steps_handler.count_step()
		print(self, " moving_path_allow", global_position, moving_position)
		await get_tree().create_timer(0.5).timeout 
		moving_path_allow = false
	
	highlight_clickable.turn_on_highlight()

func _draw_path(can_build):
	if can_build:
		wait_path = true
	game_field.can_build = can_build

func _on_draw_highlight(draw: bool):
	should_draw = draw

func _process(delta : float):
	play_highlight_animation()
	if wait_path:
		game_field.move_by_path = Callable(self, "_move_sprite")
		wait_path = false
	
	if moving_path_allow:
		global_position = global_position.move_toward(moving_position, 200*delta)
	if is_go_away:
		global_position = global_position.move_toward(go_away_pos, 300*delta)
	
func play_highlight_animation():
	if should_draw:
		$AnimationPlayer.play("highlighting")
	else:
		$AnimationPlayer.stop()
