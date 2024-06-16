@tool
extends PanelContainer
class_name ItemEditDisplay

@onready var id_label = %IDLabel
@onready var name_edit = %NameEdit
@onready var description_edit = %DescriptionEdit

@onready var price_spin_box = %PriceSpinBox
@onready var min_lvl_spin_box = %MinLvlSpinBox

@onready var stack_spin_box_3 = %StackSpinBox3
@onready var weight_spin_box_4 = %WeightSpinBox4

@onready var tradeable_toggle = %TradeableToggle
@onready var droppable_toggle = %DroppableToggle
@onready var sellable_toggle = %SellableToggle

@onready var categoriy_picker = %CategoriyPicker
@onready var rarity_slider = %RaritySlider
@onready var tags_edit = %TagsEdit
@onready var rarity_name_label = %RarityNameLabel

@onready var pickers_root = %PickersRoot
@onready var item_icon = %ItemIcon


var item : NodedItem
var manager : ItemsManagement


func setup_from_path(itm:NodedItem, i_manager:ItemsManagement):
	item = itm
	manager = i_manager
	
	var ico_picker := EditorResourcePicker.new()
	ico_picker.base_type = "Texture2D"
	pickers_root.add_child(ico_picker)
	ico_picker.resource_changed.connect(item_icon_changed)
	pickers_root.move_child(ico_picker, 2)
	
	if item.icon:
		ico_picker.edited_resource = item.icon
	
	var model_picker := EditorResourcePicker.new()
	model_picker.base_type = "PackedScene"
	pickers_root.add_child(model_picker)
	model_picker.resource_changed.connect(item_model_changed)
	
	if item.model:
		model_picker.edited_resource = item.model
	
	refresh_items_data()

func refresh_items_data():
	id_label.text = item.id
	item_icon.texture = item.icon
	
	price_spin_box.value = item.price
	min_lvl_spin_box.value = item.level_requirement
	stack_spin_box_3.value = item.stack_size
	weight_spin_box_4.value = item.weight
	
	tradeable_toggle.button_pressed = item.tradeable
	droppable_toggle.button_pressed = item.droppable
	sellable_toggle.button_pressed = item.sellable
	
	var categs := NodedItem.item_categories
	categoriy_picker.selected = -1
	var iteration := 0
	for c in categs:
		categoriy_picker.add_item(c)
		if c == item.category:
			categoriy_picker.selected = iteration
		iteration += 1
	
	var rares := NodedItem.rarities
	rarity_name_label.text = rares[item.rarity]
	rarity_slider.value = item.rarity
	
	var tags := ''
	for t in item.tags:
		tags += str(t + ", ")
	tags_edit.text = tags


func item_icon_changed(new_icon):
	item_icon.texture = new_icon
	item.icon = new_icon

func item_model_changed(new_model):
	item.model = new_model


func _on_name_edit_text_submitted(new_text):
	name_edit.release_focus()
	item.name = new_text

func _on_description_edit_text_changed():
	item.description = description_edit.text

func _on_price_spin_box_value_changed(value):
	item.price = value

func _on_min_lvl_spin_box_value_changed(value):
	item.level_requirement = value

func _on_stack_spin_box_3_value_changed(value):
	item.stack_size = value

func _on_weight_spin_box_4_value_changed(value):
	item.stack_size = value

func _on_tradeable_toggle_toggled(toggled_on):
	item.tradeable = toggled_on
	tradeable_toggle.release_focus()

func _on_droppable_toggle_toggled(toggled_on):
	item.droppable = toggled_on
	droppable_toggle.release_focus()

func _on_sellable_toggle_toggled(toggled_on):
	item.sellable = toggled_on
	sellable_toggle.release_focus()

func _on_categoriy_picker_item_selected(index):
	item.category = categoriy_picker.get_item_text(categoriy_picker.get_selected_id())
	categoriy_picker.release_focus()

func _on_rarity_slider_value_changed(value):
	item.rarity = value
	rarity_name_label.text = NodedItem.rarities[item.rarity]

func _on_tags_edit_text_changed():
	var tags := (tags_edit.text as String).split(',') as PackedStringArray
	item.tags = tags

