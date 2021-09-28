extends Control

var img: ImageTexture setget _set_image

onready var scroll_container := $ScrollContainer
onready var view_port_container := $ScrollContainer/ViewportContainer
onready var main_view_port := $ScrollContainer/ViewportContainer/MainViewport
onready var img_texture_rect := $ScrollContainer/ViewportContainer/MainViewport/ImageTextureRect

onready var viewport_preview := $ViewportContainer
onready var preview_image := $ViewportContainer/Viewport/PreviewImageView


func _set_image(image):
	img = image
	_update_size(image)
	img_texture_rect.img = image
	preview_image.img = image

func show_preview():
	viewport_preview.visible = true

func hide_preview():
	viewport_preview.visible = false

func show_grid():
	img_texture_rect.is_show_grid = true
	preview_image.is_show_grid = true

func hide_grid():
	img_texture_rect.is_show_grid = false
	preview_image.is_show_grid = false

func _update_size(img: ImageTexture):
	var new_size = img.get_size()
	view_port_container.rect_min_size = new_size
	view_port_container.rect_size = new_size
	main_view_port.size = new_size
	img_texture_rect.rect_min_size = new_size
	img_texture_rect.rect_size = new_size


func get_export_img() -> Image:
	return main_view_port.get_texture().get_data()
