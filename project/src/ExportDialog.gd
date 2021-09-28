extends AcceptDialog

signal click_btn_browse()

onready var path_line_edit := $VBoxContainer/HBoxContainer/LineEdit
onready var file_name_line_edit := $VBoxContainer/HBoxContainer2/LineEdit
onready var browse_button := $VBoxContainer/HBoxContainer/Button

var img: Image

func _ready():
	connect("confirmed", self, "_on_confirmed")
	browse_button.connect("button_down", self, "_on_click_browse_button")


func get_export_path() -> String:
	return path_line_edit.text + "/" + file_name_line_edit.text + ".png"


func update_folder_path(folder_path: String):
	path_line_edit.text = folder_path


func show_export_dialog(img: Image, folder_path: String, file_name: String):
	self.img = img
	path_line_edit.text = folder_path
	file_name_line_edit.text = file_name
	popup()


func _on_click_browse_button():
	emit_signal("click_btn_browse")

func _on_confirmed():
	if img == null:
		return
	var export_path = get_export_path()
	print(export_path)
	img.save_png(export_path)
