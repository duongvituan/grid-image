extends TextureRect

onready var main_viewport := get_viewport()

var img: ImageTexture


func _ready():
	AppSetting.connect("update", self, "_on_need_to_update")

func _draw():
	var cell_number = AppSetting.number_cell
	var color = AppSetting.get_current_color()
	var width = AppSetting.line_width
	draw_grip(cell_number, color, width)


func display_image(img):
	self.img = img
	self.texture = img
	update()


func draw_grip(cell_number: int, color: Color, width: float):
	if img == null:
		return 
	var img_size = img.get_size()
	var w = img_size.x / cell_number
	
	var number_cell_vertical = cell_number
	for i in range(number_cell_vertical + 1):
		var x = i * w
		var from_point = Vector2(x, 0)
		var to_point = Vector2(x, img_size.y)
		draw_line(from_point, to_point, color, width)
	
	var number_cell_horizontal = int(img_size.y / w)
	for i in range(number_cell_horizontal + 1):
		var y = i * w
		var from_point = Vector2(0, y)
		var to_point = Vector2(img_size.x, y)
		draw_line(from_point, to_point, color, width)
	
	draw_line(Vector2(0, img_size.y-1), Vector2(img_size.x, img_size.y-1), color, width)

func _on_need_to_update():
	update()
