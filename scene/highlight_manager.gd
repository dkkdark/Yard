extends Node2D

var active_highlights = []

func _process(delta):
	for el in active_highlights:
		if active_highlights.size() != 1:
			await el.draw_highlight.call()
		else:
			await el.highlight_animation_stop.call()


func register_highlight(highlight: HighlightClickable):
	active_highlights.push_back(highlight)

func unregister_highlight(highlight: HighlightClickable):
	if active_highlights.size() > 1:
		var idx = active_highlights.find(highlight)
		for el in active_highlights.size():
			if el != idx:
				await active_highlights[el].remove_highlight.call()
				active_highlights.remove_at(el)
