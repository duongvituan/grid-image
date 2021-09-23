class_name GridTextureRect extends TextureRect

var img: ImageTexture


func _ready():
	AppSetting.connect("update", self, "_need_to_update")


func _need_to_update():
	update() # system will auto call func _draw() when call func update()


func _draw():
	var cell_number = AppSetting.number_cell
	var color = AppSetting.get_current_color()
	var width = AppSetting.line_width
	draw_grip(cell_number, color, width)


func display_image(img):
	self.img = img
	self.texture = img
	_need_to_update()


func get_display_img_size():
	if img == null:
		return null
	return img.get_size()


func get_origin_img() -> Vector2:
	return Vector2.ZERO


func draw_grip(cell_number: int, color: Color, width: float):
	var origin_img = get_origin_img()
	if origin_img == null or img == null:
		return 
	
	var img_size = get_display_img_size()
	var w = img_size.x / cell_number
	
	var number_cell_vertical = cell_number
	for i in range(number_cell_vertical + 1):
		var x = origin_img.x + i * w
		var from_point = Vector2(x, origin_img.y)
		var to_point = Vector2(x, origin_img.y + img_size.y)
		draw_line(from_point, to_point, color, width)
	
	var number_cell_horizontal = int(img_size.y / w)
	for i in range(number_cell_horizontal + 1):
		var y = origin_img.y + i * w
		var from_point = Vector2(origin_img.x, y)
		var to_point = Vector2(origin_img.x + img_size.x, y)
		draw_line(from_point, to_point, color, width)
