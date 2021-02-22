extends BitmapFont
tool

# TODO: Add setget to update font resource
export(String) var characters: String = ""
export(Texture) var font_texture: Texture = null
export(int) var char_width: int = 8 \
	setget set_char_width, get_char_width
export(int) var char_height: int = 10 \
	setget set_char_height, get_char_height

func set_char_width(p_width: int) -> void:
	char_width = p_width
	_update_font()

func get_char_width() -> int:
	return char_width

func set_char_height(p_height: int) -> void:
	char_height = p_height
	_update_font()

func get_char_height() -> int:
	return char_height

func _update_font() -> void:
	clear()
	add_texture(font_texture)
	_add_all_characters()

func _add_all_characters() -> void:
	var rect = Rect2(1.0, 1.0, char_width, char_height)
	for i in range(characters.length()):
		add_char(characters.ord_at(i), 0, rect, Vector2(), char_width)
		rect.position.x += char_width
