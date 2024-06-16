@tool
extends Resource
class_name CheckListsData

var campains : Dictionary = {}

const launch_campain := [
	'launch_trailer', 'screenshots', 'tags',
	
	## Itch.io
	'itch_store',
	
	## Steam
	'steam_store',
	## Steam Features (IMPORTANT)
	'achievements', 'leaderboard', 'steamcloud', 'trading_cards', 'workshop', 'costumize',
	
	## Development
	'dev_page', 'localization', 'analytics', 'cloud_diagnostics', 
	
	### Special Testing
	'ui_resolutions', 'player_debug',
	### Misc
	'change_log', # txt - version, when, what
	'launch_discount'
	]
