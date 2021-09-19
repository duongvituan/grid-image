extends ConfirmationDialog

onready var number_cell_edit := $VBoxContainer/HBoxContainer/LineEdit
onready var line_width_edit := $VBoxContainer/HBoxContainer2/LineEdit
onready var line_color_option_button := $VBoxContainer/HBoxContainer3/OptionButton


func _ready():
	var all_colors = AppSetting.ALL_LINE_COLOR
	for i in range(all_colors.size()):
		line_color_option_button.add_item(all_colors[i].name, i)
	
	line_color_option_button.connect("item_selected", self, "_on_line_color_selected")
	number_cell_edit.connect("text_changed", self, "_on_number_cell_change")
	line_width_edit.connect("text_changed", self, "_on_line_width_change")
	_update()


func _update():
	line_color_option_button.selected = AppSetting.index_item_color
	line_width_edit.text = String(AppSetting.line_width)
	number_cell_edit.text = String(AppSetting.number_cell)


func popup(bounds: Rect2 = Rect2(0, 0, 0, 0)):
	.popup(bounds)
	_update()


func _on_line_color_selected(index):
	AppSetting.index_item_color = index
	AppSetting.need_to_update()


func _on_number_cell_change(new_text):
	var value = int(new_text)
	if not value:
		return
	AppSetting.number_cell = value
	AppSetting.need_to_update()


func _on_line_width_change(new_text):
	var value = float(new_text)
	if not value:
		return
	AppSetting.line_width = value
	AppSetting.need_to_update()
