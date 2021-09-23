class_name PreviewImageView extends GridTextureRect

onready var main_viewport := get_viewport()

func _ready():
	main_viewport.connect("size_changed", self, "_need_to_update")


func _need_to_update():
	self.rect_size = get_viewport_rect().size
	_update_mode_preview()
	update()


func _update_mode_preview():
	if self.img == null:
		return
	var current_img_size = img.get_size()
	
	if (current_img_size.x > rect_size.x or current_img_size.y > rect_size.y)\
		and stretch_mode != STRETCH_KEEP_ASPECT_CENTERED:
		stretch_mode = STRETCH_KEEP_ASPECT_CENTERED

	elif (current_img_size.x <= rect_size.x and current_img_size.y <= rect_size.y)\
		and stretch_mode != STRETCH_KEEP_CENTERED:
		stretch_mode = STRETCH_KEEP_CENTERED


func get_aspect_size(frame_size: Vector2, img_size: Vector2) -> Vector2:
	var weight = min(frame_size.x, img_size.x * frame_size.y / img_size.y)
	var height = min(frame_size.y, img_size.y * frame_size.x / img_size.x)
	return Vector2(weight, height)


func get_display_img_size():
	if img == null:
		return null

	if stretch_mode == STRETCH_KEEP_ASPECT_CENTERED:
		return get_aspect_size(rect_size, img.get_size())
	
	if stretch_mode == STRETCH_KEEP_CENTERED:
		return img.get_size()
	return img.get_size()


func get_origin_img():
	if img == null:
		return null
	var img_size = img.get_size()
	
	if stretch_mode == STRETCH_KEEP_ASPECT_CENTERED:
		var display_img_size = get_display_img_size()
		return (rect_size - display_img_size) / 2.0
	
	if stretch_mode == STRETCH_KEEP_CENTERED:
		return Vector2((rect_size.x - img_size.x) / 2.0, (rect_size.y - img_size.y) / 2.0)
	
	return Vector2((rect_size.x - img_size.x) / 2.0, (rect_size.y - img_size.y) / 2.0)
