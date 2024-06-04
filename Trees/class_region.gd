extends PanelContainer
class_name ClassRegion

enum tp { CONSTRUCTORS, VARIABLES, PROPERTIES, SIGNALS, CALLBACKS, METHODS }
enum sz { ONE, ONE_FIVE, TWO }

@export var type : tp = 1
@export var header : ClassRegionHeader


func _ready():
	if header != null:
		setup_size_buttons()

func configure_type(to_type:tp):
	type = tp
	%Label.text = tp.keys()[int(type)]


func setup_size_buttons():
	header.space_1x_btn.pressed.connect(set_min_horiz_size.bind(sz.ONE))
	header.space_1_5x_btn.pressed.connect(set_min_horiz_size.bind(sz.ONE_FIVE))
	header.space_2x_btn.pressed.connect(set_min_horiz_size.bind(sz.TWO))

func set_min_horiz_size(n_size:sz):
	var n_x = 256 if n_size == sz.ONE else 384 if n_size == sz.ONE_FIVE else 512
	custom_minimum_size = Vector2i(n_x, 0)
