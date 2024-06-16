@tool
extends Control
class_name GameInfo

#@export var setup_game_tps : bool

@onready var graph_edit = $GraphEdit
@onready var game_type_opts = %GameTypeOpts
@onready var proj_title_line_edit = %ProjTitleLineEdit
@onready var description_text_edit = %DescriptionTextEdit
@onready var goals_text_edit = %GoalsTextEdit
@onready var lore_text_edit = %LoreTextEdit

var main : NodedMain

# SAVE KEYS
const GAMETP = 'GAMETP'
const TITLE = 'TITLE'
const DESCRIPT = 'DESCRIPT'
const GOALS = 'GOALS'
const LORE = 'LORE'

const game_tps := [
	"Action Game",
	"Platformer",
	"Shooter Game",
	"First-Person Shooter",
	"Third-Person Shooter",
	"Fighting Game",
	"Beat 'em Up",
	"Stealth Game",
	"Survival Game",
	"Rhythm Game",
	"Adventure Game",
	"Text Adventure",
	"Graphic Adventure",
	"Visual Novel",
	"Interactive Movie",
	"Point-and-Click Adventure",
	"Role-Playing Game",
	"Action RPG",
	"Tactical RPG",
	"Japanese RPG",
	"Western RPG",
	"Massively Multiplayer Online RPG",
	"Roguelike",
	"Roguelite",
	"Simulation Game",
	"Life Simulation",
	"Vehicle Simulation",
	"Flight Simulator",
	"Racing Simulator",
	"Construction and Management Simulation",
	"Sports Simulation",
	"Strategy Game",
	"Real-Time Strategy",
	"Turn-Based Strategy",
	"4X Game",
	"Tower Defense",
	"MOBA",
	"Grand Strategy",
	"Sports Game",
	"Traditional Sport",
	"Extreme Sport",
	"Racing Game",
	"Sports Management",
	"Puzzle Game",
	"Logic Puzzle",
	"Match-3 Game",
	"Physics-Based Puzzle",
	"Hidden Object Game",
	"Party Game",
	"Trivia Game",
	"Board Game",
	"Card Game",
	"Minigame Collection",
	"Casual Game",
	"Idle Game",
	"Mobile Game",
	"Social Network Game",
	"Horror Game",
	"Survival Horror",
	"Psychological Horror",
	"Music and Rhythm Game",
	"Dance Game",
	"Instrument Simulation",
	"Sandbox Game",
	"Open World Game",
	"Creative Game",
	"Educational Game",
	"Edutainment",
	"Brain Training",
	"Language Learning Game",
	"VR Game",
	"AR Game",
	"Virtual Reality Game",
	"Augmented Reality Game",
	"Indie Game",
	"Experimental Game",
	"Niche Genre"
]


## CALLBACKS -----------------------------------------------------------------##

func setup_from_data(g_data:NodedData):
	var data = g_data.game_meta_data
	
	proj_title_line_edit.text = data.proj_title
	game_type_opts.selected = data.categ_id
	
	description_text_edit.text = data.descript
	goals_text_edit.text = data.goals
	lore_text_edit.text = data.lore

func _ready():
	var gm_tp_btn := %GameTypeOpts as OptionButton
	gm_tp_btn.clear()
	
	for gtype in game_tps:
		gm_tp_btn.add_item(gtype)


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	return {
		TITLE:proj_title_line_edit.text,
		GAMETP:game_type_opts.selected,
		DESCRIPT:description_text_edit.text,
		GOALS:goals_text_edit.text,
		LORE:lore_text_edit.text
	}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	self.main = main
	
	proj_title_line_edit.text = dict[TITLE]
	game_type_opts.selected = dict[GAMETP]
	description_text_edit.text = dict[DESCRIPT]
	goals_text_edit.text = dict[GOALS]
	lore_text_edit.text = dict[LORE]
	
	print(name, " Noded data updated!")
	pass


## FUNCTIONALITY -------------------------------------------------------------##

func _on_proj_title_line_edit_text_submitted(new_text):
	proj_title_line_edit.release_focus()
