@tool
extends Resource
class_name NodedItem

# Item Identification
@export var id: StringName
@export var name: String
@export var description: String

# Item Type and Classification
@export var category: String
@export var rarity: int ## 0-5 => "Common", "Uncommon", "Rare", "Very Rare", "Epic"
@export var tags: PackedStringArray

# Appearance and Representation
@export var icon: Texture2D
@export var model: PackedScene

# Attributes and Stats
#var base_stats: Dictionary
#var modifiers: Dictionary

# Usage and Effects
#@export var usable: bool
#@export var effect: String
#@export var cooldown: float

# Acquisition and Requirements
@export var price: float = 1.0
@export var level_requirement: int
#@export var quest_requirement: PackedStringArray

# Inventory and Storage
@export var stack_size: int
@export var weight: float

# Interactions
@export var tradeable: bool
@export var droppable: bool
@export var sellable: bool

# Crafting and Enhancements
@export var crafting_recipe: Dictionary
#var enhancements: Array

# Metadata
@export var version: String
@export var notes: String


const rarities := [ "Common", "Uncommon", "Rare", "Very Rare", "Epic" ]

const item_categories = [
	"Weapon",
	"Armor",
	"Potion",
	"Consumable",
	"Crafting Material",
	"Quest Item",
	"Key Item",
	"Accessory",
	"Tool",
	"Ammunition",
	"Currency",
	"Skill Book",
	"Treasure",
	"Furniture",
	"Clothing",
	"Vehicle",
	"Miscellaneous"
]

const item_effects = [
	"Health Restoration",
	"Mana Restoration",
	"Temporary Buff",
	"Permanent Buff",
	"Temporary Debuff",
	"Damage",
	"Healing Over Time",
	"Damage Over Time",
	"Shield",
	"Stamina Boost",
	"Speed Boost",
	"Invisibility",
	"Invincibility",
	"Teleportation",
	"Stat Increase",
	"Stat Decrease",
	"XP Boost",
	"Currency Gain",
	"Summon Ally",
	"Reveal Map",
	"Unlock Door",
	"Dispel Magic",
	"Cure Poison",
	"Resurrection"
]
