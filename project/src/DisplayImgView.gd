extends Control

var img: ImageTexture

onready var scroll_container := $ScrollContainer
onready var view_port_container := $ScrollContainer/ViewportContainer
onready var main_view_port := $ScrollContainer/ViewportContainer/MainViewport
onready var img_texture_rect := $ScrollContainer/ViewportContainer/MainViewport/ImageTextureRect

onready var viewport_preview := $ViewportContainer
onready var preview_image := $ViewportContainer/Viewport/PreviewImageView


func display_image(img):
	self.img = img
	update_size(img)
	img_texture_rect.display_image(img)
	preview_image.display_image(img)

func show_preview():
	viewport_preview.visible = true

func hide_preview():
	viewport_preview.visible = false


func update_size(img: ImageTexture):
	var new_size = img.get_size()
	view_port_container.rect_min_size = new_size
	view_port_container.rect_size = new_size
	main_view_port.size = new_size
	img_texture_rect.rect_min_size = new_size
	img_texture_rect.rect_size = new_size


func get_export_img() -> Image:
	return main_view_port.get_texture().get_data()
