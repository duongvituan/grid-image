extends Control

var img: ImageTexture

onready var scroll_container := $ScrollContainer
onready var view_port_container := $ScrollContainer/ViewportContainer
onready var view_port := $ScrollContainer/ViewportContainer/MainViewport
onready var main_texture := $ScrollContainer/ViewportContainer/MainViewport/MainTexture


func get_export_img() -> Image:
	return view_port.get_texture().get_data()


func display_image(img):
	self.img = img
	update_size(img)
	main_texture.display_image(img)


func update_size(img: ImageTexture):
	var new_size = img.get_size()
	view_port_container.rect_min_size = new_size
	view_port_container.rect_size = new_size
	view_port.size = new_size
	main_texture.rect_min_size = new_size
	main_texture.rect_size = new_size
