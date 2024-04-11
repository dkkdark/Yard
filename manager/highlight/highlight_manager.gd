extends Node2D

var active_highlights = []
var is_highlight = false

func _process(delta):
	if active_highlights.size() > 0 && is_highlight:
		for el in active_highlights:
			await el.draw_highlight.call(true)

func register_highlight(highlight: HighlightClickable):
	active_highlights.push_back(highlight)
	turn_on_highlight()

func unregister_highlight(highlight: HighlightClickable):
	if active_highlights.size() > 0:
		for el in active_highlights.size():
			await active_highlights[el].draw_highlight.call(false)
			is_highlight = false

func turn_on_highlight():
	is_highlight = true
