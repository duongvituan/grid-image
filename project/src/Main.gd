extends Control

onready var button_select := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonSelect
onready var button_export := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonExport
onready var button_grid_edit := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonLineEdit

onready var file_dialog := $FileDialog
onready var display_img_view := $VBoxContainer/DisplayImgView
onready var grid_edit_view := $GridEditView
onready var export_dialog := $ExportDialog

func _ready():
	file_dialog.current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	file_dialog.connect("file_selected", self, "_on_file_image_selected")

	export_dialog.connect("confirmed", self, "_on_confirm_export_dialog")
	export_dialog.current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	export_dialog.current_file = "untitled.png"

	button_select.connect("button_down", self, "_on_tap_button_select_file")
	button_export.connect("button_down", self, "_on_tap_button_export_file")
	button_grid_edit.connect("button_down", self, "_on_tap_button_grid_edit")
	
	button_export.disabled = true
	button_grid_edit.disabled = true


func _on_tap_button_select_file():
	file_dialog.popup()

func _on_tap_button_export_file():
	export_dialog.popup()

func _on_tap_button_grid_edit():
	grid_edit_view.popup()


func _on_confirm_export_dialog():
	var image: Image = display_img_view.get_export_img()
	image.flip_y()
	image.save_png(export_dialog.current_path)


func _on_file_image_selected(path):
	print(path)
#	OS.shell_open(path)
	handle_loading_files(path)


func handle_loading_files(path: String) -> void:
	var image := Image.new()
	var err := image.load(path)
	if err != OK:
		print(err)
		return
	button_export.disabled = false
	button_grid_edit.disabled = false

	var img_texture := ImageTexture.new()
	img_texture.create_from_image(image, 0)
	display_img_view.display_image(img_texture)
