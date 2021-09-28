extends Control

onready var button_select := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonSelect
onready var button_export := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonExport
onready var button_grid_edit := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonLineEdit
onready var button_preview := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonPreview
onready var button_show_grid := $VBoxContainer/Panel/MarginContainer/HBoxContainer/ButtonShowGrid

onready var file_dialog := $FileDialog
onready var display_img_view := $VBoxContainer/DisplayImgView
onready var preview_image_view := $VBoxContainer/DisplayImgView/ViewportContainer/Viewport/PreviewImageView
onready var grid_edit_view := $GridEditView
onready var export_dialog := $ExportDialog
onready var path_dialog := $PathDialog

func _ready():
	file_dialog.current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	file_dialog.connect("file_selected", self, "_on_file_image_selected")

	path_dialog.connect("confirmed", self, "_on_confirm_path_dialog")
	export_dialog.connect("click_btn_browse", self, "_on_click_buton_browse")

	button_select.connect("button_down", self, "_on_tap_button_select_file")
	button_export.connect("button_down", self, "_on_tap_button_export_file")
	button_grid_edit.connect("button_down", self, "_on_tap_button_grid_edit")
	button_preview.connect("toggled", self, "_on_toggled_button_preview")
	button_show_grid.connect("toggled", self, "_on_toggled_button_show_grid")
	
	button_export.disabled = true
	button_grid_edit.disabled = true
	button_preview.disabled = true
	button_show_grid.disabled = true


func _on_tap_button_select_file():
	file_dialog.popup()

func _on_tap_button_export_file():
	var image: Image = display_img_view.get_export_img()
	image.flip_y()
	export_dialog.show_export_dialog(image, AppSetting.directory_path, AppSetting.file_name)

func _on_click_buton_browse():
	path_dialog.current_dir = AppSetting.directory_path
	path_dialog.popup()

func _on_confirm_path_dialog():
	var path_selected = path_dialog.current_dir
	export_dialog.update_folder_path(path_selected)

func _on_tap_button_grid_edit():
	grid_edit_view.popup()

func _on_toggled_button_preview(button_pressed: bool):
	if button_pressed:
		display_img_view.show_preview()
	else:
		display_img_view.hide_preview()

func _on_toggled_button_show_grid(button_pressed: bool):
	if button_pressed:
		display_img_view.show_grid()
	else:
		display_img_view.hide_grid()


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
	button_preview.disabled = false
	button_show_grid.disabled = false

	var img_texture := ImageTexture.new()
	img_texture.create_from_image(image, 0)
	display_img_view.img = img_texture
