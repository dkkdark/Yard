extends TileMap
class_name GameField

var path = []
var can_build = false
var visited = Vector2i(-1,-1)

func _process(delta):
	if can_build:
		build_path()

func build_path():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var tile = local_to_map(to_local(get_global_mouse_position()))
		
		if path.find(tile) == -1:
			visited = tile
			path.push_back(tile)
			set_cell(1, tile, 0, Vector2i(9,7), 0)
		
		if visited != tile and path.find(tile) != -1:
			var idx = path.find(tile)
			for el in range(idx, path.size()):
				erase_cell(1, path[el])
			while path.size() != idx:
				path.remove_at(path.size() - 1)
		
	else:
		if !path.is_empty():
			await move_by_path.call(path.slice(1))
			for el in path:
				erase_cell(1, el)
			path.clear()


var move_by_path: Callable = func(path):
	pass
