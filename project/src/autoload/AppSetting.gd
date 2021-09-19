extends Node

signal update()

var ALL_LINE_COLOR = [
	ColorItem.new("Red", Color.red),
	ColorItem.new("Green", Color.green),
	ColorItem.new("Blue", Color.blue),
	ColorItem.new("Black", Color.black),
	ColorItem.new("White", Color.white)
	]

var index_item_color = 0
var line_width = 1
var number_cell = 5


func get_current_color() -> Color:
	return ALL_LINE_COLOR[index_item_color].color

func need_to_update():
	emit_signal("update")
